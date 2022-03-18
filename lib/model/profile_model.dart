class ProfileModel{
  late bool status ;

  UserData ? data ;

  ProfileModel.fromjson(Map<String,dynamic> json){
    status = json['status'];
    data = (json['data'] != null ? UserData.fromjson(json['data']): null);

  }


}

class UserData {

  late String name;
  late String email;
  late String phone;


  UserData.fromjson(Map<String,dynamic> json){

    name = json['name'];
    email = json['email'];
    phone = json['phone'];
   

  }
  
}