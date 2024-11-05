import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/AdminUsers/user.dart';
import 'package:zohoanalytics/Views/Components/RowItemTemplate.dart';
import 'package:zohoanalytics/Views/Components/StatusTableDesign.dart';
import 'package:zohoanalytics/constants.dart';

class ItemListUser extends StatelessWidget {
  final bool isEven;
  final User item;
  const ItemListUser({super.key, required this.isEven, required this.item});

  Color statusColor(){
    if(item.idStatus==5){
      return Colors.green;
    }
    else if(item.idStatus == 6){
      return Colors.amber;
    }
    else if(item.idStatus == 7){
      return Colors.red;
    }
    else{
      return Colors.grey;
    }
  }

  String emptyString(String value){
    return value.isEmpty?"--------":value;
  }

    String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return RowItemTemplate(
      isEven: isEven,
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: StatusTableDesign(
              color: statusColor(),
              status: item.status,
            )
          ),
          Expanded(flex: 3,child: Text(emptyString(item.name),style: tableItemStyle.copyWith(fontSize: 12),)),
          Expanded(flex: 3,child: Text(item.userName,style: tableItemStyle.copyWith(fontSize: 12),)),
          Expanded(flex: 3,child: Text(emptyString(item.email),style: tableItemStyle.copyWith(fontSize: 12),)),
          Expanded(flex: 2,child: Text(emptyString(item.employeeNumber.toString()),style: tableItemStyle.copyWith(fontSize: 13),textAlign: TextAlign.center,)),
          Expanded(flex: 3,child: Text(capitalizeFirstLetter(item.userType),style: tableItemStyle.copyWith(fontSize: 12),textAlign: TextAlign.center,)),
          Expanded(flex: 3,child: Text(item.userCategory,style: tableItemStyle.copyWith(fontSize: 12),textAlign: TextAlign.center,)),
        ],
      ),
    );
  }
}