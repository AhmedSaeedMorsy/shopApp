class RigesterModel{
  late bool status ;
  late String message ;
  UserData ? data ;

  RigesterModel.fromjson(Map<String,dynamic> json){
    status = json['status'];
    message =json['message'];
    data = (json['data'] != null ? UserData.fromjson(json['data']): null);

  }


}

class UserData {
  late int id;
  late String name;
  late String email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  late String token;


  UserData.fromjson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];

  }
  
}