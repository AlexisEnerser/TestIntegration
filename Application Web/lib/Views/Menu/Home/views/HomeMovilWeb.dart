import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/Material.dart';
import 'package:zohoanalytics/constants.dart';

import '../HomeLogic.dart';

class HomeMovilWeb extends StatefulWidget {
  final HomeLogic logic;
  const HomeMovilWeb({super.key,required this.logic});
  @override
  State<HomeMovilWeb> createState() => _HomeMovilWebState();
}

class _HomeMovilWebState extends State<HomeMovilWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white,),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: ContainedTabBarView(
              initialIndex: widget.logic.selectedIndex,
              tabBarProperties: TabBarProperties(
                background: Container(color: blue1,),
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: const Color.fromARGB(255, 170, 170, 170)
              ),
              tabs: widget.logic.webMovilItemTabs(),
              views: widget.logic.viewsWebMovil(),
              onChange: (index) => {},
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
                Image.asset("assets/images/logoBlanco.png",fit: BoxFit.fitWidth,width: 150,),
                const Spacer(),
                InkWell(
                  onTap:()=>widget.logic.closeSession(context),
                  child: const Icon(Icons.logout,size: 30,color: Colors.white,),
                ),
                const SizedBox(width: 15,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
