import 'dart:convert';
import 'package:billing_app/screens/login/create_pin_view.dart';
import 'package:billing_app/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:billing_app/screens/login/data/models/login_model.dart';
import 'package:billing_app/screens/login/data/repository/login_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LoginScreenController extends ChangeNotifier{
LoginRepository _loginRepository=LoginRepository();
TextEditingController  userNameController=TextEditingController();
TextEditingController  passwordController=TextEditingController();
String ? status;
String ? message;
LoginData? loginData;
Future<void> getLoginInfo(BuildContext context)async{
  if(userNameController.text!=""&&passwordController.text!=""){
    _loginRepository.getLoginData(userNameController.text,passwordController.text).then((response)async{
      print(response.statusCode);
      if(response.statusCode==200){
        final result=jsonDecode(response.body);
        print(result);
        final data=LoginResModel.fromJson(result);
        print("result ${result}");
        status=data.status;
        message=data.message;
        loginData=data.data;
        print(loginData?.name);
        if(loginData?.licence!=null){
          await setLicenceKey(context);
        }
        notifyListeners();
      }
      else{

      }
    });
  }
  else{
    if(userNameController.text==""){
      message="Enter username";
      notifyListeners();
    }
    else{
      message="Enter password";
      notifyListeners();
    }
  }
}
Future<void> setLicenceKey(context)async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  print(await prefs.getString("LICENCE"));
  if(prefs.getString("LICENCE")==""||prefs.getString("LICENCE")==null){
  await  prefs.setString("NAME",loginData?.name.toString()??"");
  print(await prefs.getString("NAME"));
  await prefs.setString("ID",loginData?.id.toString()??"");
  await  prefs.setString("BRANCH",loginData?.branch.toString()??"");
  await prefs.setString("LICENCE",loginData?.licence.toString()??"");
  await  prefs.setString("LOCATION",loginData?.location.toString()??"");
  Navigator.push(context,MaterialPageRoute(builder: (context)=>CreatePinView()));
  }
  else{
    Navigator.push(context,MaterialPageRoute(builder: (context)=>CreatePinView()));
  }
}
}