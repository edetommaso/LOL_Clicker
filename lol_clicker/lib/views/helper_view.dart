// lib/views/helper_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/helper_viewmodel.dart';
import '../viewmodels/game_viewmodel.dart';

class HelperView extends StatelessWidget {
  const HelperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final helperViewModel = Provider.of<HelperViewModel>(context);
    final gameViewModel = Provider.of<GameViewModel>(context);

    if (helperViewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (helperViewModel.errorMessage != null) {
      return Center(child: Text('Erreur: ${helperViewModel.errorMessage}'));
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Personnages', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Solde: ${gameViewModel.coins} coins', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: helperViewModel.helpers.length,
            itemBuilder: (context, index) {
              final helper = helperViewModel.helpers[index];
              final bool canBuy = gameViewModel.coins >= helper.price;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: canBuy ? null : Colors.grey[200],
                child: ListTile(
                  leading: Image.network(helper.image, width: 50, height: 50, errorBuilder: (_, __, ___) => const Icon(Icons.error)),
                  title: Text(helper.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(helper.description),
                      Text('DPS: +${helper.dps}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${helper.price} coins', style: TextStyle(color: canBuy ? Colors.black : Colors.red)),
                      Text('Acheté: ${helper.purchaseCount}'),
                    ],
                  ),
                  onTap: () => helperViewModel.buyHelper(helper.id, gameViewModel),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}