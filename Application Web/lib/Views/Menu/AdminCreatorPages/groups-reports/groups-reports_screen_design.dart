import 'package:flutter/material.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:zohoanalytics/Views/Components/IsPhone.dart';

import 'groups-reports_logic.dart';
import 'views/web/GroupReportsDesignWeb.dart';
import 'views/web/GroupReportsDesignWebMovil.dart';

class GroupsReportsScreenDesign extends StatelessWidget {
  const GroupsReportsScreenDesign({super.key});

  @override
  Widget build(BuildContext context) {
    GroupsReportsLogic logic = GroupsReportsLogic();
    if (isWeb()) {
      return isMobileDevice(MediaQuery.sizeOf(context).width)
          ?GroupReportsDesignWebMovil(logic: logic)
          :GroupReportsDesignWeb(logic: logic);
    }
    else{
      return Container();
    }
  }
}