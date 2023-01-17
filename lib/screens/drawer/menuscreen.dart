import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class menuscreen extends StatelessWidget {
  const menuscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage:
                  AssetImage('assets/images/profilepic.png'),
                ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "krystle Mathew",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                    fontSize: 20),
              ),
            ],
          ),
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.only(left: 30),
                title: Text("Home",style: TextStyle(color: Color(0xFF27306d),fontWeight: FontWeight.bold),),
               onTap: (){},
              ),
              Container(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Divider(
                  color:Color(0xFFf2e9ee),
                  thickness: 2,
                ),
              ),

              ListTile(
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.only(left: 30),
                title: Text("Book A Nanny",style: TextStyle(color: Color(0xFF27306d),fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Divider(
                  color:Color(0xFFf2e9ee),
                  thickness: 2,
                ),
              ),
              ListTile(
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.only(left: 30),
                title: Text("How It Works",style: TextStyle(color: Color(0xFF27306d),fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Divider(
                  color:Color(0xFFf2e9ee),
                  thickness: 2,
                ),
              ),
              ListTile(
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.only(left: 30),
                title: Text("Why Nanny Vanny",style: TextStyle(color: Color(0xFF27306d),fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Divider(
                  color:Color(0xFFf2e9ee),
                  thickness: 2,
                ),
              ),
              ListTile(
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.only(left: 30),
                title: Text("My Booking",style: TextStyle(color: Color(0xFF27306d),fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Divider(
                  color:Color(0xFFf2e9ee),
                  thickness: 2,
                ),
              ),
              ListTile(
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.only(left: 30),
                title: Text("My Profile",style: TextStyle(color: Color(0xFF27306d),fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Divider(
                  color:Color(0xFFf2e9ee),
                  thickness: 2,
                ),
              ),
              ListTile(
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.only(left: 30),
                title: Text("Support",style: TextStyle(color: Color(0xFF27306d),fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
