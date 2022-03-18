
import 'package:shopapp/model/profile_model.dart';

abstract class ShopStates {}

class ShopInitState extends ShopStates{}

class ChangeBottonNavigateIndex extends ShopStates{}

class HomeLoadingDataState extends ShopStates{}

class HomeSuccessDataState extends ShopStates{}

class HomeErrorDataState extends ShopStates{
  final String error;
  HomeErrorDataState(this.error);
}

class CategoriesDataSuccessState extends ShopStates{}

class CategoriesDataErrorState extends ShopStates{}

class ChangeFavoritesSccessState extends ShopStates{}

class ChangeFavoritesErrorState extends ShopStates{
  final String error;

  ChangeFavoritesErrorState(this.error);
  
}

class FavoritesDataLoadingState extends ShopStates{}

class FavoritesDataSuccessState extends ShopStates{}

class FavoritesDataErrorState extends ShopStates{
  final String error;

  FavoritesDataErrorState(this.error);
}

class ProfileDataLoadingState extends ShopStates{}

class ProfileDataSuccessState extends ShopStates{
  final ProfileModel profileModel;

  ProfileDataSuccessState(this.profileModel);
}

class ProfileDataErrorState extends ShopStates{
  final String error;

  ProfileDataErrorState(this.error);
}

class UpdateProfileDataLoadingState extends ShopStates{}

class UpdateProfileDataSuccessState extends ShopStates{
   final ProfileModel profileModel;

  UpdateProfileDataSuccessState(this.profileModel);
  
}

class UpdateProfileDataErrorState extends ShopStates{
  final String error;

  UpdateProfileDataErrorState(this.error);
}

