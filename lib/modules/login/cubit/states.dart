import '../../../../models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessesState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessesState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates {}

///
///
///
// class ShopLoginLoadingHomeDataState extends ShopLoginStates {}
//
// class ShopLoginSuccessHomeDataState extends ShopLoginStates {}
//
// class ShopLoginErrorHomeDataState extends ShopLoginStates {}
//
// class ShopLoginLoadingCategoriesState extends ShopLoginStates {}
//
// class ShopLoginSuccessCategoriesState extends ShopLoginStates {}
//
// class ShopLoginErrorCategoriesState extends ShopLoginStates {}
//
// class ShopLoginLoadingGetFavoritesState extends ShopLoginStates {}
//
// class ShopLoginSuccessGetFavoritesState extends ShopLoginStates {}
//
// class ShopLoginErrorGetFavoritesState extends ShopLoginStates {}
//
// class ShopLoginLoadingUserDataState extends ShopLoginStates {}
//
// class ShopLoginSuccessUserDataState extends ShopLoginStates {}
//
// class ShopLoginErrorUserDataState extends ShopLoginStates {}
