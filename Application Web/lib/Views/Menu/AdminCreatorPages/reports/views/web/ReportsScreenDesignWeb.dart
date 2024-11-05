import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/DefaultLayout.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/reports/views/web/components/show_reports.dart';
import '../../reports_screen_logic.dart';
import 'components/add_reports.dart';
import 'components/edit_report.dart';

// ignore: must_be_immutable
class ReportsScreenDesignWeb extends StatelessWidget {
  ReportsScreenLogic logic;
  ReportsScreenDesignWeb({super.key, required this.logic});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
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
                  child: AddReports(
                    height: height1,
                    width: width1,
                    logic: logic,
                  ),
                ),
                DefaultLayout2(
                  height: height1,
                  width: width1,
                  child: EditReport(
                    height: height1,
                    width: width1,
                    key: logic.updateReports,
                    logic: logic,
                  ),
                )
              ],
            ),
            DefaultLayout2(
              height: height2,
              width: width2,
              child: ShowReports(
                height: height2,
                width: width2,
                key: logic.linkListReports,
                logic: logic,
              ),
            )
          ]
        );
      },
    );
  }
}