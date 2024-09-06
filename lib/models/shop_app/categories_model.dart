class CategoriesModel {
  late bool status;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  late int currentPage;
  List<CatItemDataModel>? data;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = (json['data'] as List)
        .map((e) => e == null
            ? null
            : CatItemDataModel.fromJson(e as Map<String, dynamic>))
        .cast<CatItemDataModel>()
        .toList();

    //   for (var element in json['data']) {
    //     data!.add(CategoryItemDataModel.fromJson(element));
    // }
  }
}

class CatItemDataModel {
  late int id;
  late String name;
  late String image;

  CatItemDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
