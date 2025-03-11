import 'package:flutter/material.dart';
import '../views/helper_view.dart';

class HelperPanel extends StatelessWidget {
  final bool isHelperOpen;
  final VoidCallback onClose;

  const HelperPanel({
    super.key,
    required this.isHelperOpen,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      left: isHelperOpen ? 0 : -300,
      top: 0,
      bottom: 0,
      width: 300,
      child: Card(
        elevation: 8,
        child: Stack(
          children: [
            HelperView(),
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