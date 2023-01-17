import 'dart:convert';

import 'package:billing_app/screens/home/data/models/home_model.dart';
import 'package:billing_app/screens/home/data/repository/home_repository.dart';
import 'package:billing_app/screens/home/home_view.dart';
import 'package:billing_app/utils/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends ChangeNotifier {
  HomeRepository _homeRepository = HomeRepository();
  bool isSearchBarVisible = false;
  List<itmData>? items;
  List<PartyData>? party;
  List itemList=[];
  List? partyList;
  bool? isLoading;
  List ?selectedItmList;
  String? totalRate;
  String ? totSum;
  List<String> itemNameList=[];
  TextEditingController  searchController=TextEditingController();
  void onSearchPressed() {
    isSearchBarVisible = true;
    notifyListeners();
  }

  void onClosePressed() {
    isSearchBarVisible = false;
    notifyListeners();
  }

  Future<void> initState(context) async {
   await getStoredAllItems(context);
   await getSelectedItems(context);
  }

  Future<void> getAllItems(context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    Database db = await SQLiteDbProvider.db.database;
    db.rawDelete("delete from itm_mastr");
    itemList = await db.rawQuery("select itm_id,itm_name from itm_mastr");
    if (itemList.isEmpty) {
      print("hello all");
      _homeRepository
          .getItemData(pref.getString("LICENCE"))
          .then((response) async {
        print(response);
        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          final data = ItemsResModel.fromJson(result);
          if (data.status == "1") {
            items = data.data;
            db.rawDelete("delete from itm_mastr");
            String query = "INSERT INTO itm_mastr(itm_id,itm_name)VALUES";
            String values = "";
            int length = items?.length ?? 0;
            for (int i = 0; i < length; i++) {
              String partyName = items?[i].itmName.toString().replaceAll(
                  "'", "") ?? "";
              print("loading dude");
              values += "('${items?[i].itmId}','${partyName}'),";
            }
            values = values.substring(0, values.length - 1);
            db.rawInsert(query + values);
          }
        }
        else{
          print("exception");
        }

      }).then((value) async{
        getAllParty(context);

        notifyListeners();
      });
      notifyListeners();
    }
  }

  Future<void> getAllParty(context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    Database db = await SQLiteDbProvider.db.database;
    db.rawDelete("delete from party_mastr");
    partyList = await db.rawQuery(
        "select party_id,party_name,primary_address,party_gstin from party_mastr");
    if (partyList!.isEmpty) {

      _homeRepository
          .getPartyData(pref.getString("LICENCE"))
          .then((response) async {
        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          final data = PartyResModel.fromJson(result);
          if (data.status == "1") {
            party = data.data;
            db.rawDelete("delete from party_mastr");
            String query =
                "INSERT INTO party_mastr(party_id,party_name,primary_address,party_gstin)VALUES";
            print(query);
            String values = "";
            print(party?.length);
            int length = party?.length ?? 0;
            for (int i = 0; i < length; i++) {
              String partyName=party?[i].partyName.toString().replaceAll("'","")??"";
              String primaryAddress=party?[i].primaryAddress.toString().replaceAll("'","")??"";
              String gstin=party?[i].gstin.toString().replaceAll("'","")??"";
              values +=
              "('${party?[i].partyId}','${partyName}','${primaryAddress}','${gstin}'),";
            }
            values = values.substring(0, values.length - 1);
            print(query + values);
            db.rawInsert(query + values);
          }
        }
        else{
          print("error");
        }
      }).then((value){
        getStoredAllItems(context).then((value){
          getSelectedItems(context);
          Navigator.pop(context);
          Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreenView()));
        });

      });
      notifyListeners();
    }
  }

  Future <void> getStoredAllItems(context)async{

    Database db = await SQLiteDbProvider.db.database;
    final List<Map<String, dynamic>> result  = await db.rawQuery("select itm_name from itm_mastr");

    print("3333");
    print(result);

    for(int i=0;i<result.length;i++){
      itemNameList.add(result[i]["itm_name"]);
    }
    print(itemNameList);
    notifyListeners();
  }
 void search(value)async{
   Database db = await SQLiteDbProvider.db.database;
   selectedItmList=await db.rawQuery( "SELECT * FROM itm_mastr pm where pm.itm_name LIKE '${value.toString()}%'");
 notifyListeners();
  }
  Future<void> getStoredAllParty()async{

    Database db = await SQLiteDbProvider.db.database;
    partyList = await db.rawQuery(
        "select party_id,party_name,primary_address,party_gstin from party_mastr");

    notifyListeners();
  }
  void onDeletePressed(itmId)async{
    Database db = await SQLiteDbProvider.db.database;
    db.rawUpdate("update itm_mastr set itm_rate=0,is_selected='N',qty=0 where itm_id=${itmId}");
    selectedItmList=await db.rawQuery("select itm_id,itm_name,itm_rate,qty from itm_mastr where is_selected='Y'");
    List sum=await db.rawQuery("select sum(itm_rate)sum from itm_mastr where is_selected='Y'");
    print(sum);
    for(int i=0;i<sum.length;i++){
      totSum=sum[i]["sum"].toStringAsFixed(2);
    }
    notifyListeners();
  }

  Future<void> getSelectedItems(context)async{
    Database db = await SQLiteDbProvider.db.database;
    selectedItmList=await db.rawQuery("select itm_id,itm_name,itm_rate,qty from itm_mastr where is_selected='Y'");
    List sum=await db.rawQuery("select sum(itm_rate)sum from itm_mastr where is_selected='Y'");
  print(sum);

   for(int i=0;i<sum.length;i++){
     totSum=sum[i]["sum"].toStringAsFixed(2);
   }
    print(selectedItmList?.length);
    int num=selectedItmList?.length??0;
    for(int i=0;i<num;i++){
      if(selectedItmList?[0]["itm_name"]!=null){

        totalRate=(selectedItmList?[i]["itm_rate"]+selectedItmList?[i]["itm_rate"]).toString();
        notifyListeners();
      }
      else{
        selectedItmList=[];
        notifyListeners();
      }
    }
    print(totalRate);
    notifyListeners();
  }
}
