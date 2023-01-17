class itemRateResModel{
  String? status;
  String ? message;
  List<RateData>? data;
  itemRateResModel({
    this.status,
    this.message,
    this.data,
});
  itemRateResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["msg"];
    if (json["data"] != null) {
      data = <RateData>[];
      json["data"].forEach((v) {
        data?.add(RateData.fromJson(v));
      });
    }
  }
}
class RateData {
  String? incRate;
  RateData({this.incRate});
  RateData.fromJson(Map<String, dynamic> json) {
    incRate = json["inc_rate"];
  }
}