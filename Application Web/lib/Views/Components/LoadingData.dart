import 'package:flutter/material.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: double.infinity,),
        Image.asset("assets/images/logoColor.png",fit: BoxFit.fitWidth,width: MediaQuery.of(context).size.width*0.1,),
        const SizedBox(height: 16),
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        const Text('Espere por favor...'),
      ],
    );
  }
}