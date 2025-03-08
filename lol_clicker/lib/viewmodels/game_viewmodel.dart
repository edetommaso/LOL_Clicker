import 'package:flutter/material.dart';
import '../models/ennemy_model.dart';
import '../core/services/enemy_service.dart';

class GameViewModel extends ChangeNotifier {
  final EnemyRequest _enemyRequest = EnemyRequest();
  List<EnemyModel> _enemies = [];
  bool _isLoading = false;
  String _error = '';

  List<EnemyModel> get enemies => _enemies;
  bool get isLoading => _isLoading;
  String get error => _error;
  
  int _lastDamage = 0;
  int _monstersKilled = 0;
  int _coins = 0;
  
  EnemyModel get enemy => _enemies;
  int get lastDamage => _lastDamage;
  int get monstersKilled => _monstersKilled;
  int get coins => _coins;

  static int _calculateTotalLife(int level) {
    return 50 + (level * 50);
  }

  int _calculateCoinsEarned(int level) {
    return (10 * (1.25 * level) ~/ 1); // Exponential formula for coins
  }

  void attackEnemy() {
    _lastDamage = 10; // Fixed damage for the example
    _enemy.reduceLife(_lastDamage);

    if (_enemy.currentLife <= 0) {
      _monstersKilled++;
      _addCoins(_calculateCoinsEarned(_enemy.level));
      _spawnNewEnemy();
    }

    notifyListeners();
  }

  void _addCoins(int amount) {
    _coins += amount;
    notifyListeners();
  }

  void _spawnNewEnemy() {
    if (_monstersKilled >= 10) {
      int newLevel = _enemy.level + 1;
      _enemy = EnemyModel(
        name: 'Monstre',
        totalLife: _calculateTotalLife(newLevel),
        level: newLevel,
        experience: _enemy.experience, // Keep the same experience
        image: _enemy.image, // Keep the same image
      );
      _monstersKilled = 0;
    } else {
      _enemy = EnemyModel(
        name: 'Monstre',
        totalLife: _calculateTotalLife(_enemy.level),
        level: _enemy.level,
        experience: _enemy.experience,
        image: _enemy.image,
      );
    }

    _lastDamage = 0;
  }

  void resetGame() {
    _enemy = EnemyModel(
      name: 'Monstre',
      totalLife: _calculateTotalLife(1),
      level: 1,
      experience: 0,
      image: '',
    );
    _lastDamage = 0;
    _monstersKilled = 0;
    _coins = 0;
    notifyListeners();
  }

  // Fetch enemies from the server
  Future<void> fetchEnemies() async {
    _isLoading = true;
    notifyListeners();
    try {
      _enemies = await _enemyRequest.getEnemies();
    } catch (e) {
      _error = 'Error fetching enemies: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch a specific enemy by ID
  Future<void> fetchEnemyById(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _enemy = await _enemyRequest.getEnemyById(id) ?? _enemy;
    } catch (e) {
      _error = 'Error fetching enemy: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
