import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Menu/HomePages/GroupPage/views/GroupPageMovil.dart';
import 'GroupPageLogic.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {

  GroupPageLogic logic = GroupPageLogic();

  @override
  Widget build(BuildContext context) {
    return GroupPageMovil(logic: logic);
  }
}


