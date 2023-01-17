import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/screens/login/controller/login_controller.dart';
import 'package:billing_app/screens/login/data/repository/login_repository.dart';
import 'package:billing_app/screens/login/create_pin_view.dart';
import 'package:billing_app/widgets/button.dart';
import 'package:billing_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class LoginScreenView extends StatefulWidget {
  const LoginScreenView({Key? key}) : super(key: key);

  @override
  _LoginScreenViewState createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  bool viewPassword = true;
  TextStyle appBarStyle = TextStyle(
      fontSize: 25,
      fontFamily: 'whitneysemibold',
      color: Colors.white);
  @override
  Widget build(BuildContext context) {
    final watch=context.watch<LoginScreenController>();
    final read=context.watch<LoginScreenController>();
    return Scaffold(
      backgroundColor:Colors.white,
      body:WillPopScope(
        onWillPop: ()async{
          return false;
        },
        child:SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              upperContainer(
                screenContext: context,
                child: Text('Login',style: appBarStyle,),
              ),
              lowerContainer(
                  screenContext: context,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Text(watch.message??"",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.red),),
                          SizedBox(
                            height: 30,
                          ),
                          Stack(
                            children: [
                              LoginFormField(
                                controller:watch.userNameController,
                                label: "Username",
                              ),
                              Positioned(left: 0,top: 20,child:Container(
                                width: 20,
                                height: 20,
                                child: Image.asset("assets/icons/prefix/user.png",fit: BoxFit.fill,),
                              ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Stack(
                            children: [
                              LoginFormField(

                                controller: watch.passwordController,
                                labelPadding: 2,
                                obsecureText: viewPassword,
                                label: "Password",
                                maxLines: 1,
                                SuffixIcon: IconButton(
                                  onPressed: () => setState(() => viewPassword = !viewPassword),
                                  icon: viewPassword
                                      ? Icon(Icons.visibility_off, color:AppColor.primaryColor)
                                      : Icon(Icons.visibility, color: AppColor.primaryColor,),
                                ),
                              ),
                              Positioned(left: 0,top: 13,child:Container(
                                width: 20,
                                height: 22,
                                child: Image.asset("assets/icons/prefix/lock.png",fit: BoxFit.fill,),
                              ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryButton(onTap: (){
                                read.getLoginInfo(context);
                                // Navigator.push(context,MaterialPageRoute(builder: (context)=>PinScreenView()));
                              },
                                label:'Login',
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
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
