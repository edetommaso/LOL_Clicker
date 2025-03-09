class ShopItemModel {
  
  final String id;
  final String name;
  final String description;
  final int price;
  final String image;
  int purchaseCount;
  
  ShopItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.purchaseCount = 0,
  });

  factory ShopItemModel.fromJson(Map<String, dynamic> json) {
    return ShopItemModel(
      id: json['id'] ?? 0,
      name: json['name'] as String? ?? 'Nom inconnu',
      description: json['description'] as String,
      price: json['price'] as int? ?? 1, // Valeur par défaut pour totalLife
      image: json['image'] as String,
    );
  }
}