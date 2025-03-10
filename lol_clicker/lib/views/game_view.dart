import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';
import '../viewmodels/shop_viewmodel.dart';
import 'package:lol_clicker/widgets/enemy_widgets.dart';
import '../widgets/shop_button.dart';
import '../widgets/shop_panel.dart';
import '../widgets/coin_display.dart';

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
              image: AssetImage('assets/background.jpg'), // Background image
              fit: BoxFit.cover, // Cover the entire screen
            ),
          ),
          child: Stack(
            children: [
              // Main game content
              Column(
                children: [
                  // Custom header with logo and title
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: const Color.fromARGB(255, 65, 65, 65).withOpacity(0.7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 150,
                          height: 100,
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
                  const Spacer(), // Push content to the bottom
                  const EnemyWidgets(), // Enemy widgets
                ],
              ),
              // Shop button
              ShopButton(onPressed: _toggleShop),
              // Shop panel
              ShopPanel(
                isShopOpen: _isShopOpen,
                onClose: _toggleShop,
              ),
              // Coin display at the bottom left
              Positioned(
                left: 16,
                bottom: 100, // Adjusted to avoid overlap
                child: Consumer<GameViewModel>(
                  builder: (context, gameViewModel, child) {
                    return CoinDisplay(coins: gameViewModel.coins);
                  },
                ),
              ),
              // Damage/click and Coin/click display at the bottom left
              Positioned(
                left: 16,
                bottom: 16, // Positioned below the coin display
                child: Consumer<GameViewModel>(
                  builder: (context, gameViewModel, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 65, 65, 65)
                            .withOpacity(0.5), // Semi-transparent background
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Damage/click: ${gameViewModel.damage}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5), // Spacing between texts
                          Text(
                            'Coin/click: ${gameViewModel.coin_per_click}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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