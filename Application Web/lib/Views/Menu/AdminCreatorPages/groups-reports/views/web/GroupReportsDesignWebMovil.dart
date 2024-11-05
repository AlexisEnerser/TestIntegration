import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/DefaultLayout.dart';
import '../../groups-reports_logic.dart';
import 'components/assignedReports.dart';
import 'components/groupSearcher.dart';
import 'components/noAssignedReports.dart';
import 'components/saveAreaReport.dart';


class GroupReportsDesignWebMovil extends StatelessWidget {
  final GroupsReportsLogic logic;
  const GroupReportsDesignWebMovil({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (_, constraints){
          double width = constraints.constrainWidth()*0.99;
          double height = constraints.constrainHeight()*0.98;
          return DefaultLayout2(
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GroupSearcher(
                  logic: logic,
                  width: width*1.5,
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: LayoutBuilder(
                    builder: (_, cntrnts){
                      double height1 = cntrnts.constrainHeight()*0.495;
                      double width1 = cntrnts.constrainWidth()*0.99;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AssignedReports(
                            key: logic.assignedReports,
                            logic: logic,
                            height: height1,
                            width: width1,
                          ),
                          NoAssignedReports(
                            key: logic.noAssignedReports,
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
                  logic: logic,
                  width: width,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}