import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/modules/shop_register/cubit/states.dart';
import 'package:store/shared/endPoint/EndPont.dart';
import 'package:store/shared/network/remote/dio_helper.dart';

import '../../../models/login_model.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  //var
  String? mesSuccess;
  bool isSecure = true;
  IconData iconSuffix = Icons.remove_red_eye;
  late LoginModel loginModel;

  //function
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.putData(
      url: REGISTER,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error);
      emit(ShopRegisterErrorState(error: error));
    });
  }

  void changeStateSecure() {
    isSecure = !isSecure;
    isSecure
        ? iconSuffix = Icons.remove_red_eye
        : iconSuffix = Icons.visibility_off_rounded;
    emit(ShopRegisterSecureInputState());
  }
}
