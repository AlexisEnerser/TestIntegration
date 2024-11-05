import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Components/LoginButton.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/users-reports/users-reports_logic.dart';

class SaveAreaReport extends StatefulWidget {
  final UsersReportsLogic logic;
  final double? width;
  const SaveAreaReport({super.key, required this.logic, this.width});

  @override
  State<SaveAreaReport> createState() => SaveAreaReportState();
}

class SaveAreaReportState extends State<SaveAreaReport> {

  void chageVibility(){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.logic.isVisible
        ?InkWell(
          onTap:widget.logic.saveNewReports,
          child: LoginButton(
            width: widget.width??MediaQuery.sizeOf(context).width*0.5,
            title: "Guardar",
          ),
        )
        :const SizedBox(height: 40,)
      ],
    );
  }
}