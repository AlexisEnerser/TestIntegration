import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminUsers/user_response.dart';
import 'package:zohoanalytics/Views/Components/TextSearchField.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/users-reports/users-reports_logic.dart';

class GroupSearcher extends StatefulWidget {
  final UsersReportsLogic logic;
  final double width;
  const GroupSearcher({super.key, required this.logic, required this.width});

  @override
  State<GroupSearcher> createState() => _GroupSearcherState();
}

class _GroupSearcherState extends State<GroupSearcher> {
  @override
  Widget build(BuildContext context) {
    widget.logic.dataFuture = widget.logic.fetchData();
    return FutureBuilder<UserResponse>(
      future: widget.logic.dataFuture,
      builder: (BuildContext context, AsyncSnapshot<UserResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Textsearchfield(
            list: widget.logic.users.map((item)=>item.name).toList(),
            hintText: "Busca un usuario por nombre",
            onSelected: (selected){                      
                widget.logic.textselectedToEdit.text = selected;
                widget.logic.setItemToEdit(widget.logic.users.firstWhere((item)=>item.name==selected));
            },
          );
        }
      },
    );
  }
}