import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/local/cache_helper.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemeModeState());
      });
    }
  }
}
