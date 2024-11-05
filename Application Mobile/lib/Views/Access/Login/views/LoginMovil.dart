import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';

import '../../../../constants.dart';
import '../../../Components/LoginButton.dart';
import '../../../Components/LoginTextField.dart';
import '../LoginLogic.dart';

class LoginMovil extends StatefulWidget {
  final LoginLogic logic;
  const LoginMovil({super.key,
    required this.logic
  });

  @override
  State<LoginMovil> createState() => _LoginMovilState();
}

class _LoginMovilState extends State<LoginMovil> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: blue1,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Container(color: blue1),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: blue1
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: -1,
                        blurRadius: 2,
                        offset: const Offset(4, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Spacer(flex: 2,),
                      SizedBox(
                        width: width/2,
                        child: Image.asset("assets/images/logoLogin.png",),
                      ),
                      const Spacer(flex: 2,),
                      LoginTextField(
                        width: width*2,
                        title: "Usuario",
                        controller: widget.logic.userController,
                        iconData: Icons.person,
                      ),
                      const SizedBox(height: 15,),
                      LoginTextField(
                        width: width*2,
                        title: "Contraseña",
                        controller: widget.logic.passwordController,
                        isPassword: true,
                        iconData: Icons.lock,
                      ),
                      const SizedBox(height: 15,),
                      SizedBox(
                        height: 40,
                        width: (width)*0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: ()=>widget.logic.goToPasswordRecovery(context),
                              child: Text("¿Olvidate tu contraseña?",style: TextStyle(color: blue2),),
                            )
                          ],
                        ),
                      ),
                      const Spacer(flex: 2,),
                      InkWell(
                        onTap: ()=>widget.logic.makeLoginMethod(context),
                        child: LoginButton(
                            width: width*2,
                            title: "Iniciar Sesión"
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
