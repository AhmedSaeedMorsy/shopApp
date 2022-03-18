abstract class LoginStates {}

class LoginInitState extends LoginStates{}

class ChangeVisibilityPasswordState extends LoginStates{}

class UserLoginLoadingState extends LoginStates{}

class UserLoginSuccessState extends LoginStates{}

class UserLoginErrorState extends LoginStates{
  final String error;
  UserLoginErrorState(this.error);
}

class RigesterDataLoadingState extends LoginStates{}

class RigesterDataSuccessState extends LoginStates{}

class RigesterDataErrorState extends LoginStates{
  final String error;

  RigesterDataErrorState(this.error);
}