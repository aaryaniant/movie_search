class DiscoverMovieModel {
  List<MoviesDrama> ?moviesDrama;

  DiscoverMovieModel({this.moviesDrama});

  DiscoverMovieModel.fromJson(Map<String, dynamic> json) {
    if (json['Movies Drama'] != null) {
      moviesDrama = <MoviesDrama>[];
      json['Movies Drama'].forEach((v) {
        moviesDrama!.add(new MoviesDrama.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.moviesDrama != null) {
      data['Movies Drama'] = this.moviesDrama!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MoviesDrama {
  String ?imdbId;
  String ?title;
  String? imgUrl;

  MoviesDrama({this.imdbId, this.title});

  MoviesDrama.fromJson(Map<String, dynamic> json) {
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
