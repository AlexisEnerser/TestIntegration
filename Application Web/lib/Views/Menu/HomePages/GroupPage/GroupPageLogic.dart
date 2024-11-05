import '../../../../Models/Reports/ReportApp.dart';
import '../../../../Models/Reports/ReportResponse.dart';
import '../../../../Services/ReportServices.dart';
import '../../../../constants.dart';

class GroupPageLogic{
  late List<String> list;
  late List<ReportApp> items;
  List<ReportApp> displayItems = [];
  String dropdownValue = "";
  bool isDashboardSelected = true;
  bool isReportSelected = true;
  List<String> setListOption(){
    List<String> result = [];
    for(UserGroup item in userReports!.groupReports){
      result.add(item.group);
    }
    result.add("Propios");
    return result;
  }
  List<ReportApp> setItems(){
    List<ReportApp> response=[];
    for(UserGroup item in userReports!.groupReports){
      for(ReportResponseData subItem in item.report){
        response.add(ReportApp(
            group: item.group,
            url: subItem.url,
            name: subItem.name,
            reportType: subItem.reportType,
            reportTypeId: subItem.reportTypeId,
            isFavorite: subItem.isFavorite,
            reportId: subItem.reportId
        ));
      }
    }
    for(ReportResponseData subItem in userReports!.myReports){
      response.add(ReportApp(
          group: "Propios",
          url: subItem.url,
          name: subItem.name,
          reportType: subItem.reportType,
          reportTypeId: subItem.reportTypeId,
          isFavorite: subItem.isFavorite,
          reportId: subItem.reportId
      ));
    }
    return response;
  }
  List<ReportApp> setFilter(){
    List<ReportApp> result = [];
    for(ReportApp subItem in items){
      if(dropdownValue==subItem.group){
        if(isDashboardSelected && subItem.reportTypeId == 1){
          result.add(subItem);
        }
        if(isReportSelected && subItem.reportTypeId == 2){
          result.add(subItem);
        }
      }
    }
    return result;
  }
  void onSelected(String? value){
      dropdownValue = value!;
      displayItems = setFilter();
  }

  void changeSelectedDashboard(){
      isDashboardSelected = !isDashboardSelected;
      displayItems = setFilter();
  }

  void changeSelectedReport(){
      isReportSelected = !isReportSelected;
      displayItems = setFilter();
  }

  Future<void> setFavorite(ReportApp data) async {
    if(data.isFavorite){
      await setFavoriteReport(data.reportId.toString());
    }
    else{
      await deleteFavoriteReports(data.reportId.toString());
    }
    userReports = await consultUserReports();
  }


}