import 'package:flutter/material.dart';

class RowItemTemplate extends StatelessWidget {
  final bool isEven;
  final Widget child;
  const RowItemTemplate({super.key, required this.isEven, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: isEven? const Color.fromARGB(255, 196, 222, 235): Colors.white,
        border: Border.all(
          color: Colors.black
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: child,
      ),
    );
  }
}