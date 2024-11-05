import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/DefaultLayout.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/groups/group_screen_logic.dart';

import 'components/add_group.dart';
import 'components/edit_group.dart';
import 'components/show_groups.dart';

// ignore: must_be_immutable
class GroupScreenDesingWeb extends StatelessWidget {
  GroupScreenLogic logic;
  GroupScreenDesingWeb({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_,constraints){
        double width1 = constraints.constrainWidth()*0.38;
        double height1 = constraints.constrainHeight()*0.48;
        double width2 = constraints.constrainWidth()*0.58;
        double height2 = constraints.constrainHeight()*0.99;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DefaultLayout2(
                  height: height1,
                  width: width1,
                  child: AddGroup(
                    height: height1,
                    width: width1,
                    logic: logic,
                  ),
                ),
                DefaultLayout2(
                  height: height1,
                  width: width1,
                  child: EditGroup(
                    height: height1,
                    width: width1,
                    key: logic.editGroup,
                    logic: logic,
                  ),
                ),
              ],
            ),
            DefaultLayout2( 
              height: height2,
              width: width2,        
              child: ShowGroups(
                key: logic.showGroups,
                logic: logic,
              ),
            ),
          ]
        );
      },
    );
  }
}