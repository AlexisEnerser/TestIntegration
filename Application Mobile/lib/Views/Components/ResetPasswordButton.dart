import 'package:flutter/material.dart';
import '../../constants.dart';

class ResetPasswordButton extends StatelessWidget {
  final String title;
  final double width;
  const ResetPasswordButton({
    super.key,
    required this.width,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: (width/2)*0.6,
      decoration: BoxDecoration(
          color: blue2,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}