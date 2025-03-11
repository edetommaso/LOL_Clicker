import 'package:flutter/material.dart';
import 'package:lol_clicker/viewmodels/helper_viewmodel.dart';
import 'package:lol_clicker/widgets/helper_button.dart';
import 'package:lol_clicker/widgets/helper_panel.dart';
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
  bool _isHelperOpen = false; 

  void _toggleShop() {
    setState(() {
      _isShopOpen = !_isShopOpen;
    });
  }

  void _toggleHelpers() {
    setState(() {
      _isHelperOpen = !_isHelperOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameViewModel()),
        ChangeNotifierProvider(create: (context) => ShopViewModel()),
        ChangeNotifierProvider(create: (context) => HelperViewModel()),
      ],
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: const Color.fromARGB(255, 65, 65, 65).withOpacity(0.7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          width: 250,
                          height: 100,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const EnemyWidgets(),
                ],
              ),
              ShopButton(onPressed: _toggleShop),
              HelperButton(onPressed: _toggleHelpers), 
              ShopPanel(isShopOpen: _isShopOpen, onClose: _toggleShop),
              HelperPanel(isHelperOpen: _isHelperOpen, onClose: _toggleHelpers), 
              Positioned(
                left: 16,
                bottom: 100,
                child: Consumer<GameViewModel>(
                  builder: (context, gameViewModel, child) => CoinDisplay(coins: gameViewModel.coins),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Consumer<GameViewModel>(
                  builder: (context, gameViewModel, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 65, 65, 65).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Damage/click: ${gameViewModel.damage}', style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                          Text('Coin/click: ${gameViewModel.coin_per_click}', style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                          Text('Helper DPS: ${gameViewModel.helperDps}', style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)), // Afficher les DPS des helpers
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