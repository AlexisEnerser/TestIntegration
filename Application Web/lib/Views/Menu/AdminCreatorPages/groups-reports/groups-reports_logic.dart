import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminGroups/add_group_report_request.dart';
import 'package:zohoanalytics/Models/AdminGroups/group.dart';
import 'package:zohoanalytics/Models/AdminGroups/group_report_response.dart';
import 'package:zohoanalytics/Models/AdminGroups/group_response.dart';
import 'package:zohoanalytics/Models/Reports/ReportResponse.dart';
import 'package:zohoanalytics/Services/GroupServices.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/groups-reports/views/web/components/saveAreaReport.dart';
import 'views/web/components/assignedReports.dart';
import 'views/web/components/noAssignedReports.dart';

class GroupsReportsLogic{
  final GlobalKey<State<NoAssignedReports>> noAssignedReports = GlobalKey();
  final GlobalKey<State<AssignedReports>> assignedReports = GlobalKey();
  final GlobalKey<State<SaveAreaReport>> sareArea = GlobalKey();


  final assignedScrollController = ScrollController();
  final noAssignedScrollController = ScrollController();
  bool isVisible = false;

  
  TextEditingController searchController = TextEditingController();
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
    final assignedReportsState = assignedReports.currentState as AssignedReportsState?;
    assignedReportsState?.refresh();

    final noAssignedReportsState = noAssignedReports.currentState as NoAssignedReportsState?;
    noAssignedReportsState?.refresh();
  }

  List<ReportResponseData> assignedReportsData = [];
  late Future<GroupReportResponse> assignedDataFuture;
  Future<GroupReportResponse> fetchAssignedData() async {
    if(selectedToEdit.id>0){
      GroupReportResponse response = await consultGroupReports(groupId: selectedToEdit.id);
      assignedReportsData  = response.reports;
      return response;
    }
    return GroupReportResponse(code: 1, message: "", reports: []);
  }

  List<ReportResponseData> assignedNoReportsData = [];
  List<ReportResponseData> assignedNoReportsDataTemp = [];
  late Future<GroupReportResponse> noAssignedDataFuture;
  Future<GroupReportResponse> fetchNoAssignedData() async {
    if(selectedToEdit.id>0){
      GroupReportResponse response = await consultGroupNoReports(groupId: selectedToEdit.id);
      assignedNoReportsData  = response.reports;
      assignedNoReportsDataTemp  = response.reports;
      return response;
    }
    return GroupReportResponse(code: 1, message: "", reports: []);
  }
  void searchReports(String? value){
    if(searchController.text.isEmpty){
      assignedNoReportsData = assignedNoReportsDataTemp;
    }
    else{
      assignedNoReportsData = assignedNoReportsDataTemp.where((element) => element.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();
    }
    final noAssignedReportsState = noAssignedReports.currentState as NoAssignedReportsState?;
    noAssignedReportsState?.updateList();
  }


  void removeFromAssigned(ReportResponseData item){
    assignedReportsData.remove(item);
    assignedNoReportsData.add(item);
    showSaveButton();

    final assignedReportsState = assignedReports.currentState as AssignedReportsState?;
    assignedReportsState?.updateList();

    final noAssignedReportsState = noAssignedReports.currentState as NoAssignedReportsState?;
    noAssignedReportsState?.updateList();
  }

  void addToAssigned(ReportResponseData item){
    assignedNoReportsData.remove(item);
    assignedReportsData.add(item);
    showSaveButton();

    final assignedReportsState = assignedReports.currentState as AssignedReportsState?;
    assignedReportsState?.updateList();

    final noAssignedReportsState = noAssignedReports.currentState as NoAssignedReportsState?;
    noAssignedReportsState?.updateList();
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
      reports: assignedReportsData.map((x) => x.reportId).toList()
    );
    await updateGroupReports(data: request);

    final assignedReportsState = assignedReports.currentState as AssignedReportsState?;
    assignedReportsState?.refresh();

    final noAssignedReportsState = noAssignedReports.currentState as NoAssignedReportsState?;
    noAssignedReportsState?.refresh();

    isVisible = false;
    final sareAreaState = sareArea.currentState as SaveAreaReportState?;
    sareAreaState?.chageVibility();
  }

}