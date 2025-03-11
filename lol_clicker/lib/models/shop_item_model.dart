class ShopItemModel {
  
  final String id;
  final String name;
  final String description;
  final int price;
  final String image;
  int purchaseCount;
  final String typeAmelioration;
  
  ShopItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.purchaseCount = 0,
    required this.typeAmelioration,
  });

  factory ShopItemModel.fromJson(Map<String, dynamic> json) {
    
    return ShopItemModel(
      id: json['id'].toString(),
      name: json['name']?.toString() ?? 'Nom inconnu',
      description: json['description']?.toString() ?? 'Aucune description',
      price: json['price'] is int ? json['price'] : int.tryParse(json['price'].toString()) ?? 0,
      image: json['image']?.toString() ?? '',
      typeAmelioration: json['type_name']?.toString() ?? 'Type inconnu',
    );
  }
}