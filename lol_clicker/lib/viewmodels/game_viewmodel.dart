import 'package:flutter/material.dart';
import '../models/ennemy_model.dart';
import '../core/services/enemy_service.dart';

class GameViewModel extends ChangeNotifier {

  final EnemyRequest _enemyRequest = EnemyRequest();
  List<EnemyModel> _enemies = [];
  late EnemyModel _enemy;
  
  bool _isLoading = false;
  String _error = '';
  int _level = 1; // Increment des niveaux de monstres qui sera incrementer tous les 10 monstres tuées
  int _damage = 1;
  int _monstersKilled = 0;
  int _coins = 0;
  
  EnemyModel get enemy => _enemy;
  bool get isLoading => _isLoading;
  String get error => _error;
  int get damage => _damage;
  int get monstersKilled => _monstersKilled;
  int get coins => _coins;
  int get level => _level;
  
  GameViewModel(){
    fetchEnemies();
  }
    
  int _calculateTotalLife() {
    return (_level * _enemy.intialLife);
  }
  
  void _life(){
    _enemy.totalLife = _calculateTotalLife();
    _enemy.currentLife = _enemy.totalLife;
  }
  
  int _calculateCoinsEarned() {
    return (_enemy.experience * _level);
  }
  
  void attackEnemy() {
    
    _enemy.reduceLife(_damage);
    
    if (_enemy.currentLife <= 0) {
      _monstersKilled++;
      _addCoins(_calculateCoinsEarned());
      _enemy.currentLife = _enemy.totalLife;
      _spawnNewEnemy();
    }
    
    notifyListeners();
  
  }
  
  void _addCoins(int amount) {
    _coins += amount;
    notifyListeners();
  }
  
  Future<void> _spawnNewEnemy() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      int currentIndex = _enemies.indexWhere((enemy) => enemy.id == _enemy.id);
      
      if (currentIndex != -1 && currentIndex + 1 < _enemies.length) {
        _enemy = _enemies[currentIndex + 1];
      } else {
        _enemy = _enemies.first;
      }
      
      // Incrémenter le niveau si 10 monstres ont été tués
      if (_monstersKilled % 10 == 0) {
        _monstersKilled = 0;
        _level += 1;
        
        // Mettre à jour la vie de l'ennemi en fonction du nouveau niveau
        _enemy.totalLife = _calculateTotalLife();
        _enemy.currentLife = _enemy.totalLife;
      } else {
        // Mettre à jour la vie de l'ennemi en fonction du niveau actuel
        _enemy.totalLife = _calculateTotalLife();
        _enemy.currentLife = _enemy.totalLife;
      }
    } catch (e) {
      _error = 'Error spawning new enemy: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void resetGame() {
    fetchEnemyById(1);
    _damage = 1;
    _monstersKilled = 0;
    _coins = 0;
    _level = 1;
    _life();
    notifyListeners();
  }
  
  Future<void> fetchEnemies() async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    try {
      List<EnemyModel> enemies = await _enemyRequest.getEnemies();
      if (enemies.isNotEmpty) {
        _enemies = enemies;
        _enemy = enemies.first;
        
        // Mettre à jour la vie de l'ennemi en fonction du niveau
        _enemy.totalLife = _calculateTotalLife();
        _enemy.currentLife = _enemy.totalLife;
      } else {
        _error = 'No enemies found';
      }
    } catch (e) {
      _error = 'Error fetching enemies: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> fetchEnemyById(int id) async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    try {
      EnemyModel? fetchedEnemy = await _enemyRequest.getEnemyById(id);
      if (fetchedEnemy != null) {
        _enemy = fetchedEnemy;
        
        // Mettre à jour la vie de l'ennemi en fonction du niveau
        _enemy.totalLife = _calculateTotalLife();
        _enemy.currentLife = _enemy.totalLife;
      } else {
        _error = 'Enemy not found';
      }
    } catch (e) {
      _error = 'Error fetching enemy: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
