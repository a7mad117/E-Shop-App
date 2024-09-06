import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('salla'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(Icons.search),
                  tooltip: 'search'),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            type: BottomNavigationBarType.fixed,
            items: cubit.bottomNavigationBarItems,
            onTap: (int index) {
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
