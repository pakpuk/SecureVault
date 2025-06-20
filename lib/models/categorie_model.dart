import 'package:flutter/widgets.dart';

class Category {
  final String id;
  final String name;
  final String color;
  final String icon;

  Category({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  // Méthode pour copier avec modifications
  Category copyWith({
    String? name,
    String? color,
    String? icon,
  }) {
    return Category(
      id: id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  Color get colorValue {
    final hexCode = color.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  @override
  String toString() =>
      'Category(id: $id, name: $name, color: $color, icon: $icon)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
