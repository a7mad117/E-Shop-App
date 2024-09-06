import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../shared/components/constants.dart';
import '../../models/shop_app/home_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';
import 'states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  ///
  ///Login Code
  ///
  ShopLoginModel? loginModel;

  void userLogin({
    required String? email,
    required String? password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      // debugPrint(value.data.toString());
      loginModel = ShopLoginModel.fromJson(value.data);
      debugPrint(loginModel!.status.toString());
      debugPrint(loginModel!.message.toString());
      debugPrint(loginModel?.data?.token.toString());
      emit(ShopLoginSuccessesState(loginModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    emit(ShopChangePasswordVisibilityState());

    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  }

  ///
  /// Home page Code
  ///
  int currentIndex = 0;
  List<String> screenTitles = [
    'Products Screen',
    'Categories Screen',
    'Favorites Screen',
    'Settings Screen',
  ];
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Products'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favorites'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel!.data!.products!) {
        favorites.addAll({element.id: element.inFavorites});
      }
      // printFullText(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !(favorites[productId] ?? false);
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // printFullText(value.data.toString());
      if (!changeFavoritesModel.status) {
        favorites[productId] = !(favorites[productId] ?? false);
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      printFullText(error.toString());
      if (!changeFavoritesModel.status) {
        favorites[productId] = !(favorites[productId] ?? false);
      }
      emit(ShopErrorChangeFavoritesState(changeFavoritesModel));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(userModel.data.name);
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(userModel.data.name);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
