import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/LoginButton.dart';
import 'package:zohoanalytics/Views/Components/TextFieldForm.dart';
import 'package:zohoanalytics/Views/Components/TextSearchField.dart';
import 'package:zohoanalytics/constants.dart';
import '../../../group_screen_logic.dart';

// ignore: must_be_immutable
class EditGroup extends StatefulWidget {
  GroupScreenLogic logic;
  bool? isPhone;
  double height;
  double width;
  EditGroup({super.key, required this.logic, this.isPhone, required this.height, required this.width});

  @override
  State<EditGroup> createState() => EditGroupState();
}

class EditGroupState extends State<EditGroup> {

  void setGroups(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    widget.isPhone = widget.isPhone??false;
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          const Text("Editar de grupos", style: layoutTitle,),
          const SizedBox(height: 20.0),
          content()
        ],
      ),
    );

  }


  Widget content(){
    return Expanded(
      child: Scrollbar(
        controller: widget.logic.editScrollController,
        thumbVisibility: true,
        trackVisibility: true,
        child: SingleChildScrollView(
          controller: widget.logic.editScrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textsearchfield(
                list: widget.logic.groups.map((item)=>item.name).toList(),
                hintText: "Busca un grupo por nombre",
                onSelected: (selected){
                  setState(() {                         
                    widget.logic.setItemToEdit(widget.logic.groups.firstWhere((item)=>item.name==selected));
                  });
                },
              ),
              const SizedBox(height: 20.0),
              Visibility(
                visible: widget.logic.selectedToEdit.id>0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFieldForm(
                      controller: widget.logic.nameUpdateController,
                      label: "Nombre del grupo",
                    ),
                    const SizedBox(height: 10.0),
                    TextFieldForm(
                      controller: widget.logic.descriptionUpdateController,
                      maxLines: 3,
                      label: "Descripción del grupo",
                    ),
                    const SizedBox(height: 10.0),
                    InkWell(
                      onTap:() async{
                        await widget.logic.updateReport(context);
                        setState(() {});
                      },
                      child: LoginButton(
                        width: MediaQuery.sizeOf(context).width*0.4,
                        title: "Editar",
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}