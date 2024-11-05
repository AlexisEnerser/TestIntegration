import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zohoanalytics/Models/AdminReports/admin_report_response.dart';
import 'package:zohoanalytics/Models/AdminReports/report.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/reports/views/web/components/item_list_reports.dart';
import 'package:zohoanalytics/constants.dart';
import '../../../../../../Components/TextFieldForm.dart';
import '../../../reports_screen_logic.dart';

// ignore: must_be_immutable
class ShowReports extends StatefulWidget {
  ReportsScreenLogic logic;
  double height;
  double width;
  ShowReports({super.key, required this.logic, required this.height, required this.width});

  @override
  State<ShowReports> createState() => ShowReportsState();
}

class ShowReportsState extends State<ShowReports> {
  @override
  void initState() {
    super.initState();
    widget.logic.dataFuture = widget.logic.fetchData();
  }

  void refresh(){
    setState(() {
      widget.logic.dataFuture = widget.logic.fetchData();
    });
  }

  void search(){
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        const Text("Listado de reportes", style: layoutTitle,),
        const SizedBox(height: 10.0),
        TextFieldForm(
            label: "Buscar por nombre",
            controller: widget.logic.searchController,
            onChanged: widget.logic.searchReports,
        ),
        const SizedBox(height: 10.0),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: blue1,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
            border: Border.all(
              color: Colors.black
            )
          ),
          child:  SizedBox(
            width: widget.width,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10,),
                SizedBox(
                  width: 90,
                  child: Text("Estatus",style: tableStyle,)
                ),
                Expanded(flex: 2,child: Text("Tipo",style: tableStyle,)),
                Expanded(flex: 3,child: Text("Nombre",style: tableStyle,)),
                Expanded(child: Icon(Icons.link,color: Colors.white,size: 20,)),
                SizedBox(width: 10,),
              ],
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<AdminReportResponse>(
              future: widget.logic.dataFuture,
              builder: (BuildContext context, AsyncSnapshot<AdminReportResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Skeletonizer(
                    enabled: true,
                    ignoreContainers: true,
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return ItemListReports(
                          width: widget.width,
                          item: Report(status: "cargando",reportType: "Dashboard", name:"Mesa de ayuda"),
                          isEven: index % 2 == 0,
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Scrollbar(
                    controller: widget.logic.listScrollController,
                    trackVisibility: true,
                    thumbVisibility: true,
                    child: ListView.builder(
                      controller: widget.logic.listScrollController,
                      itemCount: widget.logic.reports.length,
                      itemBuilder: (_,index){
                        return ItemListReports(
                          width: widget.width,
                          item: widget.logic.reports[index],
                          isEven: index % 2 == 0,
                        );
                      }
                    ),
                  );
                }
              },
            )
        )
      ],
    );
  }
}