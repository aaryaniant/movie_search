class UpcomingMovieModel {
  List<MoviesUpcoming> ?moviesUpcoming;

  UpcomingMovieModel({this.moviesUpcoming});

  UpcomingMovieModel.fromJson(Map<String, dynamic> json) {
    if (json['Movies Upcoming'] != null) {
      moviesUpcoming = <MoviesUpcoming>[];
      json['Movies Upcoming'].forEach((v) {
        moviesUpcoming!.add(new MoviesUpcoming.fromJson(v)); 
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.moviesUpcoming != null) {
      data['Movies Upcoming'] = this.moviesUpcoming!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MoviesUpcoming {
  String? title;
  String? imdbId;
  String? release;
  String? imgUrl;

  MoviesUpcoming({this.title, this.imdbId, this.release});

  MoviesUpcoming.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imdbId = json['imdb_id'];
    release = json['release'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['imdb_id'] = this.imdbId;
    data['release'] = this.release;
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}
