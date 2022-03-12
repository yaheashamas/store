import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/modules/shop_login/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../shared/endPoint/EndPont.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  //var
  String? mesSuccess;
  bool isSecure = true;
  IconData iconSuffix = Icons.remove_red_eye;
  late LoginModel loginModel;

  //function
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.putData(
      url: LOGIN,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error);
      emit(ShopLoginErrorState(error: error));
    });
  }

  void changeStateSecure() {
    isSecure = !isSecure;
    isSecure
        ? iconSuffix = Icons.remove_red_eye
        : iconSuffix = Icons.visibility_off_rounded;
    emit(ShopLoginSecureInputState());
  }
}
