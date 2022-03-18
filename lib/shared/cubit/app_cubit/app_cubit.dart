import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/cubit/app_cubit/app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super( AppInitState());

}