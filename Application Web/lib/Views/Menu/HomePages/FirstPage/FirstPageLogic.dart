import '../../../../constants.dart';

class FirstPageLogic{
  String getUrl(){
    String url = "";
    if(userReports!.favoriteReports.isNotEmpty){
      url = userReports!.favoriteReports[0].url;
    }
    if(url.isEmpty){
      if(userReports!.myReports.isNotEmpty){
        url = userReports!.myReports[0].url;
      }
    }
    /*if(url.isEmpty){
      if(userReports!.groupReports.isNotEmpty){
        url = userReports!.groupReports[0].report[0].url;
      }
    }*/
    return url;
  }
}