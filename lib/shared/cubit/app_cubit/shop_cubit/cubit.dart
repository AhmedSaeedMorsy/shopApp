// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/categories_model.dart';
import 'package:shopapp/model/change_favorites_mode.dart';
import 'package:shopapp/model/favorites_model.dart';
import 'package:shopapp/model/home_model.dart';
import 'package:shopapp/model/profile_model.dart';
import 'package:shopapp/modules/categories/categories.dart';
import 'package:shopapp/modules/favorites/favorites.dart';
import 'package:shopapp/modules/products/products.dart';
import 'package:shopapp/modules/settings/settings.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/satates.dart';
import 'package:shopapp/shared/network/remote/dio.dart';
import 'package:shopapp/shared/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomnavItem =  [
    const Products(),
    const Categories(),
    const Favorites(),
    Settings(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    if(currentIndex == 0)
    {
     getHomeData();
    }else if(currentIndex == 1){
      getCategoriesData();
    }else if(currentIndex== 2){
      getFavorites();
    }
    emit(ChangeBottonNavigateIndex());
    
  }

  HomeModel? homeModel;
  Map<int?, dynamic> favoritesProduct = {};

  void getHomeData() {
    emit(HomeLoadingDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then(
      (value) {
        homeModel = HomeModel.fromjson(value.data);
        print(homeModel!.status);
        homeModel!.data.products.forEach(
          (elemnt) {
            favoritesProduct.addAll(
              {
                elemnt.id: elemnt.inFavorites,
              },
            );
          },
        );
        print(favoritesProduct.toString());

        emit(HomeSuccessDataState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(HomeErrorDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);
      print(categoriesModel!.status);
      emit(CategoriesDataSuccessState());
    }).catchError((error) {
      print(error.toString);
      emit(CategoriesDataErrorState());
    });
  }

  late ChangeFavoratiesModel changeFavoratiesModel;
  void changeFavorites(int productId) {
    favoritesProduct[productId] = !favoritesProduct[productId];
    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {"product_id": productId},
    ).then((value) {
      changeFavoratiesModel = ChangeFavoratiesModel.fromJson(value.data);
      if (changeFavoratiesModel.status == false) {
        favoritesProduct[productId] = !favoritesProduct[productId];
      } else {
        getFavorites();
      }
      emit(ChangeFavoritesSccessState());
    }).catchError((error) {
      favoritesProduct[productId] = !favoritesProduct[productId];
      print(error.toString());
      emit(ChangeFavoritesErrorState(error.toString()));
    });
  }

  FavoritesModel ? favoritesModel;
  void getFavorites() {
    emit(FavoritesDataLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      
      favoritesModel = FavoritesModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(FavoritesDataErrorState(error.toString()));
    });
  }

  late ProfileModel profileModel;

  void getProfileData(){
    emit(ProfileDataLoadingState());
    DioHelper.getData(url: PROFILE,token: token).then((value){
      profileModel = ProfileModel.fromjson(value.data);
      print(profileModel.status);
      emit(ProfileDataSuccessState(profileModel));
    }).catchError((error){
      print(error.toString());
      emit(ProfileDataErrorState(error.toString()));
    });
  }

  void updateProfileData(
    {
      required String name,
      required String email,
      required String phone,

    }
  ){
    emit(UpdateProfileDataLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE,token: token,data: {
      "name" : name,
      "email": email,
      "phone": phone,
    }).then((value){
      profileModel = ProfileModel.fromjson(value.data);
      print(profileModel.status);
      emit(UpdateProfileDataSuccessState(profileModel));
    }).catchError((error){
      print(error.toString());
      emit(UpdateProfileDataErrorState(error.toString()));
    });
  }

}
