class ItemsResModel {
  String? status;
  List<itmData>? data;
  String? message;

  ItemsResModel({
    this.data,
    this.status,
    this.message,
  });

  ItemsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    if (json["data"] != null) {
      data = <itmData>[];
      json["data"].forEach((v) {
        data?.add(itmData.fromJson(v));
      });
    }
    message = json["msg"];
  }
}

class itmData {
  String? itmId;
  String? itmName;

  itmData({
    this.itmId,
    this.itmName,
  });

  itmData.fromJson(Map<String, dynamic> json) {
    itmId = json["itm_id"];
    itmName = json["itm_name"];
  }
}

class PartyResModel {
  String? status;
  List<PartyData>? data;
  String? message;

  PartyResModel({
    this.status,
    this.data,
    this.message,
  });

  PartyResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["msg"];
    if (json["data"] != null) {
      data = <PartyData>[];
      json["data"].forEach((v) {
        data?.add(PartyData.fromJson(v));
      });
    }
  }
}

class PartyData {
  String? partyId;
  String? partyName;
  String? primaryAddress;
  String? gstin;

  PartyData({this.gstin, this.partyId, this.partyName, this.primaryAddress});

  PartyData.fromJson(Map<String, dynamic> json) {
    partyId = json["party_id"];
    partyName = json["party_name"];
    primaryAddress = json["primary_address"];
    gstin = json["party_gstin"];
  }
}
