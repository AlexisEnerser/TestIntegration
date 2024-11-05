import 'package:flutter/material.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:zohoanalytics/Views/Components/IsPhone.dart';
import 'reports_screen_logic.dart';
import 'views/web/ReportsScreenDesignWeb.dart';
import 'views/web/ReportsScreenDesignWebMovil.dart';


class ReportsScreenDesign extends StatelessWidget {
  const ReportsScreenDesign({super.key});
  @override
  Widget build(BuildContext context) {
    ReportsScreenLogic logic = ReportsScreenLogic();
    if (isWeb()) {
      return isMobileDevice(MediaQuery.sizeOf(context).width)
          ?ReportsScreenDesignWebMovil(logic: logic)
          :ReportsScreenDesignWeb(logic: logic);
    }
    else{
      return Container();
    }
  }
}