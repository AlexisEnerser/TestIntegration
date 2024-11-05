import 'package:flutter/Material.dart';
import 'package:zohoanalytics/constants.dart';

class NoPremium extends StatefulWidget {
  const NoPremium({super.key});

  @override
  State<NoPremium> createState() => _NoPremiumState();
}

class _NoPremiumState extends State<NoPremium> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: blue1,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("assets/images/logoBlanco.png",width: 200,),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                color: Colors.white.withOpacity(0.4),
                child: Center(
                  child: Text("Contrata la versión\nPremium",style: TextStyle(color: blue2,fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                ),
              ),
              const Spacer(flex: 2,),
            ],
          )
        ],
      ),
    );
  }
}
