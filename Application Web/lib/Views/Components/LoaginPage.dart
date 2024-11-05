import 'package:flutter/material.dart';

Widget loadingPage(){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset("assets/images/logoColor.png",fit: BoxFit.fitWidth,width: 300,),
      const SizedBox(height: 16),
      const CircularProgressIndicator(),
      const SizedBox(height: 16),
      const Text('Espere por favor...'),
    ],
  );
}