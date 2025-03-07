// lib/views/game_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';
import '../viewmodels/shop_viewmodel.dart';
import '../widgets/shop_button.dart';
import '../widgets/shop_panel.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  bool _isShopOpen = false;

  void _toggleShop() {
    setState(() {
      _isShopOpen = !_isShopOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameViewModel()),
        ChangeNotifierProvider(create: (context) => ShopViewModel()),
      ],
      child: Scaffold(
        appBar: null,
        body: Stack(
          children: [
            // Corps de la page (le jeu)
            Column(
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
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: GameBody(),
                ),
              ],
            ),
            // Bouton du shop
            ShopButton(onPressed: _toggleShop),
            // Panneau du shop
            ShopPanel(
              isShopOpen: _isShopOpen,
              onClose: _toggleShop,
            ),
          ],
        ),
      ),
    );
  }
}
// lib/views/game_view.dart (extrait de GameBody)
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