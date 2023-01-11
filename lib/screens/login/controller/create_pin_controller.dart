import 'package:billing_app/screens/home/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
class CreatePinScreenController extends ChangeNotifier{
  String ? pinNumber;
  String ?message;
  OtpFieldController otpController = OtpFieldController();

  void setPin(BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(pinNumber);
    await prefs.setString("PIN",pinNumber.toString());
   if(pinNumber?.length==4){
     Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreenView()));
   }
   else{
     message="Enter 4 digit pin";
     notifyListeners();
   }
  }
}