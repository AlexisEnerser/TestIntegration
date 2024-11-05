import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/LoginButton.dart';
import 'package:zohoanalytics/Views/Components/OptionMenuButton.dart';
import 'package:zohoanalytics/Views/Components/TextFieldForm.dart';
import 'package:zohoanalytics/Views/Components/TextSearchField.dart';
import 'package:zohoanalytics/constants.dart';

import '../../../reports_screen_logic.dart';

// ignore: must_be_immutable
class EditReport extends StatefulWidget {
  ReportsScreenLogic logic;
  bool? isPhone;
  double height;
  double width;
  EditReport({super.key, required this.logic, this.isPhone, required this.height, required this.width});

  @override
  State<EditReport> createState() => EditReportState();
}

class EditReportState extends State<EditReport> {

  void setReports(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    widget.isPhone = widget.isPhone??false;
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          const Text("Editar de reportes", style: layoutTitle,),
          const SizedBox(height: 20.0),
          content()
        ],
      ),
    );
  }

    Widget content(){
    if(!widget.isPhone!){
      return Expanded(
          child: Scrollbar(
            controller: widget.logic.editScrollController,
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              controller: widget.logic.editScrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Textsearchfield(
                    list: widget.logic.reports.map((item)=>item.name).toList(),
                    hintText: "Busca un reporte por nombre",
                    onSelected: (selected){
                      setState(() {                         
                        widget.logic.setItemToEdit(widget.logic.reports.firstWhere((item)=>item.name==selected));
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Visibility(
                    visible: widget.logic.selectedToEdit.id>0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFieldForm(
                          controller: widget.logic.nameUpdateController,
                          label: "Nombre del reporte",
                        ),
                        const SizedBox(height: 10.0),
                        TextFieldForm(
                          controller: widget.logic.urlUpdateController,
                          label: "URL del reporte",
                        ),
                        const SizedBox(height: 10.0),
                        OptionMenuButton(
                          width: widget.width,
                          hint: "Selecciona un tipo de reporte",
                          options: widget.logic.reportTypes,
                          onSelected: (selected){
                            if(selected!=null){
                              setState(() {
                                  widget.logic.selectedUpdateReportType = selected;
                              });
                            }
                          },
                          selectedOption: widget.logic.selectedUpdateReportType,
                        ),
                        const SizedBox(height: 10.0),
                        OptionMenuButton(
                          width: widget.width,
                          hint: "Selecciona un estatus",
                          options: widget.logic.statusTypes,
                          onSelected: (selected){
                            if(selected!=null){
                              setState(() {
                                  widget.logic.selectedUpdateStatusType = selected;
                              });
                            }
                          },
                          selectedOption: widget.logic.selectedUpdateStatusType,
                        ),                           
                        const SizedBox(height: 10.0),
                        InkWell(
                          onTap:() async{
                            await widget.logic.updateReport(context);
                            setState(() {});
                          },
                          child: LoginButton(
                            width: MediaQuery.sizeOf(context).width*0.4,
                            title: "Editar",
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
    }
    else{
      return Expanded(
          child: Scrollbar(
            controller: widget.logic.editScrollController,
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              controller: widget.logic.editScrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Textsearchfield(
                    list: widget.logic.reports.map((item)=>item.name).toList(),
                    hintText: "Busca un reporte por nombre",
                    onSelected: (selected){
                      setState(() {                         
                        widget.logic.setItemToEdit(widget.logic.reports.firstWhere((item)=>item.name==selected));
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Visibility(
                    visible: widget.logic.selectedToEdit.id>0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFieldForm(
                          controller: widget.logic.nameUpdateController,
                          label: "Nombre del reporte",
                        ),
                        const SizedBox(height: 10.0),
                        TextFieldForm(
                          controller: widget.logic.urlUpdateController,
                          label: "URL del reporte",
                        ),
                        const SizedBox(height: 10.0),
                        OptionMenuButton(
                          width: widget.width,
                          hint: "Selecciona un tipo de reporte",
                          options: widget.logic.reportTypes,
                          onSelected: (selected){
                            if(selected!=null){
                              setState(() {
                                  widget.logic.selectedUpdateReportType = selected;
                              });
                            }
                          },
                          selectedOption: widget.logic.selectedUpdateReportType,
                        ),
                        const SizedBox(height: 10.0),
                        OptionMenuButton(
                          width: widget.width,
                          hint: "Selecciona un estatus",
                          options: widget.logic.statusTypes,
                          onSelected: (selected){
                            if(selected!=null){
                              setState(() {
                                  widget.logic.selectedUpdateStatusType = selected;
                              });
                            }
                          },
                          selectedOption: widget.logic.selectedUpdateStatusType,
                        ),                           
                        const SizedBox(height: 10.0),
                        InkWell(
                          onTap:() async{
                            await widget.logic.updateReport(context);
                            setState(() {});
                          },
                          child: LoginButton(
                            width: MediaQuery.sizeOf(context).width,
                            title: "Editar",
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
    }
  }
}