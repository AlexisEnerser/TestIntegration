import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminGroups/add_group_report_request.dart';
import 'package:zohoanalytics/Models/AdminGroups/group.dart';
import 'package:zohoanalytics/Models/AdminGroups/group_response.dart';
import 'package:zohoanalytics/Models/AdminUsers/user.dart';
import 'package:zohoanalytics/Models/AdminUsers/user_response.dart';
import 'package:zohoanalytics/Services/GroupServices.dart';
import 'views/web/components/assignedUsers.dart';
import 'views/web/components/noAssignedUsers.dart';
import 'views/web/components/saveAreaReport.dart';

class GroupsUsersLogic{
    final GlobalKey<State<NoAssignedUsers>> noAssignedUsers = GlobalKey();
  final GlobalKey<State<AssignedUsers>> assignedUsers = GlobalKey();
  final GlobalKey<State<SaveAreaReport>> sareArea = GlobalKey();

  TextEditingController searchController = TextEditingController();
  final assignedScrollController = ScrollController();
  final noAssignedScrollController = ScrollController();
  bool isVisible = false;

  List<Group> groups = [];
  Group selectedToEdit = Group();
  late Future<GroupResponse> dataFuture;
  Future<GroupResponse> fetchData() async {
    GroupResponse response = await consultAllGroups();
    groups  = response.groups;
    return response;
  }

  TextEditingController textselectedToEdit = TextEditingController();

  void setItemToEdit(Group item){
    selectedToEdit = item;
    final assignedUsersState = assignedUsers.currentState as AssignedUsersState?;
    assignedUsersState?.refresh();

    final noAssignedUsersState = noAssignedUsers.currentState as NoAssignedUsersState?;
    noAssignedUsersState?.refresh();
  }

  List<User> assignedReportsData = [];
  late Future<UserResponse> assignedDataFuture;
  Future<UserResponse> fetchAssignedData() async {
    if(selectedToEdit.id>0){
      UserResponse response = await consultGroupUsers(groupId: selectedToEdit.id);
      assignedReportsData  = response.users;
      return response;
    }
    return UserResponse(code: 1, message: "", users: []);
  }

  List<User> assignedNoReportsData = [];
  List<User> assignedNoReportsDataTemp = [];
  late Future<UserResponse> noAssignedDataFuture;
  Future<UserResponse> fetchNoAssignedData() async {
    if(selectedToEdit.id>0){
      UserResponse response = await consultGroupNoUsers(groupId: selectedToEdit.id);
      assignedNoReportsData  = response.users;
      assignedNoReportsDataTemp  = response.users;
      return response;
    }
    return UserResponse(code: 1, message: "", users: []);
  }

  void searchReports(String? value){
    if(searchController.text.isEmpty){
      assignedNoReportsData = assignedNoReportsDataTemp;
    }
    else{
      assignedNoReportsData = assignedNoReportsDataTemp.where((element) => element.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();
    }
    final noAssignedUsersState = noAssignedUsers.currentState as NoAssignedUsersState?;
    noAssignedUsersState?.updateList();
  }


  void removeFromAssigned(User item){
    assignedReportsData.remove(item);
    assignedNoReportsData.add(item);
    showSaveButton();

    final assignedUsersState = assignedUsers.currentState as AssignedUsersState?;
    assignedUsersState?.updateList();

    final noAssignedUsersState = noAssignedUsers.currentState as NoAssignedUsersState?;
    noAssignedUsersState?.updateList();
  }

  void addToAssigned(User item){
    assignedNoReportsData.remove(item);
    assignedReportsData.add(item);
    showSaveButton();

    final assignedUsersState = assignedUsers.currentState as AssignedUsersState?;
    assignedUsersState?.updateList();

    final noAssignedUsersState = noAssignedUsers.currentState as NoAssignedUsersState?;
    noAssignedUsersState?.updateList();
  }

  void showSaveButton(){
    if(!isVisible){
      isVisible = true;
      final sareAreaState = sareArea.currentState as SaveAreaReportState?;
      sareAreaState?.chageVibility();
    }
  }

  void saveNewReports() async{
    AddGroupReportRequest request = AddGroupReportRequest(
      id: selectedToEdit.id,
      reports: assignedReportsData.map((x) => x.id).toList()
    );
    await updateGroupUsers(data: request);

    final assignedUsersState = assignedUsers.currentState as AssignedUsersState?;
    assignedUsersState?.refresh();

    final noAssignedUsersState = noAssignedUsers.currentState as NoAssignedUsersState?;
    noAssignedUsersState?.refresh();

    isVisible = false;
    final sareAreaState = sareArea.currentState as SaveAreaReportState?;
    sareAreaState?.chageVibility();
  }

}