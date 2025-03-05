import 'package:flutter/material.dart';
import '../models/ennemy_model.dart';

class GameViewModel extends ChangeNotifier {
  EnemyModel _enemy = EnemyModel(name: 'Monstre', totalLife: 100, level: 1);
  int _lastDamage = 0;

  EnemyModel get enemy => _enemy;
  int get lastDamage => _lastDamage;

  void attackEnemy() {
    _lastDamage = 10; // Dégâts fixes pour l'exemple
    _enemy.reduceLife(_lastDamage);

    // Vérifier si l'ennemi est mort
    if (_enemy.currentLife <= 0) {
      _spawnNewEnemy();
    }

    notifyListeners();
  }

  void _spawnNewEnemy() {
    // Créer un nouvel ennemi avec un niveau supérieur et plus de PV
    _enemy = EnemyModel(
      name: 'Monstre',
      totalLife: _enemy.totalLife + 50, // Augmenter les PV de 50 à chaque spawn
      level: _enemy.level + 1, // Augmenter le niveau de 1
    );

    // Réinitialiser les dégâts infligés
    _lastDamage = 0;
  }

  void resetGame() {
    _enemy = EnemyModel(name: 'Monstre', totalLife: 100, level: 1);
    _lastDamage = 0;
    notifyListeners();
  }
}