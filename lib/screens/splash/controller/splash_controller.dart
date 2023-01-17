import 'dart:async';
import 'package:billing_app/screens/login/login_view.dart';
import 'package:billing_app/screens/login/pin_login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreenController extends ChangeNotifier{
  Future<void> initState(BuildContext context) async {
    SetSplashScreenTimer(context);
  }

  Future<void> SetSplashScreenTimer(context)async{
    final SharedPreferences pref=await SharedPreferences.getInstance();
    if(pref.getString("LICENCE")==null||pref.getString("PIN")==null){
      Timer(Duration(seconds: 3),()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreenView())));
    }
    else{
      Timer(Duration(seconds: 3),()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>PinLoginScreenView())));
    }

  }
}