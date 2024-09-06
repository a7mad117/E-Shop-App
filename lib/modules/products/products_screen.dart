import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../shared/components/components.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/shop_app/home_model.dart';
import '../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model.status) {
            showBriefMsg(
                isShowSnackBar: true,
                context: context,
                state: BriefMsg.ERROR,
                msg: 'Not Authorized');
          }
        }
        if (state is ShopErrorChangeFavoritesState) {
          if (!state.model.status) {
            showBriefMsg(
                isShowSnackBar: true,
                context: context,
                state: BriefMsg.ERROR,
                msg: 'Error');
          }
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return BuildCondition(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => homeBuilder(
                  cubit.homeModel,
                  cubit.categoriesModel,
                  cubit,
                ));
      },
    );
  }

  Widget homeBuilder(HomeModel? model, CategoriesModel? categoriesModel,
          ShopCubit cubit) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data!.banners!
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoriesItem(
                          categoriesModel!.data.data![index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: categoriesModel!.data.data!.length,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.573,
                children: List.generate(
                  model.data!.products!.length,
                  (index) =>
                      buildGridProduct(model.data!.products![index], cubit),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItem(CatItemDataModel? model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model!.image),
            width: 140,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
              width: 140,
              color: Colors.black.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  model.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              )),
        ],
      );

  Widget buildGridProduct(ProductModel model, ShopCubit cubit) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'SALES',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        model.price.round().toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.oldPrice.round().toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            cubit.changeFavorites(model.id);
                            debugPrint(model.id.toString());
                          },
                          icon: CircleAvatar(
                            backgroundColor: cubit.favorites[model.id] ?? false
                                ? defaultColor
                                : Colors.grey,
                            radius: 15,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 14,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
