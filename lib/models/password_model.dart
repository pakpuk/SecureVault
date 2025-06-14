class PasswordItem {
  final String id;
  final String label;
  final String username;
  final String password;
  final String category;
  final String icon;
  final String color;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final bool isPinned;
  final bool isFavorite;
  final bool isHidden;

  PasswordItem({
    required this.id,
    required this.label,
    required this.username,
    required this.password,
    required this.category,
    required this.icon,
    required this.color,
    required this.createdAt,
    required this.lastUpdated,
    this.isPinned = false,
    this.isFavorite = false,
    this.isHidden = true,
  });

  PasswordItem copyWith({
    String? label,
    String? username,
    String? password,
    String? category,
    String? icon,
    String? color,
    bool? isPinned,
    bool? isFavorite,
    bool? isHidden,
    DateTime? lastUpdated,
  }) {
    return PasswordItem(
      id: id,
      label: label ?? this.label,
      username: username ?? this.username,
      password: password ?? this.password,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      createdAt: createdAt,
      lastUpdated: lastUpdated ?? DateTime.now(),
      isPinned: isPinned ?? this.isPinned,
      isFavorite: isFavorite ?? this.isFavorite,
      isHidden: isHidden ?? this.isHidden,
    );
  }
}
