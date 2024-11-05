import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/NoPremium.dart';
import 'package:zohoanalytics/Views/Menu/Home/views/HomeMovil.dart';
import '../../../constants.dart';
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
      return userData!.mobileAccess=="True"
          ?HomeMovil(logic: logic)
          :const NoPremium();
  }
}
