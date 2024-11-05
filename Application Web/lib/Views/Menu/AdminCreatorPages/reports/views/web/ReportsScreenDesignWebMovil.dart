import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/DefaultLayout.dart';
import 'package:zohoanalytics/Views/Components/MovileTabDesign.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/reports/views/web/components/show_reports.dart';
import 'package:zohoanalytics/constants.dart';
import '../../reports_screen_logic.dart';
import 'components/add_reports.dart';
import 'components/edit_report.dart';

// ignore: must_be_immutable
class ReportsScreenDesignWebMovil extends StatelessWidget {
  ReportsScreenLogic logic;
  ReportsScreenDesignWebMovil({super.key, required this.logic});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_,constraints){
        return ContainedTabBarView(
          initialIndex: 0,
          tabBarProperties: TabBarProperties(
            background: Container(color: blue1,),
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: const Color.fromARGB(255, 170, 170, 170)
          ),
          tabs: const [
            MobileTabDesign(
              icon: Icons.list,
              title: 'Listado',
            ),
            MobileTabDesign(
              icon: Icons.add,
              title: 'Agregar',
            ),
            MobileTabDesign(
              icon: Icons.edit,
              title: 'Editar',
            ),
          ],
          views: [
            DefaultLayout2(
              height: constraints.constrainHeight(),
              width: constraints.constrainWidth(),
              child: ShowReports(
                height: constraints.constrainHeight(),
                width: constraints.constrainWidth(),
                key: logic.linkListReports,
                logic: logic,
              )
            ),
            DefaultLayout2(
              height: constraints.constrainHeight(),
              width: constraints.constrainWidth(),
              child: AddReports(
                height: constraints.constrainHeight(),
                width: constraints.constrainWidth(),
                logic: logic,
                isPhone: true,
              ),
            ),
            DefaultLayout2(
              height: constraints.constrainHeight(),
              width: constraints.constrainWidth(),
              child: EditReport(
                height: constraints.constrainHeight(),
                width: constraints.constrainWidth(),
                key: logic.updateReports,
                logic: logic,
                isPhone: true,
              ),
            )
          ],
          onChange: (index) => {},
        );
      },
    );
  }
}