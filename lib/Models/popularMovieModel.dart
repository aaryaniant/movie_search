class PopularMovieModel {
  List<MovieOrderByPopularity> ?movieOrderByPopularity;

  PopularMovieModel({this.movieOrderByPopularity});

  PopularMovieModel.fromJson(Map<String, dynamic> json) {
    if (json['Movie Order By Popularity'] != null) {
      movieOrderByPopularity = <MovieOrderByPopularity>[];
      json['Movie Order By Popularity'].forEach((v) {
        movieOrderByPopularity!.add(new MovieOrderByPopularity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movieOrderByPopularity != null) {
      data['Movie Order By Popularity'] =
          this.movieOrderByPopularity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MovieOrderByPopularity {
  String? imdbId;
  String? title;
  int? popularity;
  String? imgUrl;


  MovieOrderByPopularity({this.imdbId, this.title, this.popularity});

  MovieOrderByPopularity.fromJson(Map<String, dynamic> json) {
    imdbId = json['imdb_id'];
    title = json['title'];
    popularity = json['popularity'];
    imgUrl = json['imgUrl'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imdb_id'] = this.imdbId;
    data['title'] = this.title;
    data['popularity'] = this.popularity;
    data['imgUrl'] = this.imgUrl;

    return data;
  }
}
