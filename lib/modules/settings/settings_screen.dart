import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BuildCondition(
      condition: cubit.userModel?.status != null,
      fallback: (context) => const Center(child: CircularProgressIndicator()),
      builder: (context) => BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          nameController.text = cubit.userModel!.data!.name!;
          emailController.text = cubit.userModel!.data!.email!;
          phoneController.text = cubit.userModel!.data!.phone!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      textInputType: TextInputType.name,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      labelText: 'Name',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      labelText: 'Phone',
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      // width: 140,
                      //   radius: 10,
                      function: () {
                        signOut(context);
                        cubit.currentIndex = 0;
                      },
                      text: 'Logout',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      // width: 140,
                      //   radius: 10,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          cubit.updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text);
                        }
                      },

                      text: 'UPDATE',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
