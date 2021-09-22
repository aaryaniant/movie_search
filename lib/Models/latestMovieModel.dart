class LatestMovieModel {
  List<Movies2021> ?movies2021;

  LatestMovieModel({this.movies2021});

  LatestMovieModel.fromJson(Map<String, dynamic> json) {
    if (json['Movies 2021'] != null) {
      movies2021 = <Movies2021>[];
      json['Movies 2021'].forEach((v) {
        movies2021!.add(new Movies2021.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movies2021 != null) {
      data['Movies 2021'] = this.movies2021!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movies2021 {
  String? imdbId;
  String ?title;
  String? imgUrl;
  String ?popularity;

  Movies2021({this.imdbId, this.title,this.imgUrl,this.popularity});

  Movies2021.fromJson(Map<String, dynamic> json) {
    imdbId = json['imdb_id'];
    title = json['title'];
    imgUrl = json['imgUrl'];
    popularity = json["popularity"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imdb_id'] = this.imdbId;
    data['title'] = this.title;
    data['imgUrl'] = this.imgUrl;
    data['popularity']=this.popularity;

    return data;
  }
}
