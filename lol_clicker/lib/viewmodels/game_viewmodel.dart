// lib/viewmodels/game_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/ennemy_model.dart';

class GameViewModel extends ChangeNotifier {
  EnemyModel _enemy =
      EnemyModel(name: 'Monstre', totalLife: _calculateTotalLife(1), level: 1);
  int _lastDamage = 0;
  int _monstersKilled = 0;
  int _coins = 0;

  // Liste des images de monstres
  final List<String> _monsterImages = [
    'assets/monster1.png',
    'assets/monster2.png',
    'assets/monster3.png',
    'assets/monster4.png',
    // Ajoutez autant d'images de monstres que vous le souhaitez
  ];
  int _currentMonsterIndex = 0;

  EnemyModel get enemy => _enemy;
  int get lastDamage => _lastDamage;
  int get monstersKilled => _monstersKilled;
  int get coins => _coins;
  String get currentMonsterImage => _monsterImages[_currentMonsterIndex];

  // Formule pour calculer les PV totaux en fonction du niveau
  static int _calculateTotalLife(int level) {
    return 50 + (level * 50);
  }

  // Formule pour calculer l'argent gagné en fonction du niveau (10 * (1.35 ^ niveau))
  int _calculateCoinsEarned(int level) {
    return (10 *
        (1.25 * (level)) ~/
        1); // Utilisation de la formule exponentielle
  }

  void attackEnemy() {
    _lastDamage = 10; // Dégâts fixes pour l'exemple
    _enemy.reduceLife(_lastDamage);

    // Vérifier si l'ennemi est mort
    if (_enemy.currentLife <= 0) {
      _monstersKilled++; // Incrémenter le compteur de monstres tués
      _addCoins(_calculateCoinsEarned(_enemy.level)); // Ajouter l'argent gagné
      _spawnNewEnemy(_currentMonsterIndex);
      _changeMonsterImage();
    }

    notifyListeners();
  }

  void _addCoins(int amount) {
    _coins += amount; // Ajouter des pièces au solde
    notifyListeners();
  }

  void _spawnNewEnemy(int currentMonsterIndex) {
    // Vérifier si 10 monstres ont été tués pour augmenter le niveau
    if (_monstersKilled >= 10) {
      int newLevel = _enemy.level + 1; // Augmenter le niveau de 1
      _enemy = EnemyModel(
        name: 'Monstre',
        totalLife: _calculateTotalLife(
            newLevel), // Calculer les PV en fonction du nouveau niveau
        level: newLevel,
      );
      _monstersKilled = 0; // Réinitialiser le compteur
    } else {
      // Sinon, créer un nouvel ennemi avec les mêmes caractéristiques
      _enemy = EnemyModel(
        name: 'Monstre',
        totalLife: _calculateTotalLife(_enemy.level), // Recalculer les PV
        level: _enemy.level,
      );
    }
    resetEnemyLife();

    // Réinitialiser les dégâts infligés
    _lastDamage = 0;
    notifyListeners();
  }

  void resetGame() {
    _enemy = EnemyModel(
        name: 'Monstre', totalLife: _calculateTotalLife(1), level: 1);
    _lastDamage = 0;
    _monstersKilled = 0;
    _coins = 0; // Réinitialiser le solde de pièces
    notifyListeners();
  }

  void resetEnemyLife() {
    enemy.currentLife = enemy.totalLife;
    notifyListeners();
  }

  void _changeMonsterImage() {
    _currentMonsterIndex = (_currentMonsterIndex + 1) % _monsterImages.length;
    notifyListeners();
  }
}
