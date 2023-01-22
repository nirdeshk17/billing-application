import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final String? label;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final void Function(String) ? onChanged;

  const SearchBar({Key? key,this.controller,this.suffixIcon,this.label,this.onChanged}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child:    TextFormField(
        decoration: InputDecoration(
          labelText: widget.label??"",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIcon: widget.suffixIcon,
        ),
        controller: widget.controller,
        onChanged:widget.onChanged,

      ),
    );

  }
}
