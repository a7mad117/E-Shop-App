import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

///
///Login Code
///
class ShopLoginInitialState extends ShopStates {}

class ShopLoginLoadingState extends ShopStates {}

class ShopLoginSuccessesState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessesState(this.loginModel);
}

class ShopLoginErrorState extends ShopStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopStates {}

///
/// Home page Code
///
class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopErrorChangeFavoritesState(this.model);
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}
