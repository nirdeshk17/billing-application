import 'dart:convert';
import 'dart:io';

import 'package:billing_app/network/base_url.dart';
import 'package:http/http.dart' as http;
class ItemRateRepository {
 getItemRate(token,id) async {

    var uri=Uri.parse("${BaseUrl.getRateUrl}&token=${token}&itm_id=${id}");
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(uri);
    HttpClientResponse response = await request.close();
    var reply = await response.transform(utf8.decoder).join();
    return reply;
  }
}