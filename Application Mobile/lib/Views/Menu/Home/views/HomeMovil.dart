
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:zohoanalytics/constants.dart';

import '../HomeLogic.dart';

class HomeMovil extends StatefulWidget {
  final HomeLogic logic;
  const HomeMovil({super.key,required this.logic});
  @override
  State<HomeMovil> createState() => _HomeMovilState();
}

class _HomeMovilState extends State<HomeMovil> {

  void setPage(int index){
    widget.logic.setPage(index);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: blue2,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          body: Stack(
            children: [
              Container(color: Colors.white,),
              Padding(
                padding: const EdgeInsets.only(top: 70,bottom: 10),
                child: widget.logic.viewsMovil(),
              ),
              Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  color: blue2,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 15,),
                    Image.asset("assets/images/logoBlanco.png",width: 110,height: 40,fit: BoxFit.fill,),
                    const Spacer(),
                    SizedBox(
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userData!.name ,style: const TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold)),
                          Text(userData!.category ,style: const TextStyle(color:Colors.white,fontSize: 10,fontWeight: FontWeight.w200))
                        ],
                      ),
                    ),
                    const SizedBox(width: 15,),
                    InkWell(
                      onTap:()=>widget.logic.closeSession(context),
                      child: const SizedBox(
                        height: 40,
                        width: 50,
                        child:  Icon(Icons.logout,size: 30,color: Colors.white,),
                      ),
                    ),
                    const SizedBox(width: 15,),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: FluidNavBar(
            icons: [
              FluidNavBarIcon(icon: Icons.dashboard),
              FluidNavBarIcon(icon: Icons.quickreply_outlined),
              FluidNavBarIcon(icon: Icons.favorite),
            ],
            animationFactor: 0.6,
            onChange: setPage,
            style: FluidNavBarStyle(
                barBackgroundColor: blue2,
                iconBackgroundColor: Colors.white,
                iconSelectedForegroundColor: blue2,
                iconUnselectedForegroundColor: blue1
            ),// (4)
          ),
        ),
      ),
    );
  }
}
