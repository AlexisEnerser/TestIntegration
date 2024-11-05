import 'package:flutter/Material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:zohoanalytics/Views/Components/NoResults.dart';

import '../../../../../Models/Reports/ReportApp.dart';
import '../../../../../constants.dart';
import '../../../../Components/ModalReport/ModalReport.dart';
import '../../../../Components/ReportItemDesign.dart';
import '../../../../Components/SelectedButton.dart';
import '../GroupPageLogic.dart';

class GroupPageWeb extends StatefulWidget {
  final GroupPageLogic logic;
  const GroupPageWeb({super.key, required this.logic});

  @override
  State<GroupPageWeb> createState() => _GroupPageWebState();
}

class _GroupPageWebState extends State<GroupPageWeb> {

  void onSelected(String? value){
    widget.logic.onSelected(value);
    setState(() {});
  }
  @override
  void initState() {
    widget.logic.list = widget.logic.setListOption();
    widget.logic.dropdownValue = widget.logic.list.first;
    widget.logic.items = widget.logic.setItems();
    widget.logic.displayItems = widget.logic.setFilter();
    super.initState();
  }

  void changeSelectedDashboard(){
    widget.logic.changeSelectedDashboard();
    setState(() {});
  }
  void changeSelectedReport(){
    widget.logic.changeSelectedReport();
    setState(() {});
  }

  Future<void> setFavorite(ReportApp data) async {
    await widget.logic.setFavorite(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15,),
        Row(
          children: [
            const SizedBox(width: 20,),
            DropdownMenu<String>(
              initialSelection: widget.logic.list.first,
              onSelected: onSelected,
              dropdownMenuEntries: widget.logic.list.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            const SizedBox(width: 20,),
            SelectedButton(
              onTap: changeSelectedDashboard,
              color: dashboardColor,
              isSelected: widget.logic.isDashboardSelected,
              icon: dashboardIcon,
              title: "Dashboards",
            ),
            const SizedBox(width: 20,),
            SelectedButton(
              onTap: changeSelectedReport,
              color: reportColor,
              isSelected: widget.logic.isReportSelected,
              icon: reportIcon,
              title: "Reportes",
            ),
          ],
        ),
        const SizedBox(height: 20,),
        Expanded(
            child:
            widget.logic.displayItems.isNotEmpty
                ?ResponsiveGridList(
              horizontalGridSpacing: 16, // Horizontal space between grid items
              verticalGridSpacing: 16, // Vertical space between grid items
              horizontalGridMargin: 40, // Horizontal space around the grid
              verticalGridMargin: 40, // Vertical space around the grid
              minItemWidth: 300, // The minimum item width (can be smaller, if the layout constraints are smaller)
              minItemsPerRow: 2, // The minimum items to show in a single row. Takes precedence over minItemWidth
              maxItemsPerRow: 5, // The maximum items to show in a single row. Can be useful on large screens
              listViewBuilderOptions: ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
              children: List.generate(widget.logic.displayItems.length, (index) {
                return ReportItemDesign(
                  data: widget.logic.displayItems[index],
                  onTap: ()=>showReport(
                      item:widget.logic.displayItems[index],
                      ctx:context,
                      favorite: setFavorite
                  ),
                );
              }), // The list of widgets in the list
            )
            :const NoResults()
        )
      ],
    );
  }
}
