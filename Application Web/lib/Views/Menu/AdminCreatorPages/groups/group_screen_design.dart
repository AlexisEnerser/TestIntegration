import 'package:flutter/material.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:zohoanalytics/Views/Components/IsPhone.dart';
import 'group_screen_logic.dart';
import 'views/web/GroupScreenDesignWeb.dart';
import 'views/web/GroupScreenDesignWebMovil.dart';

class GroupScreenDesign extends StatelessWidget {
  const GroupScreenDesign({super.key});

  @override
  Widget build(BuildContext context) {
    GroupScreenLogic logic = GroupScreenLogic();
    if (isWeb()) {
      return isMobileDevice(MediaQuery.sizeOf(context).width)
          ?GroupScreenDesignWebMovil(logic: logic)
          :GroupScreenDesingWeb(logic: logic);
    }
    else{
      return Container();
    }
  }
}