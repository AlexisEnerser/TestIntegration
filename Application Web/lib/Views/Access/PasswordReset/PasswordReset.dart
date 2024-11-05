import 'package:flutter/material.dart';
import 'package:zohoanalytics/Views/Access/PasswordReset/views/PasswordResetMovilWeb.dart';
import 'package:zohoanalytics/Views/Access/PasswordReset/views/PasswordResetWeb.dart';
import '../../Components/IsPhone.dart';
import 'PasswordResetLogic.dart';


class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordReset();
}

class _PasswordReset extends State<PasswordReset> {
  PasswordResetLogic logic = PasswordResetLogic();


  @override
  Widget build(BuildContext context) {
    return isMobileDevice(MediaQuery.of(context).size.width)
        ?PasswordResetMovilWeb(logic: logic)
        :PasswordResetWeb(logic: logic);
  }
}