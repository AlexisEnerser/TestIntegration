import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:zohoanalytics/Models/Access/LoginResponse.dart';
import 'package:zohoanalytics/Models/Reports/ReportResponse.dart';


String urlBase = "https://analytics.enerser.com.mx/services";

Color blue1 = const Color(0xFF3A6381);
Color blue2 = const Color(0xFF004882);
Color barColor = Colors.grey.shade800;

const TextStyle layoutTitle = TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold);
const TextStyle tableStyle = TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500);
const TextStyle tableItemStyle = TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w300);

Color dashboardColor = Colors.purple;
IconData dashboardIcon = Icons.dashboard;
Color reportColor = Colors.green;
IconData reportIcon = Icons.find_in_page_sharp;

UserInfoResponseData? userData;

ReportResponse? userReports;

String token ="";