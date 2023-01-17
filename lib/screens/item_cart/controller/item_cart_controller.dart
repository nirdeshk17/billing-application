import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:billing_app/screens/home/data/models/home_model.dart';
import 'package:billing_app/screens/home/home_view.dart';
import 'package:billing_app/screens/item_cart/data/item_cart_model.dart';
import 'package:billing_app/screens/item_cart/data/item_repo.dart';
import 'package:billing_app/utils/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
class ItemCartController extends ChangeNotifier{
  ItemRateRepository _itemRateRepository=ItemRateRepository();

  List<RateData> ?rateData;
  String qty="0.00";
  String ? status;
  String rate="0.0";
  String ? message;
  String  actualRate="";
  bool isLoading=true;
  Future<void> initState(context,itmName,rate,qty) async {
    await getItemRate(itmName,rate,qty);
    notifyListeners();
  }
  void onClearBtnPressed(){
    qty="";
    rate=double.parse(actualRate.toString()).toStringAsFixed(2);
    notifyListeners();
  }
  void onKeyPadTap(key){
    if(qty=="0.00"){
     qty="";
    }
    qty=qty+key;
    //
    // if(double.parse(qty)<=0|| qty==""){
    //   rate=double.parse(actualRate.toString()).toStringAsFixed(2);
    // }
    // else{
    //   rate=(double.parse(rate.toString())* double.parse(qty)).toStringAsFixed(2);
    // }
    notifyListeners();
  }
  Future<void> getItemRate(itmName,itemRate,quantity)async{
    isLoading=true;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String id="";

    Database db = await SQLiteDbProvider.db.database;
    List itmId=await db.rawQuery("select itm_id from itm_mastr where itm_name='${itmName}'");
    for(int i=0;i<itmId.length;i++){
      id=itmId[0]["itm_id"].toString();
    }

    _itemRateRepository.getItemRate(pref.getString("LICENCE"),id)
        .then((response) async {
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final data = itemRateResModel.fromJson(result);
        status=data.status;
        if(status=="1"){
          rateData=data.data;
          int num=rateData?.length??0;
          if(itemRate!=null&&quantity!=null){
            qty=quantity;
          }
          else{
            qty="0.00";
          }
            for(int i=0;i<num;i++){
              rate=rateData?[0].incRate??"0.0";
              actualRate=rateData?[0].incRate??"0.0";
              notifyListeners();
            }



        }
        }
    }).then((sucess){
      isLoading=false;
      notifyListeners();
    });
    notifyListeners();
  }
  void onOkBtnPressed(totalRate,itmName,qty,context)async{

    if(double.parse(qty)<=0|| qty==""){
      message="Please enter a quantity";
      notifyListeners();
      return;
    }
    else{
      String id="";
      Database db = await SQLiteDbProvider.db.database;
      List itmId=await db.rawQuery("select itm_id from itm_mastr where itm_name='${itmName}'");
      for(int i=0;i<itmId.length;i++){
        id=itmId[0]["itm_id"].toString();
      }
      print("hi");
      db.rawUpdate("update itm_mastr set itm_rate=${totalRate},is_selected='Y',qty=${qty} where itm_id=${id}");
      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreenView()));
    }
  }
}


