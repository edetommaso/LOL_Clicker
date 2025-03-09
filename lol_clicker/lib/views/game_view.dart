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
                    color: Colors.deepPurple.withOpacity(0.7), // Ajouter une opacité pour mieux voir le texte
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
                  const Expanded(
                    child: GameBody(), // Utilisation de GameBody
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
              // Affichage du solde de pièces en bas à gauche
              Positioned(
                left: 16,
                bottom: 16,
                child: Consumer<GameViewModel>(
                  builder: (context, gameViewModel, child) {
                    return CoinDisplay(coins: gameViewModel.coins);
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