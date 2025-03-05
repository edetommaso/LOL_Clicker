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
    notifyListeners();
  }

  void resetGame() {
    _enemy = EnemyModel(name: 'Monstre', totalLife: 100, level: 1);
    _lastDamage = 0;
    notifyListeners();
  }
}