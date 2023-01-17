import 'package:billing_app/screens/login/controller/pin_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:billing_app/constants/assets.dart';
import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/screens/home/home_view.dart';
import 'package:billing_app/screens/login/controller/create_pin_controller.dart';
import 'package:billing_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class PinLoginScreenView extends StatefulWidget {
  const PinLoginScreenView({Key? key}) : super(key: key);

  @override
  _PinLoginScreenViewState createState() => _PinLoginScreenViewState();
}

class _PinLoginScreenViewState extends State<PinLoginScreenView> {
  TextStyle verifyTextStyle = TextStyle(
      fontSize: 14,
      color:Color(0xff8b0e1a),
      fontFamily: 'whitneybook',
      fontWeight: FontWeight.w800);
  @override
  Widget build(BuildContext context) {
    final watch=context.watch<PinLoginController>();
    final read=context.read<PinLoginController>();
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            upperContainer(
                child: Text("Enter your pin",style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'whitneysemibold',
                    color: Colors.white),),
                screenContext: context
            ),

            lowerContainer(child:  Wrap(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                    //   child: Text('OTP Verification',style: headingTextStyle
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(watch.message??"",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.red),),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[

                              Image.asset(
                                'assets/images/img_otp.png',
                                fit: BoxFit.contain,
                                width:120,
                                height: 120,
                                color: AppColor.primaryColor,
                              ),
                              // Container(
                              //   height: 70,
                              //   width: 70,
                              //
                              //   decoration: BoxDecoration(
                              //       color: AppColor.primaryColor,
                              //     shape: BoxShape.circle
                              //   ),
                              //   child:Center(
                              //     child:  Image.asset(
                              //       Assets.assetsIconOtp,
                              //       fit: BoxFit.fill,
                              //       color: Colors.white,
                              //       width: 40,
                              //       height: 40,
                              //     ),
                              //   ),
                              // ),
                              Text(
                                'Enter security pin',
                                style: TextStyle(
                                    fontSize: 13,
                                    color:  Colors.black.withOpacity(0.4),
                                    fontFamily: 'whitneylight',
                                    fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center,

                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              OTPTextField(
                                controller: watch.otpController,
                                length: 4,
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment: MainAxisAlignment.spaceAround,
                                fieldWidth: 45,
                                isDense: true,
                                fieldStyle: FieldStyle.underline,
                                outlineBorderRadius: 45,
                                otpFieldStyle: OtpFieldStyle(
                                  focusBorderColor: AppColor.primaryColor,
                                  borderColor: Colors.grey,
                                  enabledBorderColor: Colors.black,
                                ),
                                style: TextStyle(fontSize: 17),
                                onChanged: (pin) {
                                  watch.pinNumber=pin;
                                },
                              ),
                              const SizedBox(
                                height: 26,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PrimaryButton(onTap: (){
                                    read.setPin(context);
                                    // Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreenView()));
                                  },
                                    label:'Login',
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text('',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            read.onForgotPinClicked(context);
                          },
                          child:  Text('Forgot Pin',
                              style: verifyTextStyle
                          ),

                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ), screenContext: context)

          ],
        ),
      ),
    );
  }
  Widget upperContainer({required Widget child, required BuildContext screenContext}) {
    return Container(
      color:Colors.white,
      height: 150,
      width:MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColor.primaryColor, borderRadius: radiusOnly(bottomLeft: 40),border: Border.all(color:AppColor.primaryColor,width: 0)),
        child: Center(child:Row(
          children: [
            child,
          ],
        )),
      ),
    );
  }
  Widget lowerContainer({required Widget child, required BuildContext screenContext}) {
    return Container(

      color: AppColor.primaryColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radiusOnly(topRight: 40),
            border: Border.all(color: Colors.white,width: 0)
        ),
        child: child,
      ),
    );
  }
  BorderRadius radiusOnly({
    double? topRight,
    double? topLeft,
    double? bottomRight,
    double? bottomLeft,
  }) {
    return BorderRadius.only(
      topRight: radiusCircular(topRight ?? 0),
      topLeft: radiusCircular(topLeft ?? 0),
      bottomRight: radiusCircular(bottomRight ?? 0),
      bottomLeft: radiusCircular(bottomLeft ?? 0),
    );
  }
  Radius radiusCircular([double? radius]) {
    return Radius.circular(radius ?? 8.0);
  }
  BorderRadius radius([double? radius]) {
    return BorderRadius.all(radiusCircular(radius ?? 8.0));
  }
  ClipRRect cornerRadiusWithClipRRect(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
  }
