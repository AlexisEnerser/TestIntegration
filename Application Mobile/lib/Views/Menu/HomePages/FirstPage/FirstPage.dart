import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Menu/HomePages/FirstPage/views/FirstPageMovil.dart';
import 'FirstPageLogic.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  FirstPageLogic logic = FirstPageLogic();

  @override
  Widget build(BuildContext context) {
    return FirstPageMovil(logic:logic);
  }
}