// lib/viewmodels/shop_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/shop_item_model.dart';

class ShopViewModel extends ChangeNotifier {
  List<ShopItemModel> _items = [
    ShopItemModel(
      id: '1',
      name: 'Épée en bois',
      description: 'Augmente les dégâts de 10.',
      price: 50,
    ),
    ShopItemModel(
      id: '2',
      name: 'Bouclier en fer',
      description: 'Réduit les dégâts reçus de 5.',
      price: 100,
    ),
  ];

  List<ShopItemModel> get items => _items;

  void buyItem(String itemId) {
    // Logique pour acheter un item (à implémenter)
    print('Item acheté: $itemId');
    notifyListeners();
  }
}