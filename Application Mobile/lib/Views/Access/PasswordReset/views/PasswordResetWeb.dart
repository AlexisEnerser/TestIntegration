import 'package:flutter/Material.dart';
import 'package:zohoanalytics/Views/Components/WebAccessHeader.dart';

import '../../../../constants.dart';
import '../../../Components/LoginTextField.dart';
import '../../../Components/ResetPasswordButton.dart';
import '../PasswordResetLogic.dart';

class PasswordResetWeb extends StatefulWidget {
  final PasswordResetLogic logic;
  const PasswordResetWeb({super.key, required this.logic});

  @override
  State<PasswordResetWeb> createState() => _PasswordResetWebState();
}

class _PasswordResetWebState extends State<PasswordResetWeb> {

  double borderBox = 20;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height*0.5;
    double width = MediaQuery.of(context).size.width*0.5;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: blue1,),
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 100,top: 75),
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
                          const Spacer(),
                          Image.asset("assets/images/logoBlanco.png",fit: BoxFit.fitHeight,height: 50,),
                          const SizedBox(width: 15,),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text("Recuperar contraseña",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: blue1),),
                    const Spacer(),
                    LoginTextField(
                      title:"Ingresa tu usuario",
                      controller: widget.logic.userController,
                      width: width,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: ()=>widget.logic.callRecoveryPasswordService(context),
                      child:  ResetPasswordButton(
                        width: width,
                        title: "Enviar",
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const WebAccessHeader()
          ],
        ),
      ),
    );
  }
}
