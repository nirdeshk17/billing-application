import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:billing_app/screens/payment/data/payment_model.dart';
import 'package:billing_app/screens/payment/data/repository/payment_repo.dart';
import 'package:flutter/cupertino.dart';

class PaymentController extends ChangeNotifier{
  PaymentRepository _paymentRepository=PaymentRepository();
  String? status;
  String? message;
  List<PaymentData>? paymentData;
  bool ? isLoading;
  Future<void> initState(context)async{

 await getPayment();

  }
  Future<void> getPayment()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isLoading=true;
    _paymentRepository.getPaymentData(pref.getString("LICENCE")).then((response){
      if (response.statusCode == 200){
        final result = jsonDecode(response.body);
        final data = PaymentResModel.fromJson(result);
        status=data.status;
        message=data.message;
        paymentData=data.data;
        isLoading=false;
notifyListeners();
      }
    });

  }
}