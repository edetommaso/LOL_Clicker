// lib/widgets/enemy_widgets.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';

class EnemyWidgets extends StatelessWidget {
  const EnemyWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);
    final enemy = gameViewModel.enemy;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            '${enemy.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Categorie : ${enemy.categorie}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Compteur de monstres tués
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
            enemy.image,
            width: 300,
            height: 300,
          ),
        ),
        const SizedBox(height: 20),
        
        // Barre de vie
        SizedBox(
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
          'Niveau: ${gameViewModel.level} | PV: ${enemy.currentLife}/${enemy.totalLife}',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        
        // Affichage des dégâts infligés
        Text(
          'Dégâts infligés: ${gameViewModel.damage}',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
