// lib/views/game_body.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';

class GameBody extends StatefulWidget {
  const GameBody({super.key});

  @override
  State<GameBody> createState() => _GameBodyState();
}

class _GameBodyState extends State<GameBody> {
  bool afficherGriffure = false;

  void _onMonsterTap(GameViewModel gameViewModel) {
    setState(() {
      afficherGriffure = true;
    });

    // Vérifie si le monstre est mort
    if (gameViewModel.enemy.currentLife <= 0) {
        //nothing need to be done here, it is the game view model job
    }

    gameViewModel.attackEnemy();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        afficherGriffure = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);
    final enemy = gameViewModel.enemy;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Compteur de monstres tués
          Text(
            'Monstres tués: ${gameViewModel.monstersKilled}/10',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Image du monstre avec superposition de griffure
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () => _onMonsterTap(gameViewModel),
                child: Image.asset(
                  gameViewModel.currentMonsterImage,
                  width: 300,
                  height: 300,
                ),
              ),
              if (afficherGriffure)
                Image.asset(
                  'assets/scratch.png',
                  width: 300,
                  height: 300,
                ),
            ],
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
