import 'package:flutter/material.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:zohoanalytics/Views/Access/Login/views/LoginMovilWeb.dart';
import 'package:zohoanalytics/Views/Access/Login/views/LoginMovil.dart';
import 'package:zohoanalytics/Views/Access/Login/views/LoginWeb.dart';
import '../../Components/IsPhone.dart';
import 'LoginLogic.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  LoginLogic logic = LoginLogic();

  @override
  Widget build(BuildContext context) {
    if (isWeb()) {
      return isMobileDevice(MediaQuery.of(context).size.width)
          ?LoginMovilWeb(logic: logic)
          :LoginWeb(logic: logic);
    }
    else{
      return LoginMovil(logic: logic);
    }
  }
}