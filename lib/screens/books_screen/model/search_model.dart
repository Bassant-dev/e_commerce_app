

class SearchModel {
  Data? data;
  String? message;
  List<Null>? error;
  int? status;

  SearchModel({this.data, this.message, this.error, this.status});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      error: json['error'] != null
          ? List<Null>.from(json['error'].map((x) => x))
          : null,
      status: json['status'],
    );
  }
}

class Data {
  List<Null>? products;
  Meta? meta;
  Links? links;

  Data({this.products, this.meta, this.links});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      products: json['products'] != null
          ? List<Null>.from(json['products'].map((x) => x))
          : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }
}

class Meta {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Meta({this.total, this.perPage, this.currentPage, this.lastPage});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      lastPage: json['last_page'],
    );
  }
}

class Links {
  String? first;
  String? last;
  Null? prev;
  Null? next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }
}
