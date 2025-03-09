// lib/views/game_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';
import '../viewmodels/shop_viewmodel.dart';
import '../widgets/shop_button.dart';
import '../widgets/shop_panel.dart';
import '../widgets/coin_display.dart';
import 'game_body.dart';

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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'), // Chemin de l'image
              fit: BoxFit.cover, // Ajuster l'image pour couvrir tout l'écran
            ),
          ),
          child: Stack(
            children: [
              // Corps de la page (le jeu)
              Column(
                children: [
                  // Header personnalisé avec logo et titre
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.deepPurple.withOpacity(
                        0.7), // Ajouter une opacité pour mieux voir le texte
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
                  // Utilisation de Spacer pour pousser le GameBody vers le bas
                  const Spacer(),
                  const GameBody(), // Utilisation de GameBody
                ],
              ),
              // Bouton du shop
              ShopButton(onPressed: _toggleShop),
              // Panneau du shop
              ShopPanel(
                isShopOpen: _isShopOpen,
                onClose: _toggleShop,
              ),
              // Affichage du solde de pièces en bas à gauche
              Positioned(
                left: 16,
                bottom:
                    60, // Positionné en bas, avec de l'espace pour le DPS en dessous
                child: Consumer<GameViewModel>(
                  builder: (context, gameViewModel, child) {
                    return CoinDisplay(coins: gameViewModel.coins);
                  },
                ),
              ),
              // Affichage du DPS en bas à gauche, en dessous des pièces
              // lib/views/game_view.dart
              Positioned(
                left: 16,
                bottom: 16, // Positionné en dessous des pièces
                child: Consumer<GameViewModel>(
                  builder: (context, gameViewModel, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 139, 12, 198)
                            .withOpacity(0.5), // Fond semi-transparent
                        borderRadius: BorderRadius.circular(8), // Bord arrondi
                      ),
                      child: Text(
                        'DPS: ${gameViewModel.dps}', // Assurez-vous que `dps` est une propriété dans `GameViewModel`
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
