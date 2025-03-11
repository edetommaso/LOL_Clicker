class EnemyModel {
  final int id;
  final int categorie;
  final String name;
  final int intialLife;
  int totalLife;
  
  late int currentLife;
  int experience;
  final String image;
  
  EnemyModel({
  required this.id,
  required this.categorie,
  required this.name,
  required this.totalLife,
  required this.intialLife,
  required this.experience,
  required this.image,
  }) {
  currentLife = totalLife;
  
  }
    
  factory EnemyModel.fromJson(Map<String, dynamic> json) {
    return EnemyModel(
      id: json['id'] ?? 0,
      name: json['name'] as String? ?? 'Nom inconnu',
      intialLife: json['total_life'] as int,
      totalLife: json['total_life'] as int? ?? 100,
      categorie: json['categorie'] as int? ?? 1,
      experience: json['experience'] as int? ?? 0,
      image: json['image'] as String? ?? 'default_image.png',
    );
  }
  
  reduceLife(int degats){
    
    if (currentLife-degats>0){
      currentLife-=degats;
    }else{
      currentLife=0;
    }
  }

}