import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/cubit/cubit.dart';
import 'package:shop_app/shared/components/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark') ?? false;

  Widget startWidget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  debugPrint(token);

  if (onBoarding != null) {
    if (token != null) {
      startWidget = const ShopLayout();
    } else {
      startWidget = ShopLoginScreen();
    }
  } else {
    startWidget = const OnBoardingScreen();
  }

  Bloc.observer = MyBlocObserver();
   // Use cubits...
  runApp(MyApp(
    isDark: isDark,
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isDark, required this.startWidget})
      : super(key: key);

  final Widget startWidget;
  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeThemeMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getUserData()
            ..getFavorites()
            ..getHomeData()
            ..getCategoriesData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode: ThemeMode.light,
            // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
