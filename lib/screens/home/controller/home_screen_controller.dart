import 'dart:convert';
import 'package:billing_app/screens/home/data/models/home_model.dart';
import 'package:billing_app/screens/home/data/repository/home_repository.dart';
import 'package:billing_app/screens/home/home_view.dart';
import 'package:billing_app/screens/item_cart/item_cart_view.dart';
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
  List<String> groupNameList=[];
  List itemsList=[];
  String selectedItem="";
  TextEditingController  searchController=TextEditingController();
  void onSearchPressed() {
    isSearchBarVisible = true;
    notifyListeners();
  }

  void onClosePressed() async{
    Database db = await SQLiteDbProvider.db.database;
    searchController.clear();
    itemsList=await db.rawQuery("select itm_id,itm_name from itm_mastr");
    isSearchBarVisible = false;
    notifyListeners();
  }

  Future<void> initState(context) async {
   await getStoredAllItems(context);
   await getStoredGroups();
   await getSelectedItems(context);

  }
  Future<void> getGroups(context)async{
    Database db = await SQLiteDbProvider.db.database;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _homeRepository.getGroupData(pref.getString("LICENCE")).then((response)async{
      print(response);
      if(response!=""){
        List result=jsonDecode(response);
       print(result);
       db.rawDelete("delete from group_mastr");
        for(int i=0;i<result.length;i++){
        db.rawInsert("insert into group_mastr(group_id,group_name)values('${result[i]["grp_id"]}','${result[i]["grp_name"]}')");
        }
      }
    }).then((value){
      getAllParty(context);
    });

  }
  Future<void> getStoredGroups()async{
    groupNameList.clear();
    Database db = await SQLiteDbProvider.db.database;
    final List<Map<String, dynamic>> result = await db.rawQuery("select group_name from group_mastr");

    for(int i=0;i<result.length;i++){
      groupNameList.add(result[i]["group_name"]);
    }
    selectedItem=groupNameList[0];
    List data=await db.rawQuery("select group_id from group_mastr where group_name='${selectedItem}'");
    String selectedGroupId="";


      for(int i=0;i<data.length;i++){
        selectedGroupId=data[i]["group_id"].toString();
      }
      itemsList=await db.rawQuery( "SELECT * FROM itm_mastr pm where pm.group_id=${selectedGroupId}");
    List sum=await db.rawQuery("select sum(tot_rate)sum from itm_mastr where is_selected='Y'");
    print(sum);
    if(sum[0]["sum"]!=null){
      totSum=sum[0]["sum"].toStringAsFixed(2);
    }
   else{
     totSum="0.0";
    }
    notifyListeners();
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
        if (response!="") {
          final result = jsonDecode(response);
          final data = ItemsResModel.fromJson(result);
          if (data.status == "1") {
            items = data.data;
            db.rawDelete("delete from itm_mastr");
            String query = "INSERT INTO itm_mastr(itm_id,itm_name,group_id)VALUES";
            String values = "";
            int length = items?.length ?? 0;
            for (int i = 0; i < length; i++) {
              String itmName = items?[i].itmName.toString().replaceAll(
                  "'", "") ?? "";
              print("loading dude");
              values += "('${items?[i].itmId}','${itmName}','${items?[i].groupId}'),";
            }
            values = values.substring(0, values.length - 1);
            db.rawInsert(query + values);
          }
        }
        else{
          print("exception");
        }

      }).then((value) async{
        getGroups(context);


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
        if (response!="") {
          final result = jsonDecode(response);
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
        getStoredGroups().then((value){
          getStoredAllItems(context).then((value){
            getSelectedItems(context);
            Navigator.pop(context);
            Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreenView()));
          });
        });


      });
      notifyListeners();
    }
  }
  void onGroupSelected(groupName)async{
    Database db = await SQLiteDbProvider.db.database;
    List data=await db.rawQuery("select group_id from group_mastr where group_name='${groupName}'");
   String selectedGroupId="";
   if(groupName=="All Items"){
     itemsList=await db.rawQuery( "SELECT * FROM itm_mastr pm");
   }
   else{
     for(int i=0;i<data.length;i++){
       selectedGroupId=data[i]["group_id"].toString();
     }
     itemsList=await db.rawQuery( "SELECT * FROM itm_mastr pm where pm.group_id=${selectedGroupId}");
   }
    notifyListeners();
  }

  Future <void> getStoredAllItems(context)async{

    Database db = await SQLiteDbProvider.db.database;
    selectedItmList=await db.rawQuery("select itm_id,itm_name from itm_mastr where is_selected='Y'");
    // final List<Map<String, dynamic>> result  = await db.rawQuery("select itm_name from itm_mastr");
    itemsList=await db.rawQuery("select itm_id,itm_name from itm_mastr");
    print(itemsList.length);
    print(itemsList);

    // for(int i=0;i<result.length;i++){
    //   itemNameList.add(result[i]["itm_name"]);
    // }
    // print(itemNameList);
    notifyListeners();
  }
 void onHomesearch(value)async{
   Database db = await SQLiteDbProvider.db.database;
   print(value);
   itemsList=await db.rawQuery( "SELECT * FROM itm_mastr pm where pm.itm_name LIKE '${value.toString()}%'");
 notifyListeners();
  }
  void onCheckoutSearch(value)async{
    Database db = await SQLiteDbProvider.db.database;
    print(value);
    if(value==""){
      selectedItmList=await db.rawQuery("SELECT * FROM itm_mastr pm  where pm.is_selected='Y'");
    }
    else{
      selectedItmList=await db.rawQuery("SELECT * FROM itm_mastr pm  where pm.is_selected='Y' LIKE '${value.toString()}%'");
    }
    notifyListeners();
  }

  void onClearBtnPressed(context)async{
    print("hello");
    Database db = await SQLiteDbProvider.db.database;
    db.rawUpdate(
        "update itm_mastr set itm_rate=0,is_selected='N' where is_selected='Y'");
    selectedItmList=await db.rawQuery("select itm_id,itm_name,itm_rate,qty from itm_mastr where is_selected='Y'");
    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreenView()));
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
    List sum=await db.rawQuery("select sum(tot_rate)sum from itm_mastr where is_selected='Y'");
    print(sum);
      totSum=sum[0]["sum"].toStringAsFixed(2);
    notifyListeners();
  }

  Future<void> getSelectedItems(context)async{
    Database db = await SQLiteDbProvider.db.database;
    selectedItmList=await db.rawQuery("select itm_id,itm_name,itm_rate,qty from itm_mastr where is_selected='Y'");
    List sum=await db.rawQuery("select sum(tot_rate)sum from itm_mastr where is_selected='Y'");
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
  void onItemSelected(itmId,context,itmName)async{
    Database db = await SQLiteDbProvider.db.database;
    selectedItmList=await db.rawQuery("select itm_id,itm_name,itm_rate,qty from itm_mastr where is_selected='Y' and itm_id=${itmId}");
   print(selectedItmList);
    List sum=await db.rawQuery("select sum(itm_rate)sum from itm_mastr where is_selected='Y'");
    print(sum);
    int num=selectedItmList?.length??0;
    if(selectedItmList?.length==0){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>ItemCartScreenView(itemName: itmName)));
    }
    else {
      for (int i = 0; i < num; i++) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ItemCartScreenView(itemName: selectedItmList?[i]["itm_name"],
              qty: selectedItmList?[i]["qty"].toString(),
              itemRate: selectedItmList?[i]["itm_rate"].toString(),)));
      }
    }
  }

}
