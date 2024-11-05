import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminUsers/user.dart';
import 'package:zohoanalytics/Models/AdminUsers/user_response.dart';
import 'package:zohoanalytics/Views/Components/DefaultLayout.dart';
import 'package:zohoanalytics/Views/Components/RowItemTemplate.dart';
import 'package:zohoanalytics/Views/Components/TextFieldForm.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/groups-users/groups-users_logic.dart';
import 'package:zohoanalytics/constants.dart';

// ignore: must_be_immutable
class NoAssignedUsers extends StatefulWidget {
  GroupsUsersLogic logic;
  double height;
  double width;
  NoAssignedUsers({
    super.key,
    required this.logic,
    required this.height,
    required this.width
  });

  @override
  State<NoAssignedUsers> createState() => NoAssignedUsersState();
}

class NoAssignedUsersState extends State<NoAssignedUsers> {

  @override
  void initState() {
    super.initState();
    widget.logic.noAssignedDataFuture = widget.logic.fetchNoAssignedData();
  }

  void refresh(){
    setState(() {
      widget.logic.noAssignedDataFuture = widget.logic.fetchNoAssignedData();
    });
  }

  void updateList(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout2(
      height: widget.height,
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Usuarios NO asignados", style: layoutTitle,),
          const SizedBox(height: 10.0),
          TextFieldForm(
            label: "Buscar por nombre",
            controller: widget.logic.searchController,
            onChanged: widget.logic.searchReports,
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
            child:  SizedBox(
              width: widget.width,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10,),
                  Expanded(flex: 2,child: Text("Nombre",style: tableStyle,)),
                  Expanded(flex: 2,child: Text("Usuario",style: tableStyle,)),
                  Expanded(child: Icon(Icons.add,color: Colors.white,size: 20,)),
                  SizedBox(width: 10,),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<UserResponse>(
                future: widget.logic.noAssignedDataFuture,
                builder: (BuildContext context, AsyncSnapshot<UserResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Scrollbar(
                      controller: widget.logic.noAssignedScrollController,
                      trackVisibility: true,
                      thumbVisibility: true,
                      child: ListView.builder(
                        controller: widget.logic.noAssignedScrollController,
                        itemCount: widget.logic.assignedNoReportsData.length,
                        itemBuilder: (_,index){
                          User item = widget.logic.assignedNoReportsData[index];
                          return SizedBox(
                            width: widget.width,
                            child: RowItemTemplate(
                              isEven: index % 2 == 0,
                              child: Row(
                                children: [
                                  Expanded(flex: 2,child: Text(item.name,style: tableItemStyle)),
                                  Expanded(flex: 2,child: Text(item.userName,style: tableItemStyle,)),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: ()=>widget.logic.addToAssigned(item), 
                                      child: LayoutBuilder(
                                        builder: (_,constraint){
                                          return constraint.constrainWidth()<50 
                                          ? Icon(Icons.add ,color: blue1,size: 20,)
                                          : const Text("Agregar",style: tableItemStyle,);
                                        },
                                      )
                                    )
                                  ),
                                ],
                              ),
                            ),
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