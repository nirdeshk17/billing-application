import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/screens/home/controller/home_screen_controller.dart';
import 'package:billing_app/screens/item_cart/controller/item_cart_controller.dart';
import 'package:billing_app/screens/login/controller/login_controller.dart';
import 'package:billing_app/screens/login/controller/create_pin_controller.dart';
import 'package:billing_app/screens/login/controller/pin_login_controller.dart';
import 'package:billing_app/screens/login/login_view.dart';
import 'package:billing_app/screens/payment/controller/payment_controller.dart';
import 'package:billing_app/screens/settlement/controller/settlement_controller.dart';
import 'package:billing_app/screens/splash/controller/splash_controller.dart';
import 'package:billing_app/screens/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>ItemCartController(),),
      ChangeNotifierProvider(create: (_)=>HomeScreenController(),),
      ChangeNotifierProvider(create: (_)=>SettlementController(),),
      ChangeNotifierProvider(create: (_)=>LoginScreenController(),),
      ChangeNotifierProvider(create: (_)=>CreatePinScreenController(),),
      ChangeNotifierProvider(create: (_)=>PinLoginController(),),
      ChangeNotifierProvider(create: (_)=>SplashScreenController(),),
      ChangeNotifierProvider(create: (_)=>PaymentController(),),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(),
      color: Colors.white,
      theme: ThemeData(appBarTheme: AppBarTheme(color: AppColor.primaryColor),fontFamily: 'whitneymedium'),
    ),
  ));
}
