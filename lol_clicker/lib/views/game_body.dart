// lib/views/game_body.dart
import 'package:flutter/material.dart';
import 'package:lol_clicker/widgets/enemy_widgets.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';

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
          
          EnemyWidgets()
        ],
      ),
    );
  }
}