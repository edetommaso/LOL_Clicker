// lib/widgets/enemy_widgets.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';
import 'dart:async';

class EnemyWidgets extends StatefulWidget {
  const EnemyWidgets({super.key});

  @override
  _EnemyWidgetsState createState() => _EnemyWidgetsState();
}

class _EnemyWidgetsState extends State<EnemyWidgets> {
  bool _showClaw = false; // Contrôle l’affichage de la griffure

  void _showClawEffect() {
    setState(() {
      _showClaw = true; // Afficher la griffure
    });
    // Faire disparaître la griffure après 500 ms
    Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showClaw = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);
    final enemy = gameViewModel.enemy;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${enemy.name}',
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text(
          'Categorie : ${enemy.categorie}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Niveau: ${gameViewModel.level} | Monstres tués: ${gameViewModel.monstersKilled}/10',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        // Image du monstre avec superposition de la griffure
        GestureDetector(
          onTap: () {
            gameViewModel.attackEnemy(); // Infliger les dégâts
            _showClawEffect(); // Afficher la griffure
          },
          child: Stack(
            alignment: Alignment.center, // Centrer la griffure
            children: [
              Image.asset(
                enemy.image,
                width: 300,
                height: 300,
              ),
              if (_showClaw) // Afficher la griffure si _showClaw est vrai
                Image.asset(
                  'assets/scratch.png', // Assure-toi que cette image existe
                  width: 300,
                  height: 300,
                  color: Colors.red.withOpacity(0.7), // Teinte rouge et transparence
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 400,
          child: LinearProgressIndicator(
            value: enemy.currentLife / enemy.totalLife,
            backgroundColor: Colors.red,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'PV: ${enemy.currentLife}/${enemy.totalLife}',
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}