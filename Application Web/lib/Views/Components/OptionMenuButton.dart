import 'package:flutter/material.dart';
import 'package:zohoanalytics/constants.dart';

class OptionMenuButton extends StatelessWidget {
  final double? width;
  final String hint;
  final List<String> options;
  final void Function(String?) onSelected;
  final String selectedOption;
  const OptionMenuButton({super.key, required this.hint, required this.options, required this.onSelected, this.width, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 2
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: DropdownButton<String>(
          icon:const  Icon(null),
          isExpanded: true,
          underline: const SizedBox(width: 1,),
          style: tableItemStyle,
          value: selectedOption.isEmpty? null : selectedOption,
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,overflow: TextOverflow.fade,),
            );
          }).toList(),
          onChanged: (value)=>onSelected(value),
          hint: Text(
            hint,
            style: tableItemStyle,
          ),
        ),
      ),
    );
  }
}