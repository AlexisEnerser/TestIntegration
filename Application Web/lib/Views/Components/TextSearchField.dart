import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class Textsearchfield  extends StatelessWidget {
  final List<String> list;
  final Function(String) onSelected;
  final String hintText;
  const Textsearchfield({super.key, required this.list, required this.onSelected, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SearchField<String>(
      hint: hintText,
      onSuggestionTap: (selected){
        if(selected.item!=null){
          onSelected(selected.item!);
          FocusScope.of(context).unfocus();
        }
      },             
      suggestions: list.map((e) => SearchFieldListItem<String>(
          e,
          item: e,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(e),
              ],
            ),
          ),
        ),
      ).toList(),
      searchInputDecoration: const InputDecoration(
        enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 3.0),
        ),
      ),
    );
  }
}