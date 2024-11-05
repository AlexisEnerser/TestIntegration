import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminGroups/group.dart';
import 'package:zohoanalytics/Views/Components/RowItemTemplate.dart';
import 'package:zohoanalytics/constants.dart';

class ItemListGroup extends StatelessWidget {
  final bool isEven;
  final Group item;
  const ItemListGroup({super.key, required this.isEven, required this.item});

  @override
  Widget build(BuildContext context) {
    return RowItemTemplate(
      isEven: isEven,
      child: Row(
        children: [
          Expanded(child: Text(item.name,style: tableItemStyle)),
          Expanded(child: Text(item.description,style: tableItemStyle,)),
        ],
      ),
    );
  }
}