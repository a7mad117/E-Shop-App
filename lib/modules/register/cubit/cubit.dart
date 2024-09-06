import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    required String? name,
    required String? phone,
    required String? email,
    required String? password,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
    ).then((value) {
      debugPrint(value.data.toString());
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessesState(loginModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    emit(ShopRegisterChangePasswordVisibilityState());

    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  }
}
