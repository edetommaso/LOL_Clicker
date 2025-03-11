import 'package:flutter/material.dart';

class ShopButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ShopButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      top: 16,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}