import 'package:flutter/material.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:zohoanalytics/Views/Components/IsPhone.dart';

import 'users-reports_logic.dart';
import 'views/web/GroupReportsDesignWeb.dart';
import 'views/web/GroupReportsDesignWebMovil.dart';

class UsersReportsScreenDesign extends StatelessWidget {
  const UsersReportsScreenDesign({super.key});

  @override
  Widget build(BuildContext context) {
    UsersReportsLogic logic = UsersReportsLogic();
    if (isWeb()) {
      return isMobileDevice(MediaQuery.sizeOf(context).width)
          ?UsersReportsDesignWebMovil(logic: logic)
          :UserReportsDesignWeb(logic: logic);
    }
    else{
      return Container();
    }
  }
}