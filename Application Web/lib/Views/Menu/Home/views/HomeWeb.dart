import 'package:flutter/Material.dart';
import 'package:zohoanalytics/CustomLibraries/SideNavigation/src/side_menu.dart';
import 'package:zohoanalytics/CustomLibraries/SideNavigation/src/side_menu_display_mode.dart';
import 'package:zohoanalytics/CustomLibraries/SideNavigation/src/side_menu_style.dart';
import '../../../../constants.dart';
import '../HomeLogic.dart';
import 'package:zohoanalytics/Views/Components/StringsExtensions.dart';

class HomeWeb extends StatefulWidget {
  final HomeLogic logic;
  const HomeWeb({super.key,required this.logic});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  @override
  void initState() {
    widget.logic.sideMenu.addListener((index) {
      widget.logic.pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SideMenu(
                  key: widget.logic.myKeyMenu,
                  style: SideMenuStyle(
                    openSideMenuWidth: 240,
                    displayMode: SideMenuDisplayMode.open,
                    backgroundColor: blue1,
                    selectedColor: Colors.white,
                    toggleColor: Colors.red,
                    unselectedTitleTextStyleExpandable: const TextStyle(
                      color: Colors.white
                    ),
                    unselectedTitleTextStyle: const TextStyle(
                      color: Colors.white
                    ),
                    unselectedIconColor: Colors.white,
                    unselectedIconColorExpandable: Colors.white
                  ),
                  controller: widget.logic.sideMenu,
                  items: widget.logic.webItemTabs(),
                ),
                Expanded(
                  child: PageView(
                    controller: widget.logic.pageController,
                    children: widget.logic.viewsWeb(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              color: barColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 15,),
                Image.asset("assets/images/logoBlanco.png",fit: BoxFit.fill,width: 150,height: 60,),
                const SizedBox(width: 30,),
                InkWell(
                  onTap:widget.logic.toggle,
                  child: const Icon(Icons.menu,size: 30,color: Colors.white,),
                ),
                const Spacer(),
                Text( widget.logic.title,style: const TextStyle(color: Colors.white,fontSize: 30),),
                const Spacer(),
                SizedBox(
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userData!.name,style: const TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(userData!.category.capitalize() ,style: const TextStyle(color: Color.fromARGB(255, 184, 184, 184),fontSize: 13, fontWeight: FontWeight.w200)),
                    ],
                  ),
                ),
                const SizedBox(width: 25,),
                InkWell(
                  onTap:()=>widget.logic.closeSession(context),
                  child: const Icon(Icons.logout,size: 30,color: Colors.white,),
                ),
                const SizedBox(width: 20,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
