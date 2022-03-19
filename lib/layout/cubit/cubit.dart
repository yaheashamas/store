import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/layout/cubit/states.dart';
import 'package:store/models/category_model.dart';
import 'package:store/models/favorite_model.dart';
import 'package:store/models/favorites_model.dart';
import 'package:store/models/home_model.dart';
import 'package:store/models/login_model.dart';
import 'package:store/modules/shop_login/login.dart';
import 'package:store/modules/shop_products/Product.dart';
import 'package:store/shared/components/components.dart';
import 'package:store/shared/network/local/cashe_helper.dart';

import '../../modules/shop_categores/Category.dart';
import '../../modules/shop_favorates/Favorate.dart';
import '../../modules/shop_settings/Setting.dart';
import '../../shared/components/constants.dart';
import '../../shared/endPoint/EndPont.dart';
import '../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  //models
  HomeModel? homeModel;
  FavoriteModel? favoriteModel;
  CategoryModel? categoryModel;
  FavoritesModel? favoritesModel;
  UserModel? userModel;
  LoginModel? loginModel;

  //var
  int currentIndex = 0;
  var mapIsFavorite = {};
  bool stateFavoriteIcon = false;
  List<Widget> widgets = [
    Product(),
    Category(),
    Favorite(),
    Setting(),
  ];

  //function
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ShopChangeCurrentIndexState());
  }

  void changeScreen() {
    if (currentIndex == 1) {
      getCategory();
    } else if (currentIndex == 2) {
      getFavorites();
    } else if (currentIndex == 3) {
      getInfoProfile();
    }
    emit(ShopScreenChangeCurrentIndexState());
  }

  getDataHome() {
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        mapIsFavorite.addAll({
          element.id: element.in_favorites,
        });
      });
      emit(ShopDataHomeSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopDataHomeErrorState());
    });
  }

  getCategory() {
    DioHelper.getData(
      url: CATEGORY,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(shopCategorySuccessState());
    }).catchError((error) {
      print(error);
      emit(shopCategoryErrorState());
    });
  }

  AddFavoriteProduct({
    required int idProduct,
  }) {
    mapIsFavorite[idProduct] = !mapIsFavorite[idProduct];
    emit(ShopStateFavoriteState());

    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        "product_id": idProduct,
      },
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      if (!favoriteModel!.status) {
        mapIsFavorite[idProduct] = !mapIsFavorite[idProduct];
      } else {
        getFavorites();
      }
      emit(ShopFavoriteSuccessState(favoriteModel));
    }).catchError((error) {
      emit(ShopFavoriteErrorState());
    });
  }

  getFavorites() {
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(shopFavoritesSuccessState());
    }).catchError((error) {
      print(error);
      emit(shopFavoritesErrorState());
    });
  }

  getInfoProfile() {
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = UserModel.fromJson(value.data['data']);
      emit(shopProfileSuccessState(userModel));
    }).catchError((error) {
      emit(shopProfileErrorState());
    });
  }

  updateInfoUser({
    required String name,
    required String email,
    required String phone,
  }) {
    DioHelper.putData(
      url: UPDATE,
      data: {"name": name, "email": email, "phone": phone},
      token: token,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(shopUpdateProfileSuccessState(loginModel));
    }).catchError((error) {
      emit(shopUpdateProfileErrorState());
    });
  }

  void logOut(context) {
    print("remove token => logout => ${token}");
    CacheHelper.removeData(key: token).then((value) {
      token = "";
      navigateToRemove(
        context: context,
        Widget: LoginShop(),
      );
      currentIndex = 0;
    });
  }
}
