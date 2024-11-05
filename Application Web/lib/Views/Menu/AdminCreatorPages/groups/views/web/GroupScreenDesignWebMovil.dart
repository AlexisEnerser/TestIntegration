import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/DefaultLayout.dart';
import 'package:zohoanalytics/Views/Components/MovileTabDesign.dart';
import 'package:zohoanalytics/constants.dart';
import '../../group_screen_logic.dart';
import 'components/add_group.dart';
import 'components/edit_group.dart';
import 'components/show_groups.dart';

// ignore: must_be_immutable
class GroupScreenDesignWebMovil extends StatelessWidget {
  GroupScreenLogic logic;
  GroupScreenDesignWebMovil({super.key, required this.logic});

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
              child: ShowGroups(
                key: logic.showGroups,
                logic: logic,
              )
            ),
            DefaultLayout2(
              height: constraints.constrainHeight(),
              width: constraints.constrainWidth(),
              child: AddGroup(
                height: constraints.constrainHeight(),
                width: constraints.constrainWidth(),
                logic: logic,
                isPhone: true,
              ),
            ),
            DefaultLayout2(
              height: constraints.constrainHeight(),
              width: constraints.constrainWidth(),
              child: EditGroup(
                height: constraints.constrainHeight(),
                width: constraints.constrainWidth(),
                key: logic.editGroup,
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