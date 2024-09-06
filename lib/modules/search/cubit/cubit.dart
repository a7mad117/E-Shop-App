import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/states.dart';

import '../../../../shared/network/end_points.dart';
import '../../../models/shop_app/search_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {'text': text})
        .then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(SearchErrorState());
    });
  }
}
