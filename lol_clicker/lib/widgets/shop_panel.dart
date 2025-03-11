import 'package:flutter/material.dart';
import '../views/shop_view.dart';

class ShopPanel extends StatelessWidget {
  final bool isShopOpen;
  final VoidCallback onClose;

  const ShopPanel({
    super.key,
    required this.isShopOpen,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      right: isShopOpen ? 0 : -300,
      top: 0,
      bottom: 0,
      width: 300,
      child: Card(
        elevation: 8,
        child: Stack(
          children: [
            ShopView(),
            Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: onClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}