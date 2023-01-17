import 'package:billing_app/screens/home/home_view.dart';
import 'package:billing_app/screens/login/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class PinLoginController extends ChangeNotifier{
  String ? pinNumber;
  String ?message;
  OtpFieldController otpController = OtpFieldController();

  void setPin(BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   String pin= await prefs.getString("PIN").toString();
   if(pinNumber.toString().length==4){
     if(pinNumber.toString()==pin){
       Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreenView()));
     }
     else{
       message="Invalid Pin";
       notifyListeners();
     }
   }

    else{
      message="Enter 4 digit pin";
      notifyListeners();
    }
  }
  void onForgotPinClicked(BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreenView()));
  }
}