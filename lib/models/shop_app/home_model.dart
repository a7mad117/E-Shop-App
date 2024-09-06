class HomeModel {
  late bool? status;
  late HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel>? banners;

  List<ProductModel>? products;

// HomeDataModel.fromJson(Map<String, dynamic> json) {
//   for (var element in json['banners']) {
//     banners.add(CategoryItemDataModel.fromJson(element));
//   }
//
//   for (var element in json['products']) {
//     products.add(CategoryItemDataModel.fromJson(element));
//   }
// }
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    banners = (json['banners'] as List)
        .map((e) =>
            e == null ? null : BannerModel.fromJson(e as Map<String, dynamic>))
        .cast<BannerModel>()
        .toList();
    products = (json['products'] as List)
        .map((e) =>
            e == null ? null : ProductModel.fromJson(e as Map<String, dynamic>))
        .cast<ProductModel>()
        .toList();
  }

// ad = json['ad'];
}

class BannerModel {
  late int id;
  late String image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  late bool inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
