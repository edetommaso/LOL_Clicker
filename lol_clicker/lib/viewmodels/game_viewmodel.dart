import 'package:flutter/material.dart';
import '../models/ennemy_model.dart';
import '../core/services/enemy_service.dart';
import 'dart:async';

class GameViewModel extends ChangeNotifier {

  final EnemyRequest _enemyRequest = EnemyRequest();
  List<EnemyModel> _enemies = [];
  late EnemyModel _enemy;
  
  bool _isLoading = false;
  String _error = '';
  int _level = 1;
  int _damage = 1;
  int _monstersKilled = 0;
  int _coins = 0;
  int _coin_per_click = 1;
  int _helperDps = 0;
  Timer? _autoAttackTimer;
  
  EnemyModel get enemy => _enemy;
  bool get isLoading => _isLoading;
  int get coin_per_click => _coin_per_click;
  String get error => _error;
  int get damage => _damage;
  int get monstersKilled => _monstersKilled;
  int get coins => _coins;
  int get level => _level;
  int get helperDps => _helperDps;
  
  GameViewModel(){
    fetchEnemies();
    _startAutoAttack();
  }

  void _startAutoAttack() {
    _autoAttackTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_helperDps > 0) {
        attackEnemyFromHelper();
      }
    });
  }

  void attackEnemyFromHelper() {
    _enemy.reduceLife(_helperDps);
    _addCoins(_helperDps ~/ 2);
    if (_enemy.currentLife <= 0) {
      _monstersKilled++;
      _addCoins(_calculateCoinsEarned());
      _enemy.currentLife = _enemy.totalLife;
      _spawnNewEnemy();
    }
    notifyListeners();
  }

  void addHelperDps(int dps) {
    _helperDps += dps;
    notifyListeners();
  }

  @override
  void dispose() {
    _autoAttackTimer?.cancel();
    super.dispose();
  }
    
  int _calculateTotalLife() {
    return (_level *_level* _enemy.intialLife);
  }
  
  int _calculateCoinsEarned() {
    return (_enemy.experience * _level ~/ 2);
  }
  
  void attackEnemy() {
    
    _enemy.reduceLife(_damage);
    _addCoins(_coin_per_click);
    
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
      
      if (_monstersKilled % 10 == 0) {
        _monstersKilled = 0;
        _level += 1;
        
        _enemy.totalLife = _calculateTotalLife();
        _enemy.currentLife = _enemy.totalLife;
      } else {
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
  
  Future<void> fetchEnemies() async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    try {
      List<EnemyModel> enemies = await _enemyRequest.getEnemies();
      if (enemies.isNotEmpty) {
        _enemies = enemies;
        _enemy = enemies.first;
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
    
    void removeCoins(int amount) {
    _coins -= amount;
    notifyListeners();
  }
  
  void updateDps(int newDps) {
    _damage += newDps;
    notifyListeners();
  }
  
  void updateCoinPerClick(int upgrade){
    _coin_per_click+= upgrade;
    notifyListeners();
  }


}
