import 'package:flutter/material.dart';
import 'package:zohoanalytics/Services/ReportServices.dart';
import 'package:zohoanalytics/Views/Components/ModalReport/views/ModalReportWeb.dart';
import '../../../Models/Reports/ReportApp.dart';

void showReport({required ReportApp item,required BuildContext ctx,required void Function(ReportApp) favorite}){
  
  saveRecordReport(item.reportId).then((response){
    showModalBottomSheet<void>(
      context: ctx,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(ctx).size.width*0.9,
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext ctx, StateSetter stst){
              return Container(
                height: MediaQuery.of(context).size.height*0.95,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: (){
                                item.isFavorite = !item.isFavorite;
                                favorite(item);
                                stst(() {});
                              },
                              child: item.isFavorite
                                  ?const Icon(Icons.favorite,color: Colors.red,)
                                  :const Icon(Icons.favorite_border,color: Colors.red)
                          ),
                          const SizedBox(width: 50,),
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close_rounded)
                          ),
                          const SizedBox(width: 15,)
                        ],
                      ),
                    ),
                    Expanded(
                      child: ModalReportWeb(url: item.url)
                    )
                  ],
                ),
              );
            }
        );
      },
    );
  });
}