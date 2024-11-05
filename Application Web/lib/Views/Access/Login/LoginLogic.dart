import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/Access/LoginRequest.dart';
import '../../../Models/Access/LoginResponse.dart';
import '../../../Services/AccessServices.dart';
import '../../../Services/ReportServices.dart';
import '../../../constants.dart';
import '../../Components/LoadingAlert.dart';
import '../../Components/OkDialogAlert.dart';
import '../../Menu/Home/Home.dart';
import '../PasswordReset/PasswordReset.dart';

class LoginLogic{

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> makeLoginMethod(BuildContext context) async{
    if(userController.text.isEmpty){
      showOkAlert(
          context:context,
          message: "Debes ingresar tu usuario",
          title: "Atención"
      );
      return;
    }
    if(passwordController.text.isEmpty){
      showOkAlert(
          context:context,
          message: "Debes ingresar tu contraseña",
          title: "Atención"
      );
      return;
    }

    showLoadingAlert(context:context);
    String user = userController.text;
    String password = passwordController.text;
    LoginResponse loginResponse = await makeLogin(loginRequest: LoginRequest(user, password));

    if(loginResponse.code != 1){
      closeLoadingAlert(context:context);
      showOkAlert(
          context:context,
          message: loginResponse.message,
          title: "Atención"
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
    await prefs.setString('password', password);

    userReports = await consultUserReports();
    userData = loginResponse.data!;

    closeLoadingAlert(context:context);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  void goToPasswordRecovery(BuildContext context){
    Navigator.of(context).push(_createRoute());
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const PasswordReset(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        //position: animation.drive(tween),
        opacity:  animation,
        child: child,
      );
    },
  );
}