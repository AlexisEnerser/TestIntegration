import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/Access/LoginRequest.dart';
import '../../Models/Access/LoginResponse.dart';
import '../../Services/AccessServices.dart';
import '../../Services/ReportServices.dart';
import '../../constants.dart';
import '../Menu/Home/Home.dart';
import 'Login/Login.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({super.key});

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {

  Future<void> validateUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user') ?? '';
    String password = prefs.getString('password') ?? '';
    if(user.isEmpty || password.isEmpty){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }

    LoginResponse loginResponse = await makeLogin(loginRequest: LoginRequest(user, password));
    await Future.delayed(const Duration(seconds: 1));
    if(loginResponse.code != 1){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }
    userReports = await consultUserReports();
    userData = loginResponse.data!;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    validateUserSession();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: Colors.white,),
            Column(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity,),
                Image.asset("assets/images/logoColor.png",fit: BoxFit.fitWidth,width: MediaQuery.of(context).size.width*0.1,),
                const SizedBox(height: 16),
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                const Text('Espere por favor...'),
              ],
            )
          ],
        ),
      ),
    );
  }
}