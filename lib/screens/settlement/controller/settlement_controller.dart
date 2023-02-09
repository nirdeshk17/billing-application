import 'dart:convert';

import 'package:billing_app/screens/payment/data/payment_model.dart';
import 'package:billing_app/screens/payment/data/repository/payment_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SettlementController extends ChangeNotifier{
  PaymentRepository _paymentRepository=PaymentRepository();

  String ? paymentType;
  List<TextEditingController> ? paymentController;
  TextEditingController  card1Controller=TextEditingController();
  TextEditingController  card2Controller=TextEditingController();
  bool ? showSplitButton;
  bool  isSplitBtnPressed=false;
  bool ? isLoading;
  String? status;
  String? message;
  List<PaymentData>? paymentData;




  Future<void> initState(BuildContext context,String type,index,amount) async {
    await getPayment(index,amount,type);
    await getPaymentType(type);
     showOrHideSplitButton(type);
   await setPaymentController(index,amount);
    isSplitBtnPressed=false;
  }

  Future<void> getPayment(index,amount,type)async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isLoading=true;
    _paymentRepository.getPaymentData(pref.getString("LICENCE")).then((response){
      if (response != ""){
        final result = jsonDecode(response);
        final data = PaymentResModel.fromJson(result);
        status=data.status;
        message=data.message;
        paymentData=data.data;
        int num=paymentData?.length??0;
        paymentController?.add(new TextEditingController());
        paymentController?.add(amount);
        print(paymentController?[index].text);
        for(int i=0;i<num;i++){
          print("-----");
print(paymentData?[i].paytypeName);
print(type);
print(index);
print(i);
          if(paymentData?[i].paytypeName==type){

           print("yes");
           print("-----");
            paymentController?[index].text=amount;
          }
        }
        isLoading=false;
        notifyListeners();
      }
    });
  }

  Future<void> setPaymentController(index,amount)async{
    print(amount);
    print(index);
    paymentController?[index]=amount;
    print(paymentController?[index]);
    notifyListeners();
  }

  Future<void> getPaymentType(String type)async{
    paymentType=type;
    // if(type=="Cash"){
    //   cashController.text="122.00";
    //   card1Controller.clear();
    //   card2Controller.clear();
    // }
    // if(type=="Card 1"){
    //   cashController.clear();
    //   card1Controller.text="122.00";
    //   card2Controller.clear();
    // }
    // if(type=="Card 2"){
    //   card1Controller.clear();
    //   cashController.clear();
    //   card2Controller.text="122.00";
    // }
  }
  void showOrHideSplitButton(String type){
    if(type=="Pay later"){
      showSplitButton=false;
    }
   else{
      showSplitButton=true;
    }
   notifyListeners();
  }
  void onSplitBtnPressed(){
      isSplitBtnPressed=true;
      notifyListeners();
  }
}