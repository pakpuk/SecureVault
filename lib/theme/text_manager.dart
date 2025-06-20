import 'package:flutter/material.dart';

class TextManger {
  static String Username = "Ahmed";
  static String Categorytit = "Category";
  static const String searchHint = "Rechercher un mot de passe";
  static const String goodMorning = "Bonjour";
  static const String goodAfternoon = "Bon après-midi";
  static const String goodEvening = "Bonsoir";
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return goodMorning;
    if (hour < 18) return goodAfternoon;
    return goodEvening;
  }
}
