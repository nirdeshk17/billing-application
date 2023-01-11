class PaymentResModel {
  String? status;
  String? message;
  List<PaymentData>? data;

  PaymentResModel({
    this.status,
    this.message,
    this.data,
  });

  PaymentResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["msg"];
    if (json["data"] != null) {
      data = <PaymentData>[];
      json["data"].forEach((v) {
        data?.add(PaymentData.fromJson(v));
      });
    }
  }
}

class PaymentData {
  String? paytypeId;
  String? paytypeName;
  PaymentData({this.paytypeId, this.paytypeName});
  PaymentData.fromJson(Map<String, dynamic> json) {
    paytypeId = json["paytype_id"];
    paytypeName = json["paytype_name"];
  }
}
