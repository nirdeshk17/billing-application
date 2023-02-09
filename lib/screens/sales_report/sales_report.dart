import 'dart:convert';
import 'dart:io';

import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/network/base_url.dart';
import 'package:billing_app/screens/sales_report/reciept.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class SalesReport extends StatefulWidget {
  const SalesReport({Key? key}) : super(key: key);

  @override
  _SalesReportState createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  List salesData=[];
  getSalesReportData()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var uri=Uri.parse("${BaseUrl.getSales}&token=${pref.getString("LICENCE")}&user_id=${pref.getString("ID")}");
    print(uri);
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(uri);
    HttpClientResponse response = await request.close();
    var reply = await response.transform(utf8.decoder).join();
          print("reply${reply}");
      var a = jsonDecode(reply);
      print(a);
      if(a["status"]=="1"){
        setState(() {
         salesData=a["data"];
        });
      }


  }

  @override
  void initState() {
    getSalesReportData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back,color: Colors.white,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor:AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: Text("Sales Report",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(

            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(itemCount:salesData.isNotEmpty?salesData.length:0,shrinkWrap: true,physics: ScrollPhysics(),itemBuilder: (BuildContext,index){
                  return GestureDetector(
                    onTap: (){
                      // Navigator.push(context,MaterialPageRoute(builder: (BuildContext)=>ItemCartScreenView(itemName: watch.selectedItmList?[index]["itm_name"],itemRate: watch.selectedItmList?[index]["itm_rate"].toString(),qty: watch.selectedItmList?[index]["qty"].toString(),)));
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                         Container(
                           margin:EdgeInsets.symmetric(horizontal: 15),
                          padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 15,
                              bottom: 15),
                          width:
                          MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              borderRadius:
                              BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Text("${salesData[index]["tran_no"]}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                  ),
                                  Row(
                                    children: [
                                      Text('\u{20B9}',style:TextStyle(
                                          color: Colors.green, fontSize: 16),),
                                      Text('${salesData[index]["tot_sales_amt"]}',style:TextStyle(
                                          color: Colors.green, fontSize: 16),)
                                    ],
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("${salesData[index]["date"]}",
                                        style: TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap:(){
                                     Navigator.push(context,MaterialPageRoute(builder: (context)=>Reciept(tranNo: salesData[index]["tran_no"])));
                                        },
                                        child:Icon(Icons.print),
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(
                  height: 10,
                ),

              ],
            ),


          )),
          Align(
            child: InkWell(
              onTap: (){

              },
              child: Container(
                margin: EdgeInsets.only(left: 15,right: 15,bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primaryColor,
                ),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    Text("Charge",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white),),
                    SizedBox(
                      height: 3,
                    ),
                    Text("0.0",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),)
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
