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
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Chargement des helpers...'),
          ],
        ),
      );
    }

    if (helperViewModel.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              helperViewModel.errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                helperViewModel.clearError();
              },
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
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
                  leading: Image.network(
                    helper.image,
                    width: 80, 
                    height: 80,
                    errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 80),
                  ),
                  title: Text(helper.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(helper.description),
                      Text(
                        'DPS: +${helper.dps}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
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