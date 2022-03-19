
import '../../models/favorite_model.dart';
import '../../models/login_model.dart';

abstract class ShopState {}

class ShopInitialState extends ShopState {}

//change current index
class ShopChangeCurrentIndexState extends ShopState {}
class ShopScreenChangeCurrentIndexState extends ShopState {}

//change state icon favorite
class ShopStateFavoriteState extends ShopState {}

//get data home
class ShopDataHomeSuccessState extends ShopState {}

class ShopDataHomeErrorState extends ShopState {}

//get category
class shopCategorySuccessState extends ShopState {}

class shopCategoryErrorState extends ShopState {}

//add product to favorite
class ShopFavoriteErrorState extends ShopState {}

class ShopFavoriteSuccessState extends ShopState {
  FavoriteModel? favoriteModel;
  ShopFavoriteSuccessState(this.favoriteModel);
}

//get all favorites
class shopFavoritesSuccessState extends ShopState {}

class shopFavoritesErrorState extends ShopState {}

//get info profile
class shopProfileSuccessState extends ShopState {
  UserModel? userModel;
  shopProfileSuccessState(this.userModel);
}

class shopProfileErrorState extends ShopState {}

//update info profile
class shopUpdateProfileSuccessState extends ShopState {
  LoginModel? loginModel;
  shopUpdateProfileSuccessState(this.loginModel);
}

class shopUpdateProfileErrorState extends ShopState {}
