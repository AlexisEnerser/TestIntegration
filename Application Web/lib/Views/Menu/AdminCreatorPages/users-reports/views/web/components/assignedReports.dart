import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminGroups/group_report_response.dart';
import 'package:zohoanalytics/Models/Reports/ReportResponse.dart';
import 'package:zohoanalytics/Views/Components/DefaultLayout.dart';
import 'package:zohoanalytics/Views/Components/RowItemTemplate.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/users-reports/users-reports_logic.dart';
import 'package:zohoanalytics/constants.dart';
import 'dart:html' as html;

// ignore: must_be_immutable
class AssignedReports extends StatefulWidget {
  UsersReportsLogic logic;
  double height;
  double width;
  AssignedReports({
    super.key,
    required this.logic,
    required this.height,
    required this.width
  });

  @override
  State<AssignedReports> createState() => AssignedReportsState();
}

class AssignedReportsState extends State<AssignedReports> {

  @override
  void initState() {
    super.initState();
    widget.logic.assignedDataFuture = widget.logic.fetchAssignedData();
  }

  void refresh(){
    setState(() {
      widget.logic.assignedDataFuture = widget.logic.fetchAssignedData();
    });
  }

  void updateList(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout2(
      height: widget.height,
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Reportes asignados", style: layoutTitle,),
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
                  Expanded(flex: 2,child: Text("Tipo",style: tableStyle,)),
                  Expanded(flex: 3,child: Text("Nombre",style: tableStyle,)),
                  Expanded(child: Icon(Icons.link,color: Colors.white,size: 20,)),
                  Expanded(child: Icon(Icons.remove_circle,color: Colors.white,size: 20,)),
                  SizedBox(width: 10,),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<GroupReportResponse>(
                future: widget.logic.assignedDataFuture,
                builder: (BuildContext context, AsyncSnapshot<GroupReportResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Scrollbar(
                      controller: widget.logic.assignedScrollController,
                      trackVisibility: true,
                      thumbVisibility: true,
                      child: ListView.builder(
                        controller: widget.logic.assignedScrollController,
                        itemCount: widget.logic.assignedReportsData.length,
                        itemBuilder: (_,index){
                          ReportResponseData item = widget.logic.assignedReportsData[index];
                          return SizedBox(
                            width: widget.width,
                            child: RowItemTemplate(
                              isEven: index % 2 == 0,
                              child: Row(
                                children: [
                                  Expanded(flex: 2,child: Text(item.reportType,style: tableItemStyle)),
                                  Expanded(flex: 3,child: Text(item.name,style: tableItemStyle,)),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: (){
                                        html.window.open(item.url, 'new tab');
                                      }, 
                                      child: LayoutBuilder(
                                        builder: (_,constraint){
                                          return constraint.constrainWidth()<50 
                                          ? Icon(Icons.link,color: blue1,size: 20,)
                                          : const Text("Preview",style: tableItemStyle,);
                                        },
                                      )
                                    )
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: ()=>widget.logic.removeFromAssigned(item), 
                                      child: LayoutBuilder(
                                        builder: (_,constraint){
                                          return constraint.constrainWidth()<50 
                                          ? Icon(Icons.remove_circle_outline ,color: blue1,size: 20,)
                                          : const Text("Remover",style: tableItemStyle,);
                                        },
                                      )
                                    )
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    );
                  }
                },
              )
          )
        ],
      ),
    );
  }
}