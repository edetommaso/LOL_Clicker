// lib/views/game_body.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';
import '../viewmodels/shop_viewmodel.dart';

class GameBody extends StatelessWidget {
  const GameBody({super.key});

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);
    final shopViewModel = Provider.of<ShopViewModel>(context);
    final enemy = gameViewModel.enemy;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Compteur de monstres tués
          Text(
            'Monstres tués: ${gameViewModel.monstersKilled}/10',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),

          // Image du monstre
          GestureDetector(
            onTap: () {
              gameViewModel.attackEnemy(shopViewModel.items); // Passer les items achetés
            },
            child: Image.asset(
              gameViewModel.currentMonsterImage,
              width: 500,
              height: 500,
            ),
          ),
          const SizedBox(height: 20),

          // Barre de vie
          Container(
            width: 300,
            child: LinearProgressIndicator(
              value: enemy.currentLife / enemy.totalLife,
              backgroundColor: Colors.red,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 10),

          // Affichage du niveau et des PV
          Text(
            'Niveau: ${enemy.level} | PV: ${enemy.currentLife}/${enemy.totalLife}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}