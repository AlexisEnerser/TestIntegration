import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminGroups/group_response.dart';
import 'package:zohoanalytics/Views/Components/TextSearchField.dart';
import 'package:zohoanalytics/Views/Menu/AdminCreatorPages/groups-users/groups-users_logic.dart';

class GroupSearcher extends StatefulWidget {
  final GroupsUsersLogic logic;
  final double width;
  const GroupSearcher({super.key, required this.logic, required this.width});

  @override
  State<GroupSearcher> createState() => _GroupSearcherState();
}

class _GroupSearcherState extends State<GroupSearcher> {
  @override
  Widget build(BuildContext context) {
    widget.logic.dataFuture = widget.logic.fetchData();
    return FutureBuilder<GroupResponse>(
      future: widget.logic.dataFuture,
      builder: (BuildContext context, AsyncSnapshot<GroupResponse> snapshot) {
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
            list: widget.logic.groups.map((item)=>item.name).toList(),
            hintText: "Busca un grupo por nombre",
            onSelected: (selected){                      
                widget.logic.textselectedToEdit.text = selected;
                widget.logic.setItemToEdit(widget.logic.groups.firstWhere((item)=>item.name==selected));
            },
          );
        }
      },
    );
  }
}