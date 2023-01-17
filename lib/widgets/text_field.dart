import 'package:billing_app/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginFormField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double? width;
  final int? maxLines;
  final Widget ? SuffixIcon;
  final bool ? obsecureText;
  final Widget? preffixIcon;
  final double ? labelPadding;
  final bool? readOnly;

  const LoginFormField({
    Key? key,
    this.labelPadding,
    this.obsecureText,
    this.controller,
    this.width,
    this.readOnly,
    this.label,
    this.onChanged,
    this.SuffixIcon,
    this.maxLines,
    this.preffixIcon,
this.onTap,
  }) : super(key: key);

  @override
  State<LoginFormField> createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  TextStyle labelStyle = TextStyle(
      fontSize: 16,
      color:  Color(0xff8a8a8a),
      fontFamily: 'whitneymedium',
      fontWeight: FontWeight.w300);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width != null
          ? widget.width
          : MediaQuery.of(context).size.width/1.15,
      child: TextFormField(
        readOnly: widget.readOnly??false,
        style:TextStyle(
            fontSize: 16,
            color:  Colors.black,
            fontFamily: 'whitneymedium',
            fontWeight: FontWeight.w300),
        controller: widget.controller,
 onTap:widget.onTap,
        textAlignVertical: TextAlignVertical.top,
        maxLines: widget.maxLines,
        cursorColor: Color(0xff8b0e1a),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left:30),
          labelStyle: labelStyle,
          // labelText: widget.label,
          label: Padding(
            padding: widget.maxLines==3?EdgeInsets.only(bottom:15):widget.maxLines==5?EdgeInsets.only(bottom:50) :EdgeInsets.only(top:widget.labelPadding??15),
            child: Text('${widget.label}'),
          ),
          fillColor: Colors.transparent,
          filled: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.5),width: 0.8),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.2),width: 0.8),
          ),
          suffixIcon:widget.SuffixIcon,
          prefix:widget.preffixIcon,
        ),
        onChanged: widget.onChanged,
        obscureText:widget.obsecureText??false,
      ),
    );
  }
}

class PrimaryFormField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double? width;
  final int? maxLines;
  final Widget ? SuffixIcon;
  final bool ? obsecureText;
  final Widget? preffixIcon;
  final double ? labelPadding;
  final String ? hintText;
  final bool? readOnly;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  const PrimaryFormField({
    Key? key,
    this.hintText,
    this.textAlign,
    this.textDirection,
    this.labelPadding,
    this.controller,
    this.obsecureText,
    this.width,
    this.readOnly,
    this.label,
    this.onChanged,
    this.SuffixIcon,
    this.maxLines,
    this.preffixIcon,
    this.onTap,
  }) : super(key: key);

  @override
  _PrimaryFormFieldState createState() => _PrimaryFormFieldState();
}

class _PrimaryFormFieldState extends State<PrimaryFormField> {
  @override
  Widget build(BuildContext context) {
    return
     Container(
          height: 50,
          width: widget.width??MediaQuery.of(context).size.width,
          child: TextFormField(
            textDirection: widget.textDirection,
            readOnly: widget.readOnly??false,
            textAlign: widget.textAlign??TextAlign.start,
            style:TextStyle(
                color:  Colors.black,
                fontFamily: 'whitneymedium',
                fontWeight: FontWeight.w300),
            controller: widget.controller,
            onTap:widget.onTap,
            cursorColor: Color(0xff8b0e1a),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  color:  Color(0xff8a8a8a),
                  fontFamily: 'whitneymedium',
                  fontWeight: FontWeight.w300),
              labelStyle: TextStyle(
                  fontSize: 16,
                  color:  Color(0xff8a8a8a),
                  fontFamily: 'whitneymedium',
                  fontWeight: FontWeight.w300),
              // labelText: widget.label,
              labelText: widget.label,

              fillColor: Colors.transparent,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: AppColor.primaryColor)),
              suffixIcon:widget.SuffixIcon,
              prefix:widget.preffixIcon,
            ),
            onChanged: widget.onChanged,
          ),
        );




  }
}

