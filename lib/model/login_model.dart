class LoginModel{
  late bool status ;
  String ? message ;
  UserData ? data ;

  LoginModel.fromjson(Map<String,dynamic> json){
    status = json['status'];
    message =json['message'];
    data = (json['data'] != null ? UserData.fromjson(json['data']): null);

  }


}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  String? image;
  int? points;
  int? credit;
  String ? token;


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