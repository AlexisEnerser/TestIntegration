import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zohoanalytics/Models/AdminGroups/group.dart';
import 'package:zohoanalytics/Models/AdminGroups/group_response.dart';
import 'package:zohoanalytics/constants.dart';
import '../../../../../../Components/TextFieldForm.dart';
import '../../../group_screen_logic.dart';
import 'item_list_group.dart';

// ignore: must_be_immutable
class ShowGroups extends StatefulWidget {
  GroupScreenLogic logic;
  ShowGroups({super.key, required this.logic});

  @override
  State<ShowGroups> createState() => ShowGroupsState();
}

class ShowGroupsState extends State<ShowGroups> {

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

  void search(){
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        const Text("Listado de grupos", style: layoutTitle,),
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
          child: const Row(
            children: [
              SizedBox(width: 10,),
              Expanded(child: Text("Nombre",style: tableStyle,)),
              Expanded(child: Text("Descripción",style: tableStyle,)),
              SizedBox(width: 10,),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<GroupResponse>(
              future: widget.logic.dataFuture,
              builder: (BuildContext context, AsyncSnapshot<GroupResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Skeletonizer(
                    enabled: true,
                    ignoreContainers: true,
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return ItemListGroup(
                          item: Group(id: 0,name:"Ejemplo", description: "ejemplo de descripción con una descripción bastante larga para poder visualizar un ejemplo más adoc al diseño real de los datos cargados"),
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
                      itemCount: widget.logic.groups.length,
                      itemBuilder: (_,index){
                        return ItemListGroup(
                          item: widget.logic.groups[index],
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
    );
  }
}