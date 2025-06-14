import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager_app/models/categorie_model.dart';

class CategoryNotifier extends StateNotifier<List<Category>> {
  CategoryNotifier()
      : super([
          Category(id: '1', name: 'Social', color: '#FFA500', icon: '📱'),
          Category(id: '2', name: 'Work', color: '#4CAF50', icon: '💼'),
          Category(id: '3', name: 'Finance', color: '#2196F3', icon: '💰'),
        ]);

  void addCategory(Category category) {
    state = [...state, category];
  }

  void removeCategory(String id) {
    state = state.where((c) => c.id != id).toList();
  }

  void updateCategory(Category updated) {
    state = [
      for (final c in state)
        if (c.id == updated.id) updated else c,
    ];
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  return CategoryNotifier();
});
