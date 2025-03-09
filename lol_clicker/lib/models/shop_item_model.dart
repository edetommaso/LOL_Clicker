// lib/models/shop_item_model.dart
class ShopItemModel {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imagePath;
  int purchaseCount; // Nombre de fois que l'item a été acheté

  ShopItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.purchaseCount = 0, // Initialisé à 0 par défaut
  });
}