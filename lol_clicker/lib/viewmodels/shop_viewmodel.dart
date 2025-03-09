// lib/viewmodels/shop_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/shop_item_model.dart';
import 'game_viewmodel.dart';

class ShopViewModel extends ChangeNotifier {
  List<ShopItemModel> _items = [
    ShopItemModel(
      id: '1',
      name: 'Long Sword',
      description: 'aaa',
      price: 35,
      imagePath: 'assets/items/LongSword.png',
    ),
    ShopItemModel(
      id: '2',
      name: 'Caulfield`s Warhammer',
      description: 'aaa',
      price: 105,
      imagePath: 'assets/items/warhammer.png',
    ),
    ShopItemModel(
      id: '3',
      name: 'Last Whisper',
      description: 'aaa',
      price: 300,
      imagePath: 'assets/items/whisper.png',
    ),
    ShopItemModel(
      id: '4',
      name: 'B. F. Sword',
      description: 'aaa',
      price: 650,
      imagePath: 'assets/items/BFSword.png',
    ),
    ShopItemModel(
      id: '5',
      name: 'Kraken Slayer',
      description: 'aaa',
      price: 800,
      imagePath: 'assets/items/kraken.png',
    ),
    ShopItemModel(
      id: '6',
      name: 'Infinity Edge',
      description: 'aaa',
      price: 999,
      imagePath: 'assets/items/infinity.png',
    ),
    ShopItemModel(
      id: '7',
      name: 'The Collector',
      description: 'aaa',
      price: 1500,
      imagePath: 'assets/items/collector.png',
    ),
  ];

  List<ShopItemModel> get items => _items;

  String?
      _errorMessage; // Message d'erreur si le joueur n'a pas assez de pièces

  String? get errorMessage => _errorMessage;

  // Méthode pour acheter un item
  // lib/viewmodels/shop_viewmodel.dart
  void buyItem(String itemId, GameViewModel gameViewModel) {
    final item = _items.firstWhere((item) => item.id == itemId);
    if (gameViewModel.coins >= item.price) {
      // Retirer le prix de l'item des pièces du joueur
      gameViewModel.removeCoins(item.price);
      item.purchaseCount++; // Incrémenter le nombre d'achats
      _errorMessage = null; // Réinitialiser le message d'erreur

      // Mettre à jour le DPS en fonction de l'item acheté
      gameViewModel.updateDps(
          gameViewModel.dps + (item.price ~/ 10)); // Exemple de calcul de DPS

      print('Item acheté: ${item.name} (Acheté ${item.purchaseCount} fois)');
    } else {
      _errorMessage =
          'Pas assez de pièces pour acheter ${item.name}'; // Message d'erreur
    }
    notifyListeners();
  }
}
