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
        appBar: null,
        body: Column(
          children: [
            // Header personnalisé avec logo et titre
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.deepPurple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'League of Clicker',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Corps de la page (le jeu)
            const Expanded(
              child: GameBody(),
            ),
          ],
        ),
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
          // Compteur de monstres tués en haut de l'image
          Text(
            'Monstres tués: ${gameViewModel.monstersKilled}/10',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Image du monstre
          GestureDetector(
            onTap: () {
              gameViewModel.attackEnemy();
            },
            child: Image.asset(
              'assets/monster.png',
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(height: 20),

          // Barre de vie
          Container(
            width: 300,
            child: LinearProgressIndicator(
              value: enemy.currentLife / enemy.totalLife,
              backgroundColor: Colors.grey,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 10),

          // Affichage du niveau et des PV
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

          // Message temporaire lors du spawn d'un nouvel ennemi
          if (gameViewModel.lastDamage == 0 && enemy.currentLife == enemy.totalLife)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Nouveau monstre !',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }
}