// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/login_model.dart';
import 'package:shopapp/model/rigester_model.dart';
import 'package:shopapp/shared/cubit/app_cubit/login_cubit/states.dart';
import 'package:shopapp/shared/network/remote/dio.dart';
import 'package:shopapp/shared/end_points.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitState());

  static LoginCubit get(context)=> BlocProvider.of(context);

  bool isShown = true;
  late LoginModel loginModel;
  Icon suffix = const Icon(Icons.visibility_off_outlined);
  void changeVisibilityPassword(){
    isShown = !isShown;
    suffix = isShown ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined);
    emit(ChangeVisibilityPasswordState());
  }
  void userLogin(
    {
      required String email,
      required String password,
    }
  ){
    emit(UserLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email':email,
      'password':password
    },).then((value){

      loginModel = LoginModel.fromjson(value.data);
      print(loginModel.status);
      print(loginModel.message);
      emit(UserLoginSuccessState());



    }).catchError((error){
      print(error.toString());
      emit(UserLoginErrorState(error.toString()));
    });
  }

  RigesterModel ? userData ;

  void userRigester({
    required String name,
    required String phone,
    required String email,
    required String password,

  }){
    emit(RigesterDataLoadingState());
    DioHelper.postData(url: RIGESTER, data:{
      "name" : name, 
      "phone":phone,
      "email":email,
      "password":password

    } ).then((value){
      userData = RigesterModel.fromjson(value.data);
      emit(RigesterDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(RigesterDataErrorState(error.toString()));
    });
  }


}