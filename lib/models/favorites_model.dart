class FavoritesModel {
  bool? status;
  DataProduct? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataProduct.fromJson(json['data']);
  }
}

class DataProduct {
  List<Products> product = [];
  DataProduct.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      product.add(Products.fromJson(element['product']));
    });
  }
}

class Products {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
