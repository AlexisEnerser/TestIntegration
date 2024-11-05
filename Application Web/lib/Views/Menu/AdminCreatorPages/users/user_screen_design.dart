import 'package:flutter/material.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:zohoanalytics/Views/Components/IsPhone.dart';
import 'user_screen_logic.dart';
import 'views/web/UserScreenDesignWeb.dart';
import 'views/web/UserScreenDesignWebMovil.dart';

class UserScreenDesign extends StatelessWidget {
  const UserScreenDesign({super.key});

  @override
  Widget build(BuildContext context) {
    UserScreenLogic logic = UserScreenLogic();
    if (isWeb()) {
      return isMobileDevice(MediaQuery.sizeOf(context).width)
          ?UserScreenDesignWebMovil(logic: logic)
          :UserScreenDesignWeb(logic: logic);
    }
    else{
      return Container();
    }
  }
}