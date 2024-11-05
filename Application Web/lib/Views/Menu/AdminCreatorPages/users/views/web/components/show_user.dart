import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zohoanalytics/Models/AdminUsers/user.dart';
import 'package:zohoanalytics/Models/AdminUsers/user_response.dart';
import 'package:zohoanalytics/Views/Components/LoginButton.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/users/user_screen_logic.dart';
import 'package:zohoanalytics/constants.dart';

import 'item_list_user.dart';

// ignore: must_be_immutable
class ShowUser extends StatefulWidget {
  UserScreenLogic logic;
  double height;
  double width;
  bool? isPhone;
  ShowUser({super.key, required this.logic,required this.height, required this.width, this.isPhone});

  @override
  State<ShowUser> createState() => ShowUserState();
}

class ShowUserState extends State<ShowUser> {

  @override
  void initState() {
    super.initState();
    widget.logic.dataFuture = widget.logic.fetchData();
  }

  void refresh(){
    setState(() {
      widget.logic.dataFuture = widget.logic.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.isPhone = widget.isPhone??false;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),       
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Listado de usuarios", style: layoutTitle,),
              Visibility(
                visible: !widget.isPhone!,
                child: InkWell(
                  onTap:widget.logic.moveToEditAdd,
                  child: LoginButton(
                    width: MediaQuery.sizeOf(context).width*0.4,
                    title: "➕   /   ✏️",
                  ),
                ),
              ),             
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: blue1,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
              border: Border.all(
                color: Colors.black
              )
            ),
            child: const Row(
              children: [
                SizedBox(width: 10,),
                SizedBox(
                  width: 90,
                  child: Text("Estatus",style: tableStyle,)
                ),
                Expanded(flex: 3,child: Text("Nombre",style: tableStyle,)),
                Expanded(flex: 3,child: Text("Usuario",style: tableStyle,)),
                Expanded(flex: 3,child: Text("Correo",style: tableStyle,)),
                Expanded(flex: 2,child: Text("Número empleado",style: tableStyle,textAlign: TextAlign.center,)),
                Expanded(flex: 3,child: Text("Tipo de usuario",style: tableStyle,textAlign: TextAlign.center,)),
                Expanded(flex: 3,child: Text("Categoria de usuario",style: tableStyle,textAlign: TextAlign.center,)),
                SizedBox(width: 10,),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<UserResponse>(
                future: widget.logic.dataFuture,
                builder: (BuildContext context, AsyncSnapshot<UserResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Skeletonizer(
                      enabled: true,
                      ignoreContainers: true,
                      child: ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return ItemListUser(
                            item: User(
                              status: "abierto",
                              name:"Ejemplo",
                              userName: "ejemplo",
                              email: "ejemplo@ejemplo.com",
                              employeeNumber: 12345,
                              userType: "ejemplo",
                              userCategory: "ejemplo",                           
                            ),
                            isEven: index % 2 == 0,
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Scrollbar(
                      controller: widget.logic.listScrollController,
                      trackVisibility: true,
                      thumbVisibility: true,
                      child: ListView.builder(
                        controller: widget.logic.listScrollController,
                        itemCount: widget.logic.users.length,
                        itemBuilder: (_,index){
                          return ItemListUser(
                            item: widget.logic.users[index],
                            isEven: index % 2 == 0,
                          );
                        }
                      ),
                    );
                  }
                },
              )
          )
        ],
      ),
    );
  }
}