import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:password_manager_app/models/categorie_model.dart';
import 'package:password_manager_app/models/password_model.dart';
import 'package:password_manager_app/providers/category_provider.dart';
import 'package:password_manager_app/providers/password_visibility_provider.dart';

class PasswordCard extends ConsumerWidget {
  final PasswordItem password;

  const PasswordCard({super.key, required this.password});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(passwordVisibilityProvider(password.id));
    final formattedDate = DateFormat.yMMMd().format(password.createdAt);
    final categoryProvider =
        StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
      return CategoryNotifier();
    });

    final category = ref.watch(categoryProvider).firstWhere(
        (c) => c.name == password.category,
        orElse: () =>
            Category(id: '0', name: 'Unknown', color: '#999999', icon: '🔐'));

    final bgColor = _hexToColor(category.color);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: bgColor, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Pin/Fav
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(category.icon, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(password.label,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
              Row(
                children: [
                  if (password.isPinned)
                    const Icon(Icons.push_pin, size: 18, color: Colors.orange),
                  if (password.isFavorite)
                    const Icon(Icons.star, size: 18, color: Colors.amber),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text("👤 ${password.username}", style: const TextStyle(fontSize: 15)),

          Row(
            children: [
              const Text("🔑 "),
              isVisible ? Text(password.password) : const Text('••••••••'),
              IconButton(
                icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility,
                    size: 20),
                onPressed: () {
                  ref
                      .read(passwordVisibilityProvider(password.id).notifier)
                      .state = !isVisible;
                },
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 20),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: password.password));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password copied!')),
                  );
                },
              )
            ],
          ),

          const SizedBox(height: 4),
          Text("📅 ${formattedDate}",
              style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }

  Color _hexToColor(String hex) {
    final hexCode = hex.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
