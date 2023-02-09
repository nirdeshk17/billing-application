import 'dart:convert';
import 'dart:io';
import 'package:billing_app/network/base_url.dart';
import 'package:http/http.dart' as http;
class HomeRepository{

     getItemData(token)async {
    var uri=Uri.parse("${BaseUrl.getItemsUrl}&token=${token}");
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(uri);
    HttpClientResponse response = await request.close();
    var reply = await response.transform(utf8.decoder).join();
    return reply;
  }


     getPartyData(token)async{
      var uri=Uri.parse("${BaseUrl.getPartyUrl}&token=${token}");
      print(uri);
      HttpClient client = new HttpClient();
      client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
      HttpClientRequest request = await client.postUrl(uri);
      HttpClientResponse response = await request.close();
      var reply = await response.transform(utf8.decoder).join();
      return reply;
    }

   getGroupData(token)async{
    var uri=Uri.parse("${BaseUrl.getGroupUrl}&token=${token}");
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(uri);
    HttpClientResponse response = await request.close();
    var reply = await response.transform(utf8.decoder).join();
    return reply;
  }

}