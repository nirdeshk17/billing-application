import 'dart:convert';
import 'dart:io';

import 'package:billing_app/network/base_url.dart';
import 'package:http/http.dart' as http;

class LoginRepository{
 getLoginData(userName,password)async{
   var uri=Uri.parse("${BaseUrl.loginUrl}&user_name=${userName}&password=${password}");
   print(uri);
   // syut_demo_user     syut_demo
   HttpClient client = new HttpClient();
   client.badCertificateCallback =
   ((X509Certificate cert, String host, int port) => true);
   HttpClientRequest request = await client.postUrl(uri);
   HttpClientResponse response = await request.close();
   var reply = await response.transform(utf8.decoder).join();
   print(reply);
   return reply;
}
}