// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/search_model.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/cubit/app_cubit/search_cubit/states.dart';
import 'package:shopapp/shared/end_points.dart';
import 'package:shopapp/shared/network/remote/dio.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitState());

  static SearchCubit get(context)=> BlocProvider.of(context);

  late SearchModel searchModel;

  void searchData(
    {
      required String text,
    }
  ){
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {
      "text":text
    },token: token).then((value){
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });
  }
  
}