import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/constants.dart';
import '../register/shop_register_screen.dart';

// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopLoginSuccessesState) {
          if (state.loginModel.status!) {
            showBriefMsg(
              isShowSnackBar: true,
              context: context,
              msg: state.loginModel.message.toString(),
              state: BriefMsg.SUCCESS,
            );
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data?.token)
                .then((value) {
              token = state.loginModel.data?.token;

              /// Changes
              ShopCubit.get(context).getFavorites();
              ShopCubit.get(context).getHomeData();
              ShopCubit.get(context).getCategoriesData();
              ShopCubit.get(context).getUserData();

              navigateAndFinish(context, const ShopLayout());
            });
          } else {
            showBriefMsg(
              isShowSnackBar: true,
              context: context,
              msg: state.loginModel.message.toString(),
              state: BriefMsg.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          labelText: 'Email address',
                          prefixIcon: Icons.email_outlined),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        labelText: 'Password',
                        prefixIcon: Icons.lock,
                        isPassword: cubit.isPassword,
                        suffixIcon: cubit.suffixIcon,
                        suffixPress: () {
                          cubit.changePasswordVisibility();
                        },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BuildCondition(
                        condition: state is! ShopLoginLoadingState,
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        builder: (context) => defaultButton(
                          text: 'LOGIN',
                          isUpperCase: true,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          defaultTextButton(
                            text: 'Register',
                            onPressed: () {
                              ShopCubit.get(context).getFavorites();
                              navigateAndFinish(context, ShopRegisterScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
