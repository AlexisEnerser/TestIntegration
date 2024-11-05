import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/LoginButton.dart';
import 'package:zohoanalytics/Views/Components/TextFieldForm.dart';
import 'package:zohoanalytics/constants.dart';
import '../../../group_screen_logic.dart';

// ignore: must_be_immutable
class AddGroup extends StatefulWidget {
  GroupScreenLogic logic;
  bool? isPhone;
  double height;
  double width;
  AddGroup({super.key, required this.logic, this.isPhone, required this.height, required this.width});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        const Text("Creación de grupos", style: layoutTitle,),
        const SizedBox(height: 20.0),
        Expanded(
          child: Scrollbar(
            controller: widget.logic.addScrollController,
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              controller: widget.logic.addScrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFieldForm(
                    controller: widget.logic.nameCreateController,
                    label: "Nombre del grupo",
                  ),
                  const SizedBox(height: 10.0),
                  TextFieldForm(
                    controller: widget.logic.descriptionCreateController,
                    label: "Descripción del grupo",
                  ),
                  const SizedBox(height: 10.0),
                  InkWell(
                    onTap:() async{
                      await widget.logic.createGroup(context);
                      setState(() {});
                    },
                    child: LoginButton(
                      width: MediaQuery.sizeOf(context).width*0.4,
                      title: "Agregar",
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}