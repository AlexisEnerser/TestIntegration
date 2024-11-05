import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/LoginButton.dart';
import 'package:zohoanalytics/Views/Components/OptionMenuButton.dart';
import 'package:zohoanalytics/Views/Components/TextFieldForm.dart';
import 'package:zohoanalytics/constants.dart';
import '../../../reports_screen_logic.dart';


// ignore: must_be_immutable
class AddReports extends StatefulWidget {
  ReportsScreenLogic logic;
  bool? isPhone;
  double height;
  double width;
  AddReports({super.key, required this.logic, this.isPhone, required this.height, required this.width});

  @override
  State<AddReports> createState() => _AddReportsState();
}

class _AddReportsState extends State<AddReports> {
  @override
  Widget build(BuildContext context) {
    widget.isPhone = widget.isPhone??false;
    return  SizedBox(
      height: widget.height,
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          const Text("Creación de reportes", style: layoutTitle,),
          const SizedBox(height: 20.0),
          content()
        ],
      ),
    );
  }

  Widget content(){
    if(widget.isPhone!){
      return Expanded(
          child: Scrollbar(
            controller: widget.logic.addScrollController,
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              controller: widget.logic.addScrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFieldForm(
                    controller: widget.logic.nameCreateController,
                    label: "Nombre del reporte",
                  ),
                  const SizedBox(height: 10.0),
                  TextFieldForm(
                    controller: widget.logic.urlCreateController,
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
                            widget.logic.selectedCreateReportType = selected;
                        });
                      }
                    },
                    selectedOption: widget.logic.selectedCreateReportType,
                  ),
                  const SizedBox(height: 10.0),
                  InkWell(
                    onTap:() async{
                      await widget.logic.createReport(context);
                      setState(() {});
                    },
                    child: LoginButton(
                      width: MediaQuery.sizeOf(context).width,
                      title: "Agregar",
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
          controller: widget.logic.addScrollController,
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            controller: widget.logic.addScrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFieldForm(
                  controller: widget.logic.nameCreateController,
                  label: "Nombre del reporte",
                ),
                const SizedBox(height: 10.0),
                TextFieldForm(
                  controller: widget.logic.urlCreateController,
                  label: "URL del reporte",
                ),
                const SizedBox(height: 10.0),
                OptionMenuButton(
                  hint: "Selecciona un tipo de reporte",
                  width: widget.width,
                  options: widget.logic.reportTypes,
                  onSelected: (selected){
                    if(selected!=null){
                      setState(() {
                          widget.logic.selectedCreateReportType = selected;
                      });
                    }
                  },
                  selectedOption: widget.logic.selectedCreateReportType,
                ),
                const SizedBox(height: 10.0),
                InkWell(
                  onTap:() async{
                    await widget.logic.createReport(context);
                    setState(() {});
                  },
                  child: LoginButton(
                    width: MediaQuery.sizeOf(context).width*0.4,
                    title: "Agregar",
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