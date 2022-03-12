
import 'package:store/models/login_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState {}

//login
class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState {
  LoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterState {
  final String? error;
  ShopRegisterErrorState({this.error});
}

//change state secure input password
class ShopRegisterSecureInputState extends ShopRegisterState {}
