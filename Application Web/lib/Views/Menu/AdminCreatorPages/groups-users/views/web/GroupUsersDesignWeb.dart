import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/DefaultLayout.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/groups-users/groups-users_logic.dart';

import 'components/assignedUsers.dart';
import 'components/groupSearcher.dart';
import 'components/noAssignedUsers.dart';
import 'components/saveAreaReport.dart';


class GroupUsersDesignWeb extends StatelessWidget {
  final GroupsUsersLogic logic;
  const GroupUsersDesignWeb({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (_, contraints){
          double width = contraints.constrainWidth()*0.99;
          double height = contraints.constrainHeight()*0.98;
          return DefaultLayout2(
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GroupSearcher(
                  logic: logic,
                  width: width,
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: LayoutBuilder(
                    builder: (_, cntrnts){
                      double height1 = cntrnts.constrainHeight()*0.98;
                      double width1 = cntrnts.constrainWidth()*0.495;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AssignedUsers(
                            key: logic.assignedUsers,
                            logic: logic,
                            height: height1,
                            width: width1,
                          ),
                          NoAssignedUsers(
                            key: logic.noAssignedUsers,
                            logic: logic,
                            height: height1,
                            width: width1,
                          )
                        ],
                      );
                    }
                  ),
                ),
                const SizedBox(height: 10,),
                SaveAreaReport(
                  key: logic.sareArea,
                  logic: logic
                )
              ],
            ),
          );
        },
      ),
    );
  }
}