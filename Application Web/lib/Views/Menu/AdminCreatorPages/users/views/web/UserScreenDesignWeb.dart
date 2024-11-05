import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/LoginButton.dart';
import '../../../../../Components/DefaultLayout.dart';
import '../../user_screen_logic.dart';
import 'components/add_user.dart';
import 'components/edit_user.dart';
import 'components/show_user.dart';

// ignore: must_be_immutable
class UserScreenDesignWeb extends StatefulWidget {
  UserScreenLogic logic;
  UserScreenDesignWeb({super.key, required this.logic});

  @override
  State<UserScreenDesignWeb> createState() => _UserScreenDesignWebState();
}

class _UserScreenDesignWebState extends State<UserScreenDesignWeb> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    try{
      widget.logic.tabControllerWeb = TabController(length: 2, vsync: this);
    }catch(e){}
    return LayoutBuilder(
      builder: (_,constraints){
        double width1 = constraints.constrainWidth()*0.48;
        double height1 = constraints.constrainHeight()-90;
        return TabBarView(
          controller: widget.logic.tabControllerWeb,
          children: <Widget>[
            Center(
              child: DefaultLayout2(
                width: constraints.constrainWidth()*0.99,
                height: constraints.constrainHeight()*0.98,
                child: ShowUser(
                  width: constraints.constrainWidth()*0.99,
                  height: constraints.constrainHeight()*0.98,
                  key: widget.logic.showUsers,
                  logic: widget.logic,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap:(){
                      setState(() {
                        widget.logic.moveToList(false,false);
                      });
                    },
                    child: LoginButton(
                      width: MediaQuery.sizeOf(context).width*0.4,
                      title: "Regresar",
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultLayout2(
                      width: width1,
                      height: height1,
                      child: AddUser(
                        height: height1,
                        width: width1,
                        logic: widget.logic,
                      ),
                    ),
                    DefaultLayout2(
                      width: width1,
                      height: height1,
                      child: EditUser(
                        height: height1,
                        width: width1,
                        key: widget.logic.editUser,
                        logic: widget.logic,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }
}