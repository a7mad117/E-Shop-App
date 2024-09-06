import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
          itemBuilder: (context, index) =>
              buildCatItem(cubit.categoriesModel!.data.data![index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: cubit.categoriesModel!.data.data!.length,
        );
      },
    );
  }

  Widget buildCatItem(CatItemDataModel model) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                model.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
              )
            ],
          ),
        ),
      );
}
