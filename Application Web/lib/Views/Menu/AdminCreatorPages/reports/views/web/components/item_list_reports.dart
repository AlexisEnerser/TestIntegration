import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminReports/report.dart';
import 'package:zohoanalytics/Views/Components/RowItemTemplate.dart';
import 'package:zohoanalytics/Views/Components/StatusTableDesign.dart';
import 'package:zohoanalytics/constants.dart';
import 'dart:html' as html;

class ItemListReports extends StatelessWidget {
  final bool isEven;
  final Report item;
  final double width;
  const ItemListReports({super.key, required this.item, required this.isEven, required this.width});

  Color statusColor(){
    if(item.statusId==1){
      return Colors.green;
    }
    else if(item.statusId == 2){
      return Colors.amber;
    }
    else if(item.statusId == 3){
      return Colors.red;
    }
    else{
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RowItemTemplate(
      isEven: isEven,
      child: SizedBox(
        width: width,
        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: StatusTableDesign(
                color: statusColor(),
                status: item.status,
              )
            ),
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
          ],
        ),
      ),
    );
}
}