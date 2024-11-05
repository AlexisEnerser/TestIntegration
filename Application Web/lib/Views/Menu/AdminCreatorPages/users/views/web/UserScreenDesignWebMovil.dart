import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/DefaultLayout.dart';
import 'package:zohoanalytics/Views/Components/MovileTabDesign.dart';
import 'package:zohoanalytics/constants.dart';
import '../../user_screen_logic.dart';
import 'components/add_user.dart';
import 'components/edit_user.dart';
import 'components/show_user.dart';

// ignore: must_be_immutable
class UserScreenDesignWebMovil extends StatelessWidget {
  UserScreenLogic logic;
  UserScreenDesignWebMovil({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_,constraints){
        return ContainedTabBarView(
          key: logic.tabControllerWebMovil,
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
              child: ShowUser(
                height: constraints.constrainHeight(),
                width: constraints.constrainWidth(),
                key: logic.showUsers,
                logic: logic,
                isPhone: true,
              )
            ),
            DefaultLayout2(
              height: constraints.constrainHeight(),
                width: constraints.constrainWidth(),
              child: AddUser(
                height: constraints.constrainHeight(),
                width: constraints.constrainWidth(),
                logic: logic,
                isPhone: true,
              ),
            ),
            DefaultLayout2(
              height: constraints.constrainHeight(),
                width: constraints.constrainWidth(),
              child: EditUser(
                height: constraints.constrainHeight(),
                width: constraints.constrainWidth(),
                key: logic.editUser,
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