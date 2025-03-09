// lib/viewmodels/shop_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:lol_clicker/core/services/shop_item_service.dart';
import '../models/shop_item_model.dart';
import 'game_viewmodel.dart';

class ShopViewModel extends ChangeNotifier {
  
  final ShopItemRequest _itemRequest = ShopItemRequest();
  List<ShopItemModel> _items = [];
  
  List<ShopItemModel> get items => _items;
  
  String?
      _errorMessage; // Message d'erreur si le joueur n'a pas assez de pièces
  
  String? get errorMessage => _errorMessage;
  
  // Méthode pour acheter un item
  
  void buyItem(String itemId, GameViewModel gameViewModel) {
    final item = _items.firstWhere((item) => item.id == itemId);
    if (gameViewModel.coins >= item.price) {
      // Retirer le prix de l'item des pièces du joueur
      gameViewModel.removeCoins(item.price);
      item.purchaseCount++; // Incrémenter le nombre d'achats
      _errorMessage = null; // Réinitialiser le message d'erreur
      
      // Mettre à jour le DPS en fonction de l'item acheté
      gameViewModel.updateDps(
      gameViewModel.damage + (item.price ~/ 10)); // Exemple de calcul de DPS
      print('Item acheté: ${item.name} (Acheté ${item.purchaseCount} fois)');
    } else {
      _errorMessage =
          'Pas assez de pièces pour acheter ${item.name}'; // Message d'erreur
    }
    notifyListeners();
  }
}