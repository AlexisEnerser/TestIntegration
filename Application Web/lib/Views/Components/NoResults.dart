import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {
  const NoResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: Padding(
      padding: EdgeInsets.only(bottom: 70),
      child: Text("No hay resultados",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
    ),);
  }
}