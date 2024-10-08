import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return BuildCondition(
          condition: state is! ShopLoadingGetFavoritesState,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListProducts(
                cubit.favoritesModel!.data.data[index].product, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.favoritesModel!.data.data.length,
          ),
        );
      },
    );
  }
}
