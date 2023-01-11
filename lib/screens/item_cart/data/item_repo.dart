import 'package:billing_app/network/base_url.dart';
import 'package:http/http.dart' as http;
class ItemRateRepository {
  Future <http.Response> getItemRate(token,id) async {
    print("${BaseUrl.getRateUrl}&token=${token}&itm_id=${id}");
    return http.get(Uri.parse("${BaseUrl.getRateUrl}&token=${token}&itm_id=${id}"));
  }
}