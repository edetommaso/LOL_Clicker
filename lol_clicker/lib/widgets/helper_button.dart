import 'package:flutter/material.dart';

class HelperButton extends StatelessWidget {
  final VoidCallback onPressed;

  const HelperButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 16,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.people),
      ),
    );
  }
}