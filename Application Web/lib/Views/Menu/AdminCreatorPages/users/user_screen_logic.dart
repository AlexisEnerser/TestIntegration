import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminUsers/admin_user_create_request.dart';
import 'package:zohoanalytics/Models/AdminUsers/admin_user_update_request.dart';
import 'package:zohoanalytics/Models/AdminUsers/user.dart';
import 'package:zohoanalytics/Models/AdminUsers/user_response.dart';
import 'package:zohoanalytics/Models/GeneralResponse.dart';
import 'package:zohoanalytics/Services/UserServices.dart';
import 'package:zohoanalytics/Views/Components/OkDialogAlert.dart';
import 'views/web/components/edit_user.dart';
import 'views/web/components/show_user.dart';

class UserScreenLogic{
  final GlobalKey<State<ShowUser>> showUsers = GlobalKey();
  final GlobalKey<State<EditUser>> editUser = GlobalKey();
  late final TabController tabControllerWeb;
  GlobalKey<ContainedTabBarViewState> tabControllerWebMovil = GlobalKey();
  final listScrollController = ScrollController();
  final addScrollController = ScrollController();
  final editScrollController = ScrollController();

  //create fields
  TextEditingController nameCreateController = TextEditingController();
  TextEditingController userNameCreateController = TextEditingController();
  TextEditingController passwordCreateController = TextEditingController();
  TextEditingController emailCreateController = TextEditingController();
  TextEditingController employeeNumberCreateController = TextEditingController();
  String selectedCreateUserType = "";
  List<String> userTypes = const [
                          "Administrador",
                          "Creador",
                          "Lector",
                        ];
  String selectedCreateUserCategory = "";
  List<String> userCategory = const [
                          "Estación",
                          "Supervisor",
                          "Gerente",
                          "Administrativo"
                        ];
  //create fields

  //update fields
  User selectedToEdit = User();
  TextEditingController textselectedToEdit = TextEditingController();
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController userNameUpdateController = TextEditingController();
  TextEditingController passwordUpdateController = TextEditingController();
  TextEditingController emailUpdateController = TextEditingController();
  TextEditingController employeeNumberUpdateController = TextEditingController();
  String selectedUpdateUserType = "";
  String selectedUpdateUserCategory = "";
  List<String> statusTypes = const [
                          "Activo",
                          "Inactivo",
                          "Eliminado"
                        ];
  String selectedUpdateStatusType = "";
  //update fields


  void moveToEditAdd(){
    tabControllerWeb.animateTo(tabControllerWeb.index+1);
  }

  void moveToList(bool isPhone, bool isEdit){
    selectedToEdit = User();
    textselectedToEdit.text ="";
    nameCreateController.text ="";
    userNameCreateController.text ="";
    passwordCreateController.text ="";
    emailCreateController.text ="";
    employeeNumberCreateController.text ="";
    selectedCreateUserType = "";
    selectedCreateUserCategory = "";
    if(isPhone){
      if(isEdit){
        tabControllerWebMovil.currentState?.previous();
      }
      tabControllerWebMovil.currentState?.previous();
    }
    else{
      tabControllerWeb.animateTo(tabControllerWeb.index-1);
    }
  }

  late Future<UserResponse> dataFuture;
  List<User> users = [];
  Future<UserResponse> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    UserResponse response = await consultAllUsers();
    users  = response.users;
    final updateUserState = editUser.currentState as EditUserState?;
    updateUserState?.setUsers();
    return response;
  }

  Future<void> createUser(BuildContext context,bool isPhone)async{
    if(nameCreateController.text.isEmpty){
      showOkAlert(
        context: context,
        title: "Error",
        message: "Es requerido ingresar el nombre del usuario",
      );
      return;
    }
    if(userNameCreateController.text.isEmpty){
      showOkAlert(
        context: context,
        title: "Error",
        message: "Es requerido ingresar un usuario",
      );
      return;
    }
    if(passwordCreateController.text.isEmpty){
      showOkAlert(
        context: context,
        title: "Error",
        message: "Es requerido ingresar una contraseña",
      );
      return;
    }
    if(selectedCreateUserType.isEmpty){
      showOkAlert(
        context: context,
        title: "Error",
        message: "Es requerido seleccionar un tipo de usuario",
      );
      return;
    }
    if(selectedCreateUserCategory.isEmpty){
      showOkAlert(
        context: context,
        title: "Error",
        message: "Es requerido seleccionar una categoria de usuario",
      );
      return;
    }

    GeneralResponse response = await createUserService(
      data: AdminUserCreateRequest(
        name: nameCreateController.text,
        userName: userNameCreateController.text,
        password: passwordCreateController.text,
        email: emailCreateController.text,
        employeeNumber: employeeNumberCreateController.text.isEmpty?0:int.parse(employeeNumberCreateController.text),
        idUserType: userTypes.indexOf(selectedCreateUserType)+1,
        idUserCategory: userCategory.indexOf(selectedCreateUserCategory)+1
      )
    );
    if(response.code!=1){      
      showOkAlert(
        // ignore: use_build_context_synchronously
        context: context,
        title: "Error",
        message: response.message,
      );
      return;
    }
    nameCreateController.text ="";
    userNameCreateController.text ="";
    passwordCreateController.text ="";
    emailCreateController.text ="";
    employeeNumberCreateController.text ="";

    selectedCreateUserType = "";
    selectedCreateUserCategory = "";

    //final showUsersState = showUsers.currentState as ShowUserState?;
    //showUsersState?.refresh();
    moveToList(isPhone,false);
  }

  void setItemToEdit(User item){
    nameUpdateController.text = item.name;
    userNameUpdateController.text = item.userName;
    passwordUpdateController.text = "";
    emailUpdateController.text = item.email;
    employeeNumberUpdateController.text = item.employeeNumber.toString();
    selectedUpdateUserType = userTypes[item.idUserType-1];
    selectedUpdateUserCategory = userCategory[item.idUserCategory-1];
    selectedUpdateStatusType = statusTypes[item.idStatus-5];
    selectedToEdit = item;
  }

  Future<void> updateUser(BuildContext context,bool isPhone)async{
    GeneralResponse response = await updateUserService(
      data: AdminUserUpdateRequest(
        id: selectedToEdit.id,
        name: nameUpdateController.text,
        password: passwordUpdateController.text,
        employeeNumber: int.parse(employeeNumberUpdateController.text),
        email: emailUpdateController.text,
        idUserCategory: userCategory.indexOf(selectedUpdateUserCategory)+1,
        idUserType: userTypes.indexOf(selectedUpdateUserType)+1,
        idStatus: statusTypes.indexOf(selectedUpdateStatusType)+5,
      )
    );
    if(response.code!=1){      
      showOkAlert(
        // ignore: use_build_context_synchronously
        context: context,
        title: "Error",
        message: response.message,
      );
      return;
    }
    selectedToEdit = User();
    textselectedToEdit.text ="";
    final showUsersState = showUsers.currentState as ShowUserState?;
    showUsersState?.refresh();
    moveToList(isPhone,true);
  }
}