class SearchModel{
  late bool  status;
  late DataModel dataModel;

  SearchModel.fromJson(Map <String , dynamic> json){
    status = json["status"];
    dataModel = DataModel.fromJson(json["data"]);
  }

}

class DataModel{
  List <Data> data =[];

  DataModel.fromJson(Map <String ,dynamic>json){
    json["data"].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
  
}

class Data{
  late int id;
  dynamic price;
  late String image;
  late String name;

  Data.fromJson(Map <String, dynamic> json){
    id = json["id"];
    price =json["price"];
    image = json["image"];
    name = json["name"];
  }
 
}