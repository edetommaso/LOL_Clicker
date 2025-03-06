import 'package:flutter/material.dart';
import '../models/ennemy_model.dart';

class GameViewModel extends ChangeNotifier {
  EnemyModel _enemy = EnemyModel(name: 'Monstre', totalLife: 100, level: 1);
  int _lastDamage = 0;
  int _monstersKilled = 0; // Compteur de monstres tués

  EnemyModel get enemy => _enemy;
  int get lastDamage => _lastDamage;
  int get monstersKilled => _monstersKilled;

  void attackEnemy() {
    _lastDamage = 10; // Dégâts fixes pour l'exemple
    _enemy.reduceLife(_lastDamage);

    // Vérifier si l'ennemi est mort
    if (_enemy.currentLife <= 0) {
      _monstersKilled++; // Incrémenter le compteur de monstres tués
      _spawnNewEnemy();
    }

    notifyListeners();
  }

  void _spawnNewEnemy() {
    // Vérifier si 10 monstres ont été tués pour augmenter le niveau
    if (_monstersKilled >= 10) {
      _enemy = EnemyModel(
        name: 'Monstre',
        totalLife: _enemy.totalLife + 50, // Augmenter les PV de 50
        level: _enemy.level + 1, // Augmenter le niveau de 1
      );
      _monstersKilled = 0; // Réinitialiser le compteur
    } else {
      // Sinon, créer un nouvel ennemi avec les mêmes caractéristiques
      _enemy = EnemyModel(
        name: 'Monstre',
        totalLife: _enemy.totalLife,
        level: _enemy.level,
      );
    }

    // Réinitialiser les dégâts infligés
    _lastDamage = 0;
  }

  void resetGame() {
    _enemy = EnemyModel(name: 'Monstre', totalLife: 100, level: 1);
    _lastDamage = 0;
    _monstersKilled = 0;
    notifyListeners();
  }
}