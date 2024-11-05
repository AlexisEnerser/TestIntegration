import 'package:flutter/Material.dart';

import '../../../Models/GeneralResponse.dart';
import '../../../Services/AccessServices.dart';
import '../../Components/LoadingAlert.dart';
import '../../Components/OkDialogAlert.dart';

class PasswordResetLogic{

  TextEditingController userController  = TextEditingController();

  Future<void> callRecoveryPasswordService(BuildContext context) async{
    if(userController.text.isEmpty){
      showOkAlert(
          context: context,
          title: "Atención",
          message: "Debes ingresar un número de empleado válido"
      );
      return;
    }

    showLoadingAlert(context: context);
    GeneralResponse recoveryPasswordResponse = await makeRecoveryPassword(userName: userController.text);
    closeLoadingAlert(context: context);
    if(recoveryPasswordResponse.code != 1){
      showOkAlert(
          context: context,
          title: "Error",
          message: recoveryPasswordResponse.message
      );
      return;
    }
    showOkAlert(
        context: context,
        title: "Atención",
        message: "Hemos enviado un correo al ${hideEmail(recoveryPasswordResponse.message)} para cambiar la contraseña, revisa tu bandeja de entrada",
        action: (){Navigator.pop(context);}
    );
  }

  String hideEmail(String? email) {
  if (email == null || email.isEmpty) return '';
  int atIndex = email.indexOf('@');
  if (atIndex <= 0) return email;
  int hideCount = ((atIndex - 2) * 0.6).round();
  String hiddenPart = '*' * hideCount;
  String firstTwoCharacters = email.substring(0, 2);
  String domain = email.substring(atIndex);
  return '$firstTwoCharacters$hiddenPart$domain';
}

  void moveBack(BuildContext context){
    Navigator.pop(context);
  }

}