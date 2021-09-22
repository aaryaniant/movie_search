class SearchActorsModel {
  List<Actors>? actors;

  SearchActorsModel({this.actors});

  SearchActorsModel.fromJson(Map<String, dynamic> json) {
    if (json['actors'] != null) {
      actors = <Actors>[];
      json['actors'].forEach((v) {
        actors!.add(new Actors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.actors != null) {
      data['actors'] = this.actors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Actors {
  String? imdbId;
  String? imgUrl;
  String ?name;

  Actors({this.imdbId, this.name});

  Actors.fromJson(Map<String, dynamic> json) {
    imdbId = json['imdb_id'];
    imgUrl = json['imgUrl'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imdb_id'] = this.imdbId;
    data['imgUrl'] = this.imgUrl;
    data['name'] = this.name;
    return data;
  }
}
