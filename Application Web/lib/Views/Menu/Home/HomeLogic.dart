import 'package:flutter/Material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zohoanalytics/CustomLibraries/SideNavigation/src/side_menu.dart';
import 'package:zohoanalytics/CustomLibraries/SideNavigation/src/side_menu_controller.dart';
import 'package:zohoanalytics/CustomLibraries/SideNavigation/src/side_menu_expansion_item.dart';
import 'package:zohoanalytics/CustomLibraries/SideNavigation/src/side_menu_item.dart';
import 'package:zohoanalytics/Views/Components/MovileTabDesign.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/groups-reports/groups-reports_screen_design.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/groups-users/groups-users_screen_design.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/groups/group_screen_design.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/reports/reports_screen_design.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/users-reports/users-reports_screen_design.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/users/user_screen_design.dart';
import 'package:zohoanalytics/constants.dart';
import '../../Access/Login/Login.dart';
import '../../Components/decisionDialogAlert.dart';
import '../HomePages/FavoritePage.dart';
import '../HomePages/FirstPage/FirstPage.dart';
import '../HomePages/GroupPage/GroupPage.dart';

class HomeLogic{
  final GlobalKey<State<SideMenu>> myKeyMenu = GlobalKey();
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();


  void toggle(){
    final test = myKeyMenu.currentState as SideMenuState?;
    test?.toggleMenu();
  }

  Future<void> closeSession(BuildContext context)async{
    bool response = await showDecisionAlert(title: "Atención", message: "¿Estas seguro de cerrar tu sesión?",context: context)??false;
    if(response){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
      await prefs.remove('password');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }
  }

  int selectedIndex = 0;
 
  List<Widget> viewsWeb(){
    if(userData!.userType == "lector"){
      return [
        const FirstPage(),
        const GroupPage(),
        const FavoritePage()
      ];
    }
    else{
      return [
        const ReportsScreenDesign(),
        const UserScreenDesign(),
        const UsersReportsScreenDesign(),
        const GroupScreenDesign(),
        const GroupsReportsScreenDesign(),
        const GroupsUsersScreenDesign(),
      ];
    }
  }
  List<dynamic> webItemTabs(){
    if(userData!.userType == "lector"){
      return[
        SideMenuItem(
          title: 'Reportes',
          icon: const Icon(Icons.dashboard),
          onTap: changePage,
        ),
        SideMenuItem(
          title: 'Grupos',
          icon: const Icon(Icons.quickreply_outlined),
          onTap: changePage,
        ),
        SideMenuItem(
          title: 'Favoritos',
          icon: const Icon(Icons.favorite),
          onTap: changePage,
        ),
      ];
    }
    else{
      return [
        SideMenuItem(
          title: 'Reportes',
          icon: const Icon(Icons.dashboard),
          onTap: changePage,
        ),
        SideMenuExpansionItem(
          title: "Usuarios",
          icon: const Icon(Icons.person),
          children: [
            SideMenuItem(
              title: 'Agregar, Editar Usu.',
              onTap: changePage,
              icon: const Icon(Icons.edit),
            ),
            SideMenuItem(
              title: 'Asignar Reportes Usu.',
              onTap: changePage,
              icon: const Icon(Icons.quickreply_outlined),
            ),
          ],
        ),
        SideMenuExpansionItem(
          title: "Grupos",
          icon: const Icon(Icons.quickreply_outlined),
          children: [
            SideMenuItem(
              title: 'Agregar, Editar Grp.',
              onTap: changePage,
              icon: const Icon(Icons.edit),
            ),
            SideMenuItem(
              title: 'Asignar Reportes Grp.',
              onTap: changePage,
              icon: const Icon(Icons.quickreply_outlined),
            ),
            SideMenuItem(
              title: 'Asignar Usuarios',
              onTap: changePage,
              icon: const Icon(Icons.supervisor_account),
            )
          ],
        ),
      ];
    }
  }
  void  changePage(int index, SideMenuController _){
    sideMenu.changePage(index);
  }
  
  
  List<Widget> webMovilItemTabs(){
    if(userData!.userType == "lector"){
      return const [
        MobileTabDesign(
          icon: Icons.dashboard,
          title: 'Inicio',
        ),
        MobileTabDesign(
          icon: Icons.quickreply_outlined,
          title: 'Grupos',
        ),
        MobileTabDesign(
          icon: Icons.favorite,
          title: 'Favoritos',
        ),
      ];
    }
    else{
      return const [
        MobileTabDesign(
          icon: Icons.dashboard,
          title: 'Reportes',
        ),
        MobileTabDesign(
          icon: Icons.dashboard,
          title: 'Reportes\nUsuarios',
        ),
        MobileTabDesign(
          icon: Icons.quickreply_outlined,
          title: 'Grupos',
        ),
        MobileTabDesign(
          icon: Icons.quickreply_outlined,
          title: 'Grupos\nReportes',
        ),
        MobileTabDesign(
          icon: Icons.quickreply_outlined,
          title: 'Grupos\nUsuarios',
        ),
        MobileTabDesign(
          icon: Icons.person,
          title: 'Usuarios',
        ),
      ];
    }
  }
  List<Widget> viewsWebMovil(){
    if(userData!.userType == "lector"){
      return [
        const FirstPage(),
        const GroupPage(),
        const FavoritePage()
      ];
    }
    else{
      return [
        const ReportsScreenDesign(),
        const UsersReportsScreenDesign(),
        const GroupScreenDesign(),
        const GroupsReportsScreenDesign(),
        const GroupsUsersScreenDesign(),
        const UserScreenDesign()
      ];
    }
  }

  String title ="";
  void setPage(int index){
    if(userData!.userType == "lector"){
      switch(index){
        case 0:
          title ="";
          break;
        case 1:
          title ="Grupos";
          break;
        case 2:
          title ="Favoritos";
          break;
      }
    }
    else{
      title="";
    }
    selectedIndex = index;
  }
}