import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminReports/admin_report_create_request.dart';
import 'package:zohoanalytics/Models/AdminReports/admin_report_response.dart';
import 'package:zohoanalytics/Models/AdminReports/admin_report_update_request.dart';
import 'package:zohoanalytics/Models/AdminReports/report.dart';
import 'package:zohoanalytics/Models/GeneralResponse.dart';
import 'package:zohoanalytics/Services/ReportServices.dart';
import 'package:zohoanalytics/Views/Components/OkDialogAlert.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/reports/views/web/components/edit_report.dart';
import 'views/web/components/show_reports.dart';

class ReportsScreenLogic{
  final GlobalKey<State<ShowReports>> linkListReports = GlobalKey();
  final GlobalKey<State<EditReport>> updateReports = GlobalKey();
  final listScrollController = ScrollController();
  final addScrollController = ScrollController();
  final editScrollController = ScrollController();
  //search field
  TextEditingController searchController = TextEditingController();
  //create fields
  TextEditingController nameCreateController = TextEditingController();
  TextEditingController urlCreateController = TextEditingController();
  String selectedCreateReportType = "";
  List<String> reportTypes = const [
                          "Dashboard",
                          "Reporte",
                        ];
  //create fields
  List<Report> reports = [];
  List<Report> tempReports = [];
  Report selectedToEdit = Report();
  //update fields
  TextEditingController textselectedToEdit = TextEditingController();
  TextEditingController nameUpdateController = TextEditingController();
  TextEditingController urlUpdateController = TextEditingController();
  String selectedUpdateReportType = "";
  List<String> statusTypes = const [
                          "Activo",
                          "En desarrollo",
                          "Eliminado"
                        ];
  String selectedUpdateStatusType = "";
  //update fields

  late Future<AdminReportResponse> dataFuture;

  Future<AdminReportResponse> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    AdminReportResponse response = await consultAllReports();
    reports  = response.reports;
    tempReports = response.reports;
    final updateReportState = updateReports.currentState as EditReportState?;
    updateReportState?.setReports();
    return response;
  }

  Future<void> createReport(BuildContext context)async{
    if(nameCreateController.text.isEmpty){
      showOkAlert(
        context: context,
        title: "Error",
        message: "Es requerido ingresar un nombre para el reporte",
      );
      return;
    }
    if(urlCreateController.text.isEmpty){
      showOkAlert(
        context: context,
        title: "Error",
        message: "Es requerido ingresar una URL para el reporte",
      );
      return;
    }
    if(selectedCreateReportType.isEmpty){
      showOkAlert(
        context: context,
        title: "Error",
        message: "Es requerido seleccionar un tipo de reporte",
      );
      return;
    }
    GeneralResponse response = await createReportService(
      data: AdminReportCreateRequest(
        name: nameCreateController.text,
        url: urlCreateController.text,
        reportTypeId: reportTypes.indexOf(selectedCreateReportType)+1,
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
    urlCreateController.text ="";
    selectedCreateReportType = "";
    final openTicketsState = linkListReports.currentState as ShowReportsState?;
    openTicketsState?.refresh();
  }

  void setItemToEdit(Report item){
    nameUpdateController.text = item.name;
    urlUpdateController.text = item.url;
    selectedUpdateReportType = reportTypes[item.reportTypeId-1];
    selectedUpdateStatusType = statusTypes[item.statusId-1];
    selectedToEdit = item;
  }

  Future<void> updateReport(BuildContext context)async{
    GeneralResponse response = await updateReportService(
      data: AdminReportUpdateRequest(
        id: selectedToEdit.id,
        name: nameUpdateController.text,
        url: urlUpdateController.text,
        statusId: statusTypes.indexOf(selectedUpdateStatusType)+1,
        reportTypeId: reportTypes.indexOf(selectedUpdateReportType)+1
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
    selectedToEdit = Report();
    textselectedToEdit.text ="";
    final openTicketsState = linkListReports.currentState as ShowReportsState?;
    openTicketsState?.refresh();
  }

  void searchReports(String? value){
    if(searchController.text.isEmpty){
      reports = tempReports;
    }
    else{
      reports = tempReports.where((element) => element.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();
    }
    final openTicketsState = linkListReports.currentState as ShowReportsState?;
    openTicketsState?.search();
  }
}