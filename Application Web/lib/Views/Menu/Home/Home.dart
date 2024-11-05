import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/NoPremium.dart';
import 'package:zohoanalytics/Views/Menu/Home/views/HomeMovilWeb.dart';
import 'package:zohoanalytics/Views/Menu/Home/views/HomeWeb.dart';
import '../../../constants.dart';
import '../../Components/IsPhone.dart';
import 'HomeLogic.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  HomeLogic logic = HomeLogic();

  @override
  Widget build(BuildContext context) {
    return isMobileDevice(MediaQuery.of(context).size.width)
        ?userData!.mobileAccess=="True"
          ?HomeMovilWeb(logic: logic)
          :const NoPremium()
        :HomeWeb(logic: logic);
  }
}
