
class FavoritesModel{
  late bool status ;
  late DataModel data;
  FavoritesModel.fromJson(Map <String,dynamic>json){
    status = json["status"];
    data = DataModel.fromJson(json["data"]);
  }


}

class DataModel{
  List <Data>  data = [];
  DataModel.fromJson(Map <String , dynamic> json){
    json["data"].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
}

class Data{
  late int id ; 
  late Product product;
  Data.fromJson(Map <String , dynamic> json){

    id = json["id"];
    product = Product.fromJson(json["product"]);

  }
}
class Product{
  late int id;
  dynamic price;
  dynamic oldPrice;
  int ? discount;
  late String image;
  late String name;
  Product.fromJson(Map <String , dynamic> json){
    id = json["id"];
    price = json["price"];
    oldPrice =json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
  }
}