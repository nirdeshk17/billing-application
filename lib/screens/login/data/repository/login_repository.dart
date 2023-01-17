import 'package:billing_app/network/base_url.dart';
import 'package:http/http.dart' as http;

class LoginRepository{
Future<http.Response> getLoginData(userName,password)async{
  return http.get(Uri.parse("${BaseUrl.loginUrl}&user_name=${userName}&password=${password}"));
}
}