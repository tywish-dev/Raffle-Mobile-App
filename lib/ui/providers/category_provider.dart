import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  int _selectedIndex = 0;
  String? _value = "Koleksiyon";

  int get getSelectedIndex => _selectedIndex;
  String get getValue => _value!;

  setSelectedIndex(int i) {
    _selectedIndex = i;
    notifyListeners();
  }

  setValue(String newVal) {
    _value = newVal;
    notifyListeners();
  }

  String fixCategoryName(String categoryName) {
    switch (categoryName) {
      case "vehicles":
        return "Taşıtlar";
      case "furnishing":
        return "Ev Eşyaları";
      case "tech":
        return "Teknoloji";
      case "collection":
        return "Koleksiyon";
      case "secondHand":
        return "İkinci El";
      default:
        return "";
    }
  }

  String undoCategoryName(String categoryName) {
    switch (categoryName) {
      case "Taşıtlar":
        return "vehicles";
      case "Ev Eşyaları":
        return "furnishing";
      case "Teknoloji":
        return "tech";
      case "Koleksiyon":
        return "collection";
      case "İkinci El":
        return "secondHand";
      default:
        return "";
    }
  }
}
