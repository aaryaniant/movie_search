class Loader {
  bool? showLoader;

  Loader({required this.showLoader});

  Loader.fromJson(Map<String, dynamic> json) {
    showLoader = json['showLoader'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showLoader'] = this.showLoader;
    return data;
  }
}
