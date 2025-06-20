import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager_app/models/categorie_model.dart';
import 'package:password_manager_app/providers/category_provider.dart';
import 'package:password_manager_app/providers/password_provider.dart';
import 'package:password_manager_app/view/widgets/addedit_categorie.dart';
import 'package:password_manager_app/view/widgets/categorie_title.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);
    final passwords = ref.watch(passwordsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer les catégories'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddCategoryDialog(context, ref),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vos catégories (${categories.length})',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Organisez vos mots de passe par catégories',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final categoryPasswordCount = passwords
                      .where((p) => p.category == category.name)
                      .length;

                  return CategoryTile(
                    category: category,
                    passwordCount: categoryPasswordCount,
                    onEdit: () =>
                        _showEditCategoryDialog(context, ref, category),
                    onDelete: () => _showDeleteConfirmation(
                      context,
                      ref,
                      category,
                      categoryPasswordCount,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AddEditCategoryDialog(
        onSave: (name, color, icon) {
          final newCategory = Category(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: name,
            color: color,
            icon: icon,
          );
          ref.read(categoryProvider.notifier).addCategory(newCategory);
        },
      ),
    );
  }

  void _showEditCategoryDialog(
      BuildContext context, WidgetRef ref, Category category) {
    showDialog(
      context: context,
      builder: (context) => AddEditCategoryDialog(
        category: category,
        onSave: (name, color, icon) {
          final updatedCategory = category.copyWith(
            name: name,
            color: color,
            icon: icon,
          );
          ref.read(categoryProvider.notifier).updateCategory(updatedCategory);
        },
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    Category category,
    int passwordCount,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la catégorie'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Êtes-vous sûr de vouloir supprimer la catégorie "${category.name}" ?'),
            if (passwordCount > 0) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning,
                        color: Colors.orange.shade700, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '$passwordCount mot(s) de passe seront déplacés vers "Non catégorisé"',
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(categoryProvider.notifier).removeCategory(category.id);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Catégorie "${category.name}" supprimée')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }
}
