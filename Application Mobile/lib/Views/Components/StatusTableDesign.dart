import 'package:flutter/material.dart';
import 'package:zohoanalytics/constants.dart';

class StatusTableDesign extends StatelessWidget {
  final String status;
  final Color color;
  const StatusTableDesign({super.key, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text(
            status,
            style: tableItemStyle.copyWith(
              color: Colors.white
            )
          ),
        ),
      ],
    );
  }
}