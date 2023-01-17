import 'dart:async';

import 'package:billing_app/screens/login/login_view.dart';
import 'package:billing_app/screens/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
  context.read<SplashScreenController>().SetSplashScreenTimer(context);
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:Image(image: AssetImage('assets/images/syutlogo.png'),fit: BoxFit.cover),
      ),
    );
  }
}
