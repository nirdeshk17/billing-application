import 'dart:io';
import 'package:billing_app/network/base_url.dart';
import 'package:http/http.dart' as http;
class HomeRepository{
  Future <http.Response> getItemData(token)async {
    print("${BaseUrl.getItemsUrl}&token=${token}");
    return http.get(Uri.parse("${BaseUrl.getItemsUrl}&token=${token}"));
  }
    Future<http.Response> getPartyData(token)async{
     print("${BaseUrl.getPartyUrl}&token=${token}");
    return http.get(Uri.parse("${BaseUrl.getPartyUrl}&token=${token}"));
    }
}