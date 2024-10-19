import 'package:flutter/material.dart';

class OfferIndicator extends StatelessWidget {
  final bool isSelected;
  final Color color;

  const OfferIndicator({super.key, required this.isSelected, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isSelected ? 26.0 : 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: isSelected ? const Color(0xFF5E569B) : Colors.grey.withOpacity(0.6),
      ),
    );
  }
}
