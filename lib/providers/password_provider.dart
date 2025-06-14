import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager_app/models/password_model.dart';

// Sample data for now (you can connect this to Hive, Firebase, or your DB later)
final List<PasswordItem> samplePasswords = [
  PasswordItem(
    id: '1',
    label: 'Instagram',
    username: 'user123',
    password: 'encryptedPassword1',
    category: 'Social',
    icon: '📸',
    color: '#FF5733',
    createdAt: DateTime.now(),
    lastUpdated: DateTime.now(),
  ),
  PasswordItem(
    id: '2',
    label: 'Gmail',
    username: 'myemail@gmail.com',
    password: 'encryptedPassword2',
    category: 'Work',
    icon: '📧',
    color: '#33FFCE',
    createdAt: DateTime.now(),
    lastUpdated: DateTime.now(),
  ),
];

// StateNotifier to manage the list
class PasswordsNotifier extends StateNotifier<List<PasswordItem>> {
  PasswordsNotifier() : super(samplePasswords);

  void addPassword(PasswordItem item) {
    state = [...state, item];
  }

  void removePassword(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void updatePassword(PasswordItem updatedItem) {
    state = state
        .map((item) => item.id == updatedItem.id ? updatedItem : item)
        .toList();
  }
}

// Riverpod provider
final passwordsProvider =
    StateNotifierProvider<PasswordsNotifier, List<PasswordItem>>(
  (ref) => PasswordsNotifier(),
);
