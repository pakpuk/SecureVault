import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager_app/providers/password_provider.dart';
import 'package:password_manager_app/providers/category_provider.dart';

import 'package:password_manager_app/theme/text_manager.dart';
import 'package:password_manager_app/view/screens/categorie_screen.dart';
import 'package:password_manager_app/view/widgets/Categorie_widget.dart';
import 'package:password_manager_app/view/widgets/app_bar_icon.dart';
import 'package:password_manager_app/view/widgets/password_container_widget.dart';
import 'package:password_manager_app/view/widgets/profile_widgerapp_bar.dart';
import 'package:password_manager_app/view/widgets/search_wdget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwords = ref.watch(passwordsProvider);
    final categories = ref.watch(categoryProvider);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPasswordModal(context),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec profil et notifications
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ProfileWidgerappBar(),
                  AppBarIcon(
                    icon: Icons.notifications_none,
                    onTap: () => _showNotifications(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Barre de recherche
              const SearchWidget(),
              const SizedBox(height: 24),

              // Section catégories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    TextManger.Categorytit,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton(
                    onPressed: () => _navigateToCategories(context),
                    child: const Text('Voir tout'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Grille des catégories
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final categoryPasswords = passwords
                        .where((p) => p.category == category.name)
                        .length;

                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: CategoryCard(
                        category: category,
                        passwordCount: categoryPasswords,
                        onTap: () => _filterByCategory(context, category.name),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Liste des mots de passe
              Text(
                'Vos mots de passe (${passwords.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: passwords.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.builder(
                        itemCount: passwords.length,
                        itemBuilder: (context, index) {
                          final password = passwords[index];
                          return PasswordCard(password: password);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun mot de passe enregistré',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Appuyez sur + pour ajouter votre premier mot de passe',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade500,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showAddPasswordModal(BuildContext context) {
    // TODO: Implémenter le modal d'ajout
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: const Text('Modal d\'ajout de mot de passe - À implémenter'),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    // TODO: Implémenter les notifications
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notifications - À implémenter')),
    );
  }

  void _navigateToCategories(BuildContext context) {
    // TODO: Navigation vers la page de gestion des catégories
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const CategoriesScreen()),
    );
  }

  void _filterByCategory(BuildContext context, String categoryName) {
    // TODO: Implémenter le filtrage par catégorie
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Filtrer par: $categoryName')),
    );
  }
}
