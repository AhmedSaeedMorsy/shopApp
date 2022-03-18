class ChangeFavoratiesModel{
  late bool status;
  late String message;
  ChangeFavoratiesModel.fromJson(Map <String,dynamic> json){
    status = json["status"];
    message = json["message"];
  }
}