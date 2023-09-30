class SliderModel {
  Data? data;
  String? message;
  List<String>? error;
  int? status;

  SliderModel({this.data, this.message, this.error, this.status});

  SliderModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'] != null ? List<String>.from(json['error']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    if (error != null) {
      data['error'] = error;
    }
    data['status'] = status;
    return data;
  }
}

class Data {
  List<Sliders>? sliders;

  Data({this.sliders});

  Data.fromJson(Map<String, dynamic> json) {
    sliders = json['sliders'] != null
        ? List<Sliders>.from(json['sliders'].map((dynamic x) => Sliders.fromJson(x)))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sliders != null) {
      data['sliders'] = sliders!.map((Sliders x) => x.toJson()).toList();
    }
    return data;
  }
}

class Sliders {
  String? image;

  Sliders({this.image});

  Sliders.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    return data;
  }
}
