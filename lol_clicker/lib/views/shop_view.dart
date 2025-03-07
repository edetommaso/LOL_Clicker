// lib/views/shop_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/shop_viewmodel.dart';
import '../models/shop_item_model.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    final shopViewModel = Provider.of<ShopViewModel>(context);

    return Drawer(
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
          for (var item in shopViewModel.items)
            ListTile(
              title: Text(item.name),
              subtitle: Text(item.description),
              trailing: Text('${item.price} pièces'),
              onTap: () => shopViewModel.buyItem(item.id),
            ),
        ],
      ),
    );
  }
}