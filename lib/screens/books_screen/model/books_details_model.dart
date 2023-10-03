class BooksDetailsModel {
  DataModel? data;
  String? message;
  List<Null>? error;
  int? status;
  bool fav=false;

  BooksDetailsModel({this.data, this.message, this.error, this.status});

  BooksDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
    message = json['message'];
    if (json['error'] != null) {
      error = <Null>[];
      json['error'].forEach((v) {
        error!.add(v);
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    if (this.error != null) {
      data['error'] = this.error!.map((v) => null).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class DataModel {
  int? id;
  String? name;
  String? description;
  int? stock;
  int? bestSeller;
  String? price;
  int? discount;
  int? priceAfterDiscount;
  String? image;
  String? category;
  bool fav=false;

  DataModel(
      {this.id,
        this.name,
        this.description,
        this.stock,
        this.bestSeller,
        this.price,
        this.discount,
        this.priceAfterDiscount,
        this.image,
        this.category});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    stock = json['stock']?.toInt(); // Cast to int
    bestSeller = json['best_seller']?.toInt(); // Cast to int
    price = json['price'];
    discount = json['discount']?.toInt(); // Cast to int
    priceAfterDiscount = json['price_after_discount']?.toInt(); // Cast to int
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['stock'] = this.stock;
    data['best_seller'] = this.bestSeller;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['price_after_discount'] = this.priceAfterDiscount;
    data['image'] = this.image;
    data['category'] = this.category;
    return data;
  }
}