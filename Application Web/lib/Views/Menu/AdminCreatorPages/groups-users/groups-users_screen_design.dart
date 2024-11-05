import 'package:flutter/material.dart';
import 'package:platform_detector/platform_detector.dart';
import 'package:zohoanalytics/Views/Components/IsPhone.dart';

import 'groups-users_logic.dart';
import 'views/web/GroupUsersDesignWeb.dart';
import 'views/web/GroupUsersDesignWebMovil.dart';

class GroupsUsersScreenDesign extends StatelessWidget {
  const GroupsUsersScreenDesign({super.key});

  @override
  Widget build(BuildContext context) {
    GroupsUsersLogic logic = GroupsUsersLogic();
    if (isWeb()) {
      return isMobileDevice(MediaQuery.sizeOf(context).width)
          ?GroupUsersDesignWebMovil(logic: logic)
          :GroupUsersDesignWeb(logic: logic);
    }
    else{
      return Container();
    }
  }
}