import 'package:billing_app/constants/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Icon? icons;
  final String? label;
  final void Function()? onTap;
  final bool? toUpperCase;
  final bool? isRounded;

  const PrimaryButton(
      {Key? key,
      this.color,
      this.width,
      this.height,
      this.label,
      this.toUpperCase,
      this.isRounded,
      required this.onTap,
      this.icons})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  TextStyle buttonStyle = TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontFamily: 'whitneymedium',
      fontWeight: FontWeight.w300);
  TextStyle upperCaseButtonStyle = TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontFamily: 'whitneymedium',
      fontWeight: FontWeight.w300);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width / 1.3,
      height: widget.height ?? 40,
      // color: Color(0xff8b0e1a),
      child: TextButton(
        onPressed: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icons ?? Container(),
            widget.icons != null
                ? SizedBox(
                    width: 3,
                  )
                : Container(),
            widget.toUpperCase == null
                ? Text(widget.label ?? "", style: buttonStyle)
                : widget.toUpperCase == true
                    ? Text(widget.label.toString().toUpperCase(),
                        style: upperCaseButtonStyle)
                    : Text(widget.label ?? "", style: buttonStyle),
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: widget.color ?? AppColor.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32))),
      ),
    );
  }
}

class HomeScreenButton extends StatefulWidget {
  final double? width;
  final double? height;
  final bool? isRounded;
  final double? labelSize;
  final String? label;
  final Color? color;
  const HomeScreenButton({Key? key,this.width,this.isRounded,this.height,this.label,this.color,this.labelSize}) : super(key: key);

  @override
  State<HomeScreenButton> createState() => _HomeScreenButtonState();
}

class _HomeScreenButtonState extends State<HomeScreenButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: 5,bottom: 5),
        width: widget.width??70,
        height: widget.height??30,
        child:Center(
          child:  Text(widget.label??"",style: TextStyle(
              fontSize: widget.labelSize??16,
              color: Colors.white,
              fontFamily: 'whitneymedium',
              fontWeight: FontWeight.w300),),
        ),
        decoration: BoxDecoration(
          color: widget.color?? Color(0xff8b0e1a),
          borderRadius: widget.isRounded==false?BorderRadius.circular(0):BorderRadius.circular(30),
        ),
      ),
    );
  }
}

