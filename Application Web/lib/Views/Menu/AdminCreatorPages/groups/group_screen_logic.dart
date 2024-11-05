import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminGroups/group.dart';
import 'package:zohoanalytics/Models/AdminGroups/group_response.dart';
import 'package:zohoanalytics/Models/GeneralResponse.dart';
import 'package:zohoanalytics/Services/GroupServices.dart';
import 'package:zohoanalytics/Views/Components/OkDialogAlert.dart';
import 'views/web/components/edit_group.dart';
import 'views/web/components/show_groups.dart';

class GroupScreenLogic{
  final GlobalKey<State<ShowGroups>> showGroups = GlobalKey();
  final GlobalKey<State<EditGroup>> editGroup = GlobalKey();
  final listScrollController = ScrollController();
  final addScrollController = ScrollController();
  final editScrollController = ScrollController();
  //search field
  TextEditingController searchController = TextEditingController();
  //create fields
  TextEditingController nameCreateController = TextEditingController();
  TextEditingController descriptionCreateController = TextEditingController();
  //create fields
  List<Group> groups = [];
  List<Group> groupsTemp = [];
  Group selectedToEdit = Group();
  //update fields
  TextEditingController textselectedToEdit = TextEditingController();
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController descriptionUpdateController = TextEditingController();
  //update fields

  late Future<GroupResponse> dataFuture;

  Future<GroupResponse> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    GroupResponse response = await consultAllGroups();
    groups  = response.groups;
    groupsTemp  = response.groups;
    final updateGroupState = editGroup.currentState as EditGroupState?;
    updateGroupState?.setGroups();
    return response;
  }

  Future<void> createGroup(BuildContext context)async{
    if(nameCreateController.text.isEmpty){
      showOkAlert(
        context: context,
        title: "Error",
        message: "Es requerido ingresar un nombre para el grupo",
      );
      return;
    }
    GeneralResponse response = await createGroupService(
      data: Group(
        name: nameCreateController.text,
        description: descriptionCreateController.text
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
    descriptionCreateController.text ="";
    final showGroupsState = showGroups.currentState as ShowGroupsState?;
    showGroupsState?.refresh();
  }

  void setItemToEdit(Group item){
    nameUpdateController.text = item.name;
    descriptionUpdateController.text = item.description;
    selectedToEdit = item;
  }

  Future<void> updateReport(BuildContext context)async{
    GeneralResponse response = await updateGroupService(
      data: Group(
        id: selectedToEdit.id,
        name: nameUpdateController.text,
        description: descriptionUpdateController.text
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
    selectedToEdit = Group();
    textselectedToEdit.text ="";
    final showGroupsState = showGroups.currentState as ShowGroupsState?;
    showGroupsState?.refresh();
  }

  void searchReports(String? value){
    if(searchController.text.isEmpty){
      groups = groupsTemp;
    }
    else{
      groups = groupsTemp.where((element) => element.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();
    }
    final showGroupsState = showGroups.currentState as ShowGroupsState?;
    showGroupsState?.search();
  }
}