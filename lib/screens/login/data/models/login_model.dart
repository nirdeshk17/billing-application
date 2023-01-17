class LoginResModel{
  String ? status;
  String? message;
  LoginData? data;
  LoginResModel({
    this.message,
    this.status,
    this.data,
});
  LoginResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["msg"];
    if(json["data"]!=null){
    data=LoginData.fromJson(json["data"]);
    }
  }
}
class LoginData{
 String? name;
 String ? id;
 String ? licence;
 String ? branch;
 String ? location;
 LoginData({
   this.branch,
   this.id,
   this.licence,
   this.location,
   this.name,
});
 LoginData.fromJson(Map<String,dynamic>json){
  name=json["name"];
  id=json["id"];
  licence=json["license"];
  branch=json["branch"];
  location=json["location"];
 }
}