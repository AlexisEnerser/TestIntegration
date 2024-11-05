import 'package:flutter/Material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Access/Login/Login.dart';
import '../../Components/decisionDialogAlert.dart';
import '../HomePages/FavoritePage.dart';
import '../HomePages/FirstPage/FirstPage.dart';
import '../HomePages/GroupPage/GroupPage.dart';

class HomeLogic{
  PageController pageController = PageController();


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
  Widget viewsMovil(){
    switch(selectedIndex){
      case 0: return const FirstPage();
      case 1: return const GroupPage();
      case 2: return const FavoritePage();
      default: return Container();
    }
  }
  
  
  String title ="";
  void setPage(int index){
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
    selectedIndex = index;
  }
}