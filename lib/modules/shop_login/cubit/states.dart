
import '../../../models/login_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

//login
class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  LoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState {
  final String? error;
  ShopLoginErrorState({this.error});
}

//change state secure input password
class ShopLoginSecureInputState extends ShopLoginState {}
