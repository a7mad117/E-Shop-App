import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../login/shop_login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessesState) {
            if (state.loginModel.status!) {
              showBriefMsg(
                isShowSnackBar: true,
                context: context,
                msg: state.loginModel.message.toString(),
                state: BriefMsg.SUCCESS,
              );
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;

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
          } else if (state is ShopRegisterErrorState) {
            showBriefMsg(
              isShowSnackBar: true,
              context: context,
              msg: "  Error  ",
              state: BriefMsg.ERROR,
            );
          }
        },
        builder: (context, state) {
          ShopRegisterCubit cubit = ShopRegisterCubit.get(context);
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
                          'Register'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: nameController,
                            textInputType: TextInputType.text,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            labelText: 'Name',
                            prefixIcon: Icons.perm_identity_outlined),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            textInputType: TextInputType.phone,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Phone';
                              }
                              return null;
                            },
                            labelText: 'Phone',
                            prefixIcon: Icons.phone),
                        const SizedBox(
                          height: 15,
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
                            // if (formKey.currentState!.validate()) {
                            //   cubit.userRegister(
                            //     email: emailController.text,
                            //     password: passwordController.text,
                            //     name: nameController.text,
                            //     phone: phoneController.text,
                            //   );
                            // }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BuildCondition(
                          condition: state is! ShopRegisterLoadingState,
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                            text: 'Register',
                            isUpperCase: true,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
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
                            const Text("Do you have an account?"),
                            defaultTextButton(
                              text: 'login',
                              onPressed: () {
                                navigateAndFinish(context, ShopLoginScreen());
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
      ),
    );
  }
}
