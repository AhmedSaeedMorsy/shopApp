// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/home_layout.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/modules/onBoardin_screen/on_boarding_screen.dart';
import 'package:shopapp/shared/bloc_observer.dart';
import 'package:shopapp/shared/constant.dart';
import 'package:shopapp/shared/cubit/app_cubit/app_cubit.dart';
import 'package:shopapp/shared/cubit/app_cubit/app_states.dart';
import 'package:shopapp/shared/cubit/app_cubit/login_cubit/cubit.dart';
import 'package:shopapp/shared/cubit/app_cubit/shop_cubit/cubit.dart';
import 'package:shopapp/shared/network/local/shared_pref.dart';
import 'package:shopapp/shared/network/remote/dio.dart';
import 'package:shopapp/shared/style/theme.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      ShopCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget widget;
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeLayOut();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScren();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavorites()
            ..getProfileData(),
        ),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => AppCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            home: widget,
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
