// lib/models/helper_model.dart
class HelperModel {
  final String id;
  final String name;
  final String description;
  final int price; // Prix en coins pour acheter le helper
  final String image;
  final int dps; // Dégâts par seconde infligés par le helper
  int purchaseCount; // Nombre de fois que ce helper a été acheté

  HelperModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.dps,
    this.purchaseCount = 0,
  });

  factory HelperModel.fromJson(Map<String, dynamic> json) {
    return HelperModel(
      id: json['id'].toString(),
      name: json['name']?.toString() ?? 'Nom inconnu',
      description: json['description']?.toString() ?? 'Aucune description',
      price: json['price'] is int ? json['price'] : int.tryParse(json['price'].toString()) ?? 0,
      image: json['image']?.toString() ?? '',
      dps: json['dps'] is int ? json['dps'] : int.tryParse(json['dps'].toString()) ?? 0,
    );
  }
}