class EnemyModel {


  final String name;
  final int totalLife;
  final int level;
  late int currentLife;


  EnemyModel({
  required this.name,
   required this.totalLife,
  required this.level,
  }) {
  currentLife = totalLife;
  }

  reduceLife(int degats){
    
    if (currentLife-degats>0){
      currentLife-=degats;
    }else{
      currentLife=0;
    }
  }

}