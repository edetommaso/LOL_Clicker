import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ennemy_model.dart';
import '../viewmodels/game_viewmodel.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Monstre Clicker'),
        ),
        body: const GameBody(),
      ),
    );
  }
}

class GameBody extends StatelessWidget {
  const GameBody({super.key});

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);
    final enemy = gameViewModel.enemy;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image du monstre centrée et plus grande
          GestureDetector(
            onTap: () {
              gameViewModel.attackEnemy();
            },
            child: Image.asset(
              'assets/monster.png',
              width: 300, // Taille de l'image augmentée
              height: 300,
            ),
          ),
          const SizedBox(height: 20),

          // Barre de vie centrée et de largeur réduite
          Container(
            width: 300, // Largeur réduite de la barre de vie
            child: LinearProgressIndicator(
              value: enemy.currentLife / enemy.totalLife,
              backgroundColor: Colors.grey,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 10),

          // Affichage du niveau et des PV en dessous de la barre de vie
          Text(
            'Niveau: ${enemy.level} | PV: ${enemy.currentLife}/${enemy.totalLife}',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),

          // Affichage des dégâts infligés
          Text(
            'Dégâts infligés: ${gameViewModel.lastDamage}',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}