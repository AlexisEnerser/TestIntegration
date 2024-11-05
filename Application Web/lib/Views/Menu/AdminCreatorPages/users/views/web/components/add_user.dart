import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/LoginButton.dart';
import 'package:zohoanalytics/Views/Components/OptionMenuButton.dart';
import 'package:zohoanalytics/Views/Components/TextFieldForm.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/users/user_screen_logic.dart';
import 'package:zohoanalytics/constants.dart';

// ignore: must_be_immutable
class AddUser extends StatefulWidget {
  UserScreenLogic logic;
  double height;
  double width;
  bool? isPhone;
  AddUser({super.key, required this.logic, required this.height, required this.width, this.isPhone});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    widget.isPhone = widget.isPhone??false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        const Text("Creación de usuarios", style: layoutTitle,),
        const SizedBox(height: 20.0),
        content()
      ],
    );
  }

  Widget content(){
    if(widget.isPhone!){
      return Expanded(
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
                  label: "Nombre",
                ),
                const SizedBox(height: 10.0),
                TextFieldForm(
                  controller: widget.logic.userNameCreateController,
                  label: "Usuario",
                ),
                const SizedBox(height: 10.0),
                TextFieldForm(
                  controller: widget.logic.passwordCreateController,
                  label: "Contraseña",
                ),
                const SizedBox(height: 10.0),
                TextFieldForm(
                  controller: widget.logic.emailCreateController,
                  label: "Correo",
                ),
                const SizedBox(height: 10.0),
                TextFieldForm(
                  controller: widget.logic.employeeNumberCreateController,
                  label: "Número de empleado",
                  isNumeric: true,
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OptionMenuButton(
                      width: widget.width*0.45,
                      hint: "Selecciona un tipo de usuario",
                      options: widget.logic.userTypes,
                      onSelected: (selected){
                        if(selected!=null){
                          setState(() {
                              widget.logic.selectedCreateUserType = selected;
                          });
                        }
                      },
                      selectedOption: widget.logic.selectedCreateUserType,
                    ),
                    OptionMenuButton(
                      width: widget.width*0.45,
                      hint: "Selecciona una categoria de usuario",
                      options: widget.logic.userCategory,
                      onSelected: (selected){
                        if(selected!=null){
                          setState(() {
                              widget.logic.selectedCreateUserCategory = selected;
                          });
                        }
                      },
                      selectedOption: widget.logic.selectedCreateUserCategory,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                InkWell(
                  onTap:() async{
                    await widget.logic.createUser(context, true);
                    setState(() {});
                  },
                  child: LoginButton(
                    width: MediaQuery.sizeOf(context).width,
                    title: "Agregar",
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    else{
      return Expanded(
        child: Scrollbar(
          controller: widget.logic.addScrollController,
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            controller: widget.logic.addScrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldForm(
                  controller: widget.logic.nameCreateController,
                  label: "Nombre",
                ),
                const SizedBox(height: 10.0),
                TextFieldForm(
                  controller: widget.logic.userNameCreateController,
                  label: "Usuario",
                ),
                const SizedBox(height: 10.0),
                TextFieldForm(
                  controller: widget.logic.passwordCreateController,
                  label: "Contraseña",
                ),
                const SizedBox(height: 10.0),
                TextFieldForm(
                  controller: widget.logic.emailCreateController,
                  label: "Correo",
                ),
                const SizedBox(height: 10.0),
                TextFieldForm(
                  controller: widget.logic.employeeNumberCreateController,
                  label: "Número de empleado",
                  isNumeric: true,
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OptionMenuButton(
                      width: widget.width*0.45,
                      hint: "Selecciona un tipo de usuario",
                      options: widget.logic.userTypes,
                      onSelected: (selected){
                        if(selected!=null){
                          setState(() {
                              widget.logic.selectedCreateUserType = selected;
                          });
                        }
                      },
                      selectedOption: widget.logic.selectedCreateUserType,
                    ),
                    OptionMenuButton(
                      width: widget.width*0.45,
                      hint: "Selecciona una categoria de usuario",
                      options: widget.logic.userCategory,
                      onSelected: (selected){
                        if(selected!=null){
                          setState(() {
                              widget.logic.selectedCreateUserCategory = selected;
                          });
                        }
                      },
                      selectedOption: widget.logic.selectedCreateUserCategory,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                InkWell(
                  onTap:() async{
                    await widget.logic.createUser(context,false);
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
      );
    }
  }
}