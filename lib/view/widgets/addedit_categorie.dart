import 'package:flutter/material.dart';
import 'package:password_manager_app/models/categorie_model.dart';

class AddEditCategoryDialog extends StatefulWidget {
  final Category? category;
  final Function(String name, String color, String icon) onSave;

  const AddEditCategoryDialog({
    super.key,
    this.category,
    required this.onSave,
  });

  @override
  State<AddEditCategoryDialog> createState() => _AddEditCategoryDialogState();
}

class _AddEditCategoryDialogState extends State<AddEditCategoryDialog> {
  late TextEditingController _nameController;
  String _selectedColor = '#2196F3';
  String _selectedIcon = '📁';

  final List<String> _availableColors = [
    '#2196F3',
    '#4CAF50',
    '#FFA500',
    '#9C27B0',
    '#F44336',
    '#FF9800',
    '#795548',
    '#607D8B',
    '#E91E63',
    '#00BCD4',
  ];

  final List<String> _availableIcons = [
    '📱',
    '💼',
    '💰',
    '🌐',
    '📧',
    '🎮',
    '🏠',
    '🚗',
    '✈️',
    '🏥',
    '📚',
    '🛒',
    '🎵',
    '📷',
    '🔧',
    '⚽',
    '🍕',
    '☕',
    '🎬',
    '💡',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name ?? '');
    _selectedColor = widget.category?.color ?? '#2196F3';
    _selectedIcon = widget.category?.icon ?? '📁';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.category != null;

    return AlertDialog(
      title: Text(isEditing ? 'Modifier la catégorie' : 'Nouvelle catégorie'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nom de la catégorie
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom de la catégorie',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Couleur
            const Text('Couleur:',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _availableColors.map((color) {
                final isSelected = color == _selectedColor;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = color),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(int.parse('FF${color.replaceAll('#', '')}',
                          radix: 16)),
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 3)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Icône
            const Text('Icône:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              height: 200,
              width: double.maxFinite,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: _availableIcons.length,
                itemBuilder: (context, index) {
                  final icon = _availableIcons[index];
                  final isSelected = icon == _selectedIcon;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIcon = icon),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blue.shade100
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? Border.all(color: Colors.blue, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(icon, style: const TextStyle(fontSize: 24)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.trim().isNotEmpty) {
              widget.onSave(
                  _nameController.text.trim(), _selectedColor, _selectedIcon);
              Navigator.of(context).pop();
            }
          },
          child: Text(isEditing ? 'Modifier' : 'Créer'),
        ),
      ],
    );
  }
}
