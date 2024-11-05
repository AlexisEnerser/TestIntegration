import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/LoginButton.dart';
import 'package:zohoanalytics/Views/Components/OptionMenuButton.dart';
import 'package:zohoanalytics/Views/Components/TextFieldForm.dart';
import 'package:zohoanalytics/Views/Components/TextSearchField.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/users/user_screen_logic.dart';
import 'package:zohoanalytics/constants.dart';

// ignore: must_be_immutable
class EditUser extends StatefulWidget {
  UserScreenLogic logic;
  double height;
  double width;
  bool? isPhone;
  EditUser({super.key, required this.logic,required this.height, required this.width, this.isPhone});

  @override
  State<EditUser> createState() => EditUserState();
}

class EditUserState extends State<EditUser> {

  void setUsers(){
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.logic.textselectedToEdit.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print("Textfield value: ${widget.logic.textselectedToEdit.text}");
  }

  void onSelected(String selected){
    setState(() {            
      widget.logic.setItemToEdit(widget.logic.users.firstWhere((item)=>item.name==selected || item.userName == selected));
    });
  }

  List<String> itemToSearch(){
    return [ ...widget.logic.users.map((item) => item.name), ...widget.logic.users.map((item) => item.userName), ];
  }

  @override
  Widget build(BuildContext context) {
    widget.isPhone = widget.isPhone??false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        const Text("Editar de usuarios", style: layoutTitle,),
        const SizedBox(height: 20.0),
        content()
      ],
    );
  }

  Widget content(){
    if(widget.isPhone!){
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
                  list: itemToSearch(),//[ ...widget.logic.users.map((item) => item.name), ...widget.logic.users.map((item) => item.userName), ],//widget.logic.users.map((item)=>item.name).toList(),
                  hintText: "Busca por nombre o usuario",
                  onSelected: onSelected/*(selected){
                    setState(() {            
                      widget.logic.setItemToEdit(widget.logic.users.firstWhere((item)=>item.name==selected || item.userName == selected));
                    });
                  }*/,
                ),
                const SizedBox(height: 20.0),
                Visibility(
                  visible: widget.logic.selectedToEdit.id>0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFieldForm(
                        controller: widget.logic.userNameUpdateController,
                        label: "Usuario",
                        isActive: false,
                      ),
                      const SizedBox(height: 10.0),
                      TextFieldForm(
                        controller: widget.logic.passwordUpdateController,
                        label: "Contraseña",
                      ),
                      const SizedBox(height: 10.0),
                      TextFieldForm(
                        controller: widget.logic.nameUpdateController,
                        label: "Nombre",
                      ),
                      const SizedBox(height: 10.0),
                      TextFieldForm(
                        controller: widget.logic.emailUpdateController,
                        label: "Correo",
                      ),
                      const SizedBox(height: 10.0),
                      TextFieldForm(
                        controller: widget.logic.employeeNumberUpdateController,
                        label: "Número de empleado",
                      ),
                      const SizedBox(height: 10.0),
                      OptionMenuButton(
                        width: widget.width,
                        hint: "Selecciona un tipo de usuario",
                        options: widget.logic.userTypes,
                        onSelected: (selected){
                          if(selected!=null){
                            setState(() {
                                widget.logic.selectedUpdateUserType = selected;
                            });
                          }
                        },
                        selectedOption: widget.logic.selectedUpdateUserType,
                      ),
                      const SizedBox(height: 10.0),
                      OptionMenuButton(
                        width: widget.width,
                        hint: "Selecciona una categoria de usuario",
                        options: widget.logic.userCategory,
                        onSelected: (selected){
                          if(selected!=null){
                            setState(() {
                                widget.logic.selectedUpdateUserCategory = selected;
                            });
                          }
                        },
                        selectedOption: widget.logic.selectedUpdateUserCategory,
                      ),                           
                      const SizedBox(height: 10.0),
                      OptionMenuButton(
                        width: widget.width,
                        hint: "Selecciona un estatus",
                        options: widget.logic.statusTypes,
                        onSelected: (selected){
                          if(selected!=null){
                            setState(() {
                                widget.logic.selectedUpdateStatusType = selected;
                            });
                          }
                        },
                        selectedOption: widget.logic.selectedUpdateStatusType,
                      ),
                      const SizedBox(height: 10.0),
                      InkWell(
                        onTap:() async{
                          await widget.logic.updateUser(context,true);
                          setState(() {});
                        },
                        child: LoginButton(
                          width: MediaQuery.sizeOf(context).width,
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
    else{
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
                  list: itemToSearch(),
                  hintText: "Busca por nombre o usuario",
                  onSelected: onSelected
                ),
                const SizedBox(height: 20.0),
                Visibility(
                  visible: widget.logic.selectedToEdit.id>0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldForm(
                        controller: widget.logic.userNameUpdateController,
                        label: "Usuario",
                        isActive: false,
                      ),
                      const SizedBox(height: 10.0),
                      TextFieldForm(
                        controller: widget.logic.passwordUpdateController,
                        label: "Contraseña",
                      ),
                      const SizedBox(height: 10.0),
                      TextFieldForm(
                        controller: widget.logic.nameUpdateController,
                        label: "Nombre",
                      ),
                      const SizedBox(height: 10.0),
                      TextFieldForm(
                        controller: widget.logic.emailUpdateController,
                        label: "Correo",
                      ),
                      const SizedBox(height: 10.0),
                      TextFieldForm(
                        controller: widget.logic.employeeNumberUpdateController,
                        label: "Número de empleado",
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
                                    widget.logic.selectedUpdateUserType = selected;
                                });
                              }
                            },
                            selectedOption: widget.logic.selectedUpdateUserType,
                          ),
                          OptionMenuButton(
                            width: widget.width*0.45,
                            hint: "Selecciona una categoria de usuario",
                            options: widget.logic.userCategory,
                            onSelected: (selected){
                              if(selected!=null){
                                setState(() {
                                    widget.logic.selectedUpdateUserCategory = selected;
                                });
                              }
                            },
                            selectedOption: widget.logic.selectedUpdateUserCategory,
                          ),                           
                        ],                         
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OptionMenuButton(
                            width: widget.width*0.45,
                            hint: "Selecciona un estatus",
                            options: widget.logic.statusTypes,
                            onSelected: (selected){
                              if(selected!=null){
                                setState(() {
                                    widget.logic.selectedUpdateStatusType = selected;
                                });
                              }
                            },
                            selectedOption: widget.logic.selectedUpdateStatusType,
                          ),
                          InkWell(
                            onTap:() async{
                              await widget.logic.updateUser(context,false);
                              setState(() {});
                            },
                            child: LoginButton(
                              width: MediaQuery.sizeOf(context).width*0.4,
                              title: "Editar",
                            ),
                          )                          
                        ],                         
                      ),                        
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
}