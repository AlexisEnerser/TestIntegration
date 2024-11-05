import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PendingTextField extends StatefulWidget {
  final double width;
  final String? placeholder;
  final TextEditingController controller;
  final Function? onSubmitted;
  final bool? onlyNumbers;
  const PendingTextField({
    super.key,
    required this.width,
    required this.placeholder,
    required this.controller,
    this. onlyNumbers,
    this. onSubmitted,
  });

  @override
  State<PendingTextField> createState() => _PendingTextFieldState();
}

class _PendingTextFieldState extends State<PendingTextField> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: (widget.width/2)*0.8,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
              border: Border(bottom: BorderSide(color: Colors.blueGrey, width: 1)),
              borderRadius: BorderRadius.circular(9)
          ),
          child: TextField(
            controller: widget.controller,
            onSubmitted: (value){
              if(widget.onSubmitted!=null){
                widget.onSubmitted!();
              }
            },
            inputFormatters: (widget.onlyNumbers??false)
                            ?<TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ]
                            :[],
            decoration:  InputDecoration(
              fillColor: Colors.transparent,
              filled: true,
              hintText: widget.placeholder,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(
                left: 15,
                bottom: 11,
                top: 9,
                right: 15,
              ),
            ),

          ),
        )
      ],
    );
  }
}