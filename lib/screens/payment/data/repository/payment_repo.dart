import 'package:billing_app/network/base_url.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class PaymentRepository{
  Future<http.Response> getPaymentData(token)async{
    return http.get(Uri.parse("${BaseUrl.getPaymentUrl}&token=${token}"));
  }
}
