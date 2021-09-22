import 'dart:convert';

class DiscoverApiModel {
  List<Genres> ?genres;

  DiscoverApiModel({this.genres});

  DiscoverApiModel.fromJson(Map<String, dynamic> json) {
    if (json['Genres'] != null) {
      genres = <Genres>[];
      json['Genres'].forEach((v) {
        genres!.add(new Genres.fromJson(jsonDecode(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.genres != null) {
      data['Genres'] = this.genres!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genres {
  String ?genre;
  String? imageUrl;
  Genres({this.genre,this.imageUrl});

  Genres.fromJson(Map<String, dynamic> json) {
    genre = json['genre'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genre'] = this.genre;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
