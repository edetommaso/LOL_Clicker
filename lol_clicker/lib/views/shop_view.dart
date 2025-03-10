// lib/views/shop_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/shop_viewmodel.dart';
import '../viewmodels/game_viewmodel.dart';

class ShopView extends StatelessWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shopViewModel = Provider.of<ShopViewModel>(context);
    final gameViewModel = Provider.of<GameViewModel>(context);

    // Si les items n'ont pas été chargés, essayer de les charger
    if (shopViewModel.items.isEmpty && !shopViewModel.isLoading && shopViewModel.errorMessage == null) {
      Future.microtask(() => shopViewModel.loadItems());
    }

    // Afficher un indicateur de chargement si nécessaire
    if (shopViewModel.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Chargement des items...'),
          ],
        ),
      );
    }
    
    // Afficher un message d'erreur s'il y en a un
    if (shopViewModel.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Erreur: ${shopViewModel.errorMessage}',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => shopViewModel.loadItems(),
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    // Si aucun item n'est disponible
    if (shopViewModel.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Aucun item disponible dans la boutique',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => shopViewModel.loadItems(),
              child: const Text('Rafraîchir'),
            ),
          ],
        ),
      );
    }

    // Afficher la liste des items
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Boutique',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Afficher le message d'erreur pour l'achat si présent
        if (shopViewModel.errorMessage != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              shopViewModel.errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        // Solde actuel
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Solde: ${gameViewModel.coins} coins',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Liste des items
        Expanded(
          child: ListView.builder(
            itemCount: shopViewModel.items.length,
            itemBuilder: (context, index) {
              final item = shopViewModel.items[index];
              final bool canBuy = gameViewModel.coins >= item.price;
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: canBuy ? null : Colors.grey[200],
                child: ListTile(
                  leading: Image.network(
                    item.image,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      print("Erreur de chargement d'image: $error pour ${item.image}");
                      return const Icon(Icons.error, size: 50);
                    },
                  ),
                  title: Text(item.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.description),
                      Text(
                        'DPS: +${item.price ~/ 20}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${item.price} coins',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: canBuy ? Colors.black : Colors.red,
                        ),
                      ),
                      Text('Acheté: ${item.purchaseCount}'),
                    ],
                  ),
                  onTap: () {
                    shopViewModel.buyItem(item.id, gameViewModel);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}