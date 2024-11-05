import 'package:flutter/material.dart';

class SelectedButton extends StatefulWidget {

  final bool isSelected;
  final String title;
  final IconData icon;
  final Color color;
  final void Function() onTap;
  final double? width;
  const SelectedButton({super.key,
    required this.color,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.width,
  });

  @override
  State<SelectedButton> createState() => _SelectedButtonState();
}

class _SelectedButtonState extends State<SelectedButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 30,
      width: widget.width??150,
      decoration: BoxDecoration(
        color: widget.isSelected?widget.color:Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: widget.isSelected?Colors.white:widget.color
        )
      ),
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: widget.onTap,
        child: Row(
          children: [
            const SizedBox(width: 10,),
            Icon(widget.icon,color: widget.isSelected?Colors.white:widget.color,),
            const Spacer(),
            Text(widget.title,style: TextStyle(color: widget.isSelected?Colors.white:widget.color),),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
