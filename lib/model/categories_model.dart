class CategoriesModel{
  late bool status;
  late CategoriesDataModel  data;

  CategoriesModel.fromjson(Map <String ,dynamic> json){
    status = json["status"];
    data = CategoriesDataModel.formJson(json["data"]);
  }
}

class CategoriesDataModel{
  late int  currentPage ;
  List <DataModel> data =[] ;

  CategoriesDataModel.formJson(Map <String ,dynamic> json){
    currentPage = json["current_page"];
    json["data"].forEach((element){
      data.add(DataModel.formJson(element));
    });
  }

}

class DataModel{
  late int id;
  late String name;
  late String image;
  DataModel.formJson(Map <String ,dynamic> json){
    id =json["id"];
    name =json["name"];
    image =json["image"];
  }
}