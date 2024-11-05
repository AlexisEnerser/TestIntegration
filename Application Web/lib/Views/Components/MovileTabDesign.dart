import 'package:flutter/Material.dart';

class MobileTabDesign extends StatelessWidget {
  final String title;
  final IconData icon;
  const MobileTabDesign({
    super.key, required this.title, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,size: 15,),
          const SizedBox(width: 5,),
          Text(title, style: const TextStyle(fontSize: 10),),
        ],
      ),
    );
  }
}