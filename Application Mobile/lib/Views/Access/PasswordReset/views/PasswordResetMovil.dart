import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';

import '../../../../constants.dart';
import '../../../Components/LoginTextField.dart';
import '../../../Components/ResetPasswordButton.dart';
import '../PasswordResetLogic.dart';

class PasswordResetMovil extends StatefulWidget {
  final PasswordResetLogic logic;
  const PasswordResetMovil({super.key, required this.logic});

  @override
  State<PasswordResetMovil> createState() => _PasswordResetMovilState();
}

class _PasswordResetMovilState extends State<PasswordResetMovil> {
  double borderBox = 10;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle(
            statusBarColor: blue1,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Stack(
            children: [
              Container(color: blue1,),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
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
                  child: LayoutBuilder(
                    builder: (context,constraint){
                      return Form(
                        child: SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: constraint.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                children: [
                                  Container(
                                    height: 70,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade700,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(borderBox),topRight: Radius.circular(borderBox))
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 15,),
                                        Image.asset("assets/images/logoBlanco.png",fit: BoxFit.fitWidth,height: 30,),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30,),
                                  Text("Recuperar contraseña",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: blue1),),
                                  const Spacer(),
                                  LoginTextField(
                                    title:"Ingresa tu usuario",
                                    controller: widget.logic.userController,
                                    width: width*1.8,
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: ()=>widget.logic.callRecoveryPasswordService(context),
                                    child:  ResetPasswordButton(
                                      width: width*2,
                                      title: "Enviar",
                                    ),
                                  ),
                                  const SizedBox(height: 30,),
                                  InkWell(
                                    onTap: ()=>widget.logic.moveBack(context),
                                    child: Text("Regresar",style: TextStyle(color: blue1,fontWeight: FontWeight.bold,fontSize: 18),),
                                  ),
                                  const SizedBox(height: 30,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
