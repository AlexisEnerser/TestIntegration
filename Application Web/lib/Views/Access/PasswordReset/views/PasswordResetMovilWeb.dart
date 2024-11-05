import 'package:flutter/Material.dart';

import '../../../../constants.dart';
import '../../../Components/LoginTextField.dart';
import '../../../Components/ResetPasswordButton.dart';
import '../PasswordResetLogic.dart';

class PasswordResetMovilWeb extends StatefulWidget {
  final PasswordResetLogic logic;
  const PasswordResetMovilWeb({super.key, required this.logic});

  @override
  State<PasswordResetMovilWeb> createState() => _PasswordResetMovilWebState();
}

class _PasswordResetMovilWebState extends State<PasswordResetMovilWeb> {
  double borderBox = 20;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height*0.9;
    double width = MediaQuery.of(context).size.width*0.9;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: blue1,),
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10,top: 75),
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[200]!,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500]!,
                        blurRadius: 4,
                        offset: const Offset(2, 2), // Shadow position
                      ),
                    ],
                    borderRadius: BorderRadius.circular(borderBox)
                ),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15,),
                          InkWell(
                            onTap: ()=>widget.logic.moveBack(context),
                            child: const SizedBox(
                              height: 60,
                              width: 100,
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_back,color: Colors.white,),
                                  SizedBox(width: 10,),
                                  Text("Regresar",style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text("Recuperar contraseña",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: blue1),),
                    const Spacer(),
                    LoginTextField(
                      title:"Ingresa tu usuario",
                      controller: widget.logic.userController,
                      width: width*2,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: ()=>widget.logic.callRecoveryPasswordService(context),
                      child:  ResetPasswordButton(
                        width: width*2,
                        title: "Enviar",
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Container(
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
                  Image.asset("assets/images/logoBlanco.png",fit: BoxFit.fitWidth,width: 200,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
