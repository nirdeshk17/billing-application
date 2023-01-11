import 'dart:convert';
import 'package:billing_app/network/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/screens/home/home_view.dart';
import 'package:billing_app/screens/party_list/party_list_view.dart';
import 'package:billing_app/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
class PaymentSucessfullScreenView extends StatefulWidget {
  final String ? total;
  final String? partyName;

  const PaymentSucessfullScreenView({Key? key, this.total, this.partyName})
      : super(key: key);

  @override
  _PaymentSucessfullScreenViewState createState() =>
      _PaymentSucessfullScreenViewState();
}

class _PaymentSucessfullScreenViewState
    extends State<PaymentSucessfullScreenView> {
  TextEditingController billNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  String message = "";

  setController() async {
    setState(() {
      billNameController.text = widget.partyName ?? "";
    });
  }

  Future<http.Response> uploadSaleData(String title) async {
    Database db = await SQLiteDbProvider.db.database;
    List salesData=await db.rawQuery("select itm_id,qty,rate from itm_mastr where is_selected='Y'");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return http.post(
      Uri.parse("${BaseUrl.baseUrl}?type=SAVESALE"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'branch': pref.getString("BRANCH").toString(),
        'location': pref.getString("BRANCH").toString(),
        'bill_name': billNameController.text,
        'mobile': mobileController.text,
        'party': pref.getString("ID").toString(),
        'gstin': null,
        'date': DateFormat("yyy-MM-dd").format(DateTime.now()),
        'address':null,
        'user':pref.getString("ID").toString(),
        'sales_items':salesData,
        'settlements':[],

      }),
    );
  }


  @override
  void initState() {
    setController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Done"),
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child:
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.total ?? "0.0", style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Text("Total paid",
                style: TextStyle(fontSize: 16, color: Colors.grey),),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: TextFormField(
                        controller: billNameController,
                        decoration: InputDecoration(
                          labelText: "Bill Name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: AppColor.primaryColor)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => PartyListView()));
                        },
                        child: Icon(Icons.search),
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(
                                AppColor.primaryColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10))))),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: TextFormField(
                        controller: mobileController,
                        decoration: InputDecoration(
                          labelText: "Mobile Number",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: AppColor.primaryColor)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: TextFormField(
                        controller: remarksController,
                        decoration: InputDecoration(
                          labelText: "Remarks",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: AppColor.primaryColor)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(message, style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red),)
            ],),
          ),
          ),
          Align(
            child: InkWell(
              onTap: () async {
                if (billNameController.text == "") {
                  setState(() {
                    message = "Enter bill name";
                  });
                  return;
                }
                else {
                  Database db = await SQLiteDbProvider.db.database;
                  db.rawUpdate(
                      "update itm_mastr set itm_rate=0,is_selected='N' where is_selected='Y'");
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => HomeScreenView()));
                }
                // Navigator.push(context,MaterialPageRoute(builder: (context)=>PaymentScreenView()));
              },
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primaryColor,
                ),
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check, color: Colors.white,),
                        SizedBox(
                          width: 5,
                        ),
                        Text("NEW SALE",
                          style: TextStyle(fontSize: 18, color: Colors.white),)
                      ],
                    ),

                  ],
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
