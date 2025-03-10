// lib/viewmodels/shop_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:lol_clicker/core/services/shop_item_service.dart';
import '../models/shop_item_model.dart';
import 'game_viewmodel.dart';

class ShopViewModel extends ChangeNotifier {
  
  final ShopItemRequest _itemRequest = ShopItemRequest();
  List<ShopItemModel> _items = [];
  bool _isLoading = false;
  
  List<ShopItemModel> get items => _items;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  
  // Constructeur avec chargement des items
  ShopViewModel() {
    loadItems();
  }
  
  // Méthode pour acheter un item
  void buyItem(String itemId, GameViewModel gameViewModel) {
    final item = _items.firstWhere(
      (item) => item.id == itemId
    );
    
    if (item.id == "-1") {
      _errorMessage = "Item non trouvé";
      notifyListeners();
      return;
    }
    
    if (gameViewModel.coins >= item.price) {
      // Retirer le prix de l'item des pièces du joueur
      gameViewModel.removeCoins(item.price);
      item.purchaseCount++; 
      _errorMessage = null;
      
      // Mettre à jour le DPS
      gameViewModel.updateDps(gameViewModel.damage + (item.price ~/ 10)); 
      print('Item acheté: ${item.name} (Acheté ${item.purchaseCount} fois)');
    } else {
      _errorMessage = 'Pas assez de pièces pour acheter ${item.name}';
    }
    notifyListeners();
  }
  

  // Méthode publique pour charger les items
  Future<void> loadItems() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      print("Chargement des items...");
      _items = await _itemRequest.getShopItems(); // Utiliser la méthode correcte
      print("Items chargés: ${_items.length}");
      
      // Pour le débogage
      for (var item in _items) {
        print("Item: ${item.name}, prix: ${item.price}, image: ${item.image}");
      }
      
    } catch (e) {
      print("Erreur de chargement: $e");
      _errorMessage = "Erreur lors du chargement des items: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}