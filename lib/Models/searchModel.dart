class SearchModel {
  List<Result>? result;

  SearchModel({this.result});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['Result'] != null) {
      result = <Result>[];
      json['Result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['Result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String ?imdbId;
  String? imgUrl;
  String ?title;

  Result({this.imdbId, this.title});

  Result.fromJson(Map<String, dynamic> json) {
    imdbId = json['imdb_id'];
    imgUrl = json['imgUrl'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imdb_id'] = this.imdbId;
    data['imgUrl'] = this.imgUrl;
    data['title'] = this.title;
    return data;
  }
}
