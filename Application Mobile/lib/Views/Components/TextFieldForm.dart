import 'package:flutter/material.dart';
import 'package:zohoanalytics/constants.dart';

class TextFieldForm extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool? isPassword;
  final bool? isActive;
  final bool? isNumeric;
  final int? maxLines;
  final void Function(String)? onChanged;
  const TextFieldForm({
    super.key, 
    required this.label, 
    required this.controller, 
    this.isPassword, 
    this.maxLines, 
    this.isActive, 
    this.isNumeric,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: isNumeric??false?TextInputType.number:TextInputType.text,
      enabled: isActive??true,
      controller: controller,
      obscureText: isPassword??false,
      textAlign: TextAlign.start, 
      style: tableItemStyle,   
      minLines: 1,
      maxLines: maxLines??1,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: tableItemStyle,
        labelText: label,
        labelStyle: tableItemStyle,
        floatingLabelStyle: tableItemStyle,
        enabledBorder:const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 3.0),
        ),
      )
    );
  }
}