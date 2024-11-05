import 'package:flutter/material.dart';
import 'package:zohoanalytics/constants.dart';

class WebAccessHeader extends StatelessWidget {
  const WebAccessHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: barColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 15,),
          Image.asset("assets/images/logoBlanco.png",fit: BoxFit.fill,width: 150, height: 60,),
        ],
      ),
    );
  }
}