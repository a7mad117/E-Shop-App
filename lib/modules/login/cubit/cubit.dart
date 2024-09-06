import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/end_points.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

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

//
//   ///
// ///
//   HomeModel? homeModel;
//
//   Map<int, bool> favorites = {};
//
//   void getHomeData() {
//     emit(ShopLoginLoadingHomeDataState());
//     DioHelper.getData(url: HOME, token: token).then((value) {
//       homeModel = HomeModel.fromJson(value.data);
//
//       for (var element in homeModel!.data!.products!) {
//         favorites.addAll({element.id: element.inFavorites});
//       }
//       // printFullText(favorites.toString());
//
//       emit(ShopLoginSuccessHomeDataState());
//     }).catchError((error) {
//       printFullText(error.toString());
//       emit(ShopLoginErrorHomeDataState());
//     });
//   }
//
//   CategoriesModel? categoriesModel;
//
//   void getCategoriesData() {
//     DioHelper.getData(url: GET_CATEGORIES).then((value) {
//       categoriesModel = CategoriesModel.fromJson(value.data);
//       emit(ShopLoginSuccessCategoriesState());
//     }).catchError((error) {
//       printFullText(error.toString());
//       emit(ShopLoginErrorCategoriesState());
//     });
//   }
//
//   FavoritesModel? favoritesModel;
//
//   void getFavorites() {
//     emit(ShopLoginLoadingGetFavoritesState());
//
//     DioHelper.getData(url: FAVORITES, token: token).then((value) {
//       favoritesModel = FavoritesModel.fromJson(value.data);
//       emit(ShopLoginSuccessGetFavoritesState());
//     }).catchError((error) {
//       printFullText(error.toString());
//       emit(ShopLoginErrorGetFavoritesState());
//     });
//   }
//
//   ShopLoginModel? userModel;
//
//   void getUserData() {
//     emit(ShopLoginLoadingUserDataState());
//
//     DioHelper.getData(url: PROFILE, token: token).then((value) {
//       userModel = ShopLoginModel.fromJson(value.data);
//       // printFullText(userModel.data.name);
//       emit(ShopLoginSuccessUserDataState());
//     }).catchError((error) {
//       printFullText(error.toString());
//       emit(ShopLoginErrorUserDataState());
//     });
//   }

}
