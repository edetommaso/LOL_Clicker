// lib/views/shop_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/shop_viewmodel.dart';
import '../viewmodels/game_viewmodel.dart';
import '../models/shop_item_model.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    final shopViewModel = Provider.of<ShopViewModel>(context);
    final gameViewModel = Provider.of<GameViewModel>(context); // Pour accéder aux pièces du joueur

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85, // Ajuster la largeur à 85% de l'écran
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Boutique',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          if (shopViewModel.errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                shopViewModel.errorMessage!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
          for (var item in shopViewModel.items)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  // Image de l'item
                  Image.asset(
                    item.imagePath,
                    width: 30, // Largeur réduite
                    height: 30, // Hauteur réduite
                  ),
                  const SizedBox(width: 16), // Espacement entre l'image et le texte
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nom de l'item
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4), // Espacement entre le nom et la description
                        // Description de l'item
                        Text(
                          item.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4), // Espacement entre la description et le prix
                        // Prix de l'item
                        Text(
                          'Prix: ${item.price} pièces',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Nombre de fois que l'item a été acheté
                        Text(
                          'Acheté ${item.purchaseCount} fois',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16), // Espacement entre le texte et le bouton
                  // Bouton "Acheter"
                  ElevatedButton(
                    onPressed: () {
                      shopViewModel.buyItem(item.id, gameViewModel); // Acheter l'item
                    },
                    child: const Text('Acheter'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}