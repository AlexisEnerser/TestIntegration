import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:zohoanalytics/Views/Components/NoResults.dart';

import '../../../Models/Reports/ReportApp.dart';
import '../../../Models/Reports/ReportResponse.dart';
import '../../../Services/ReportServices.dart';
import '../../../constants.dart';
import '../../Components/ModalReport/ModalReport.dart';
import '../../Components/ReportItemDesign.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  List<ReportApp> displayItems = [];
  List<ReportApp> setItems(){
    List<ReportApp> response = [];
    for(ReportResponseData subItem in userReports!.favoriteReports){
      response.add(ReportApp(
        group: "favoritos",
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
  void initState() {
    // TODO: implement initState
    super.initState();
    displayItems = setItems();
  }

  Future<void> setFavorite(ReportApp data) async {
    if(data.isFavorite){
      await setFavoriteReport(data.reportId.toString());
    }
    else{
      await deleteFavoriteReports(data.reportId.toString());
    }
    userReports = await consultUserReports();
    displayItems = setItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return displayItems.isNotEmpty
      ?ResponsiveGridList(
      horizontalGridSpacing: 10, // Horizontal space between grid items
      verticalGridSpacing: 10, // Vertical space between grid items
      horizontalGridMargin: 10, // Horizontal space around the grid
      verticalGridMargin: 10, // Vertical space around the grid // Vertical space around the grid
      minItemWidth: 350, // The minimum item width (can be smaller, if the layout constraints are smaller)
      minItemsPerRow: 2, // The minimum items to show in a single row. Takes precedence over minItemWidth
      maxItemsPerRow: 5, // The maximum items to show in a single row. Can be useful on large screens
      listViewBuilderOptions: ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
      children: List.generate(displayItems.length, (index) {
        return ReportItemDesign(
          data: displayItems[index],
          onTap: ()=>showReport(
            item:displayItems[index],
            ctx:context,
            favorite: setFavorite
          ),
        );
      }), // The list of widgets in the list
    )
      :const NoResults();
  }
}