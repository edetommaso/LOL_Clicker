class EnemyModel {
  
  final String name;
  final int totalLife;
  final int level;
  late int currentLife;
  final int experience;
  final String image;
  
  EnemyModel({
  required this.name,
  required this.totalLife,
  required this.level,
  required this.experience,
  required this.image,
  }) {
  currentLife = totalLife;
  }
    
    factory EnemyModel.fromJson(Map<String, dynamic> json) {
    return EnemyModel(
      name: json['name'] ?? 'Nom inconnu',
      totalLife: json['totalLife'] ?? 'TotalLife inconnu',
      level: json['level'] ?? 'Level inconnu',
      experience: json['experience'] ?? 'Experience inconnue',
      image: json['image'] ?? 'Image inconnue',
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