

class SingleMovieModel {
	String? imdbId;
	String? title;
	int? year;
	int? popularity;
	String? description;
	String? contentRating;
	int? movieLength;
	double? rating;
	String? createdAt;
	String? trailer;
	String? imageUrl;
	String? release;
	String? plot;
	String? banner;
	String? type;
	List<Gen>? gen;
	List<Keywords>? keywords;

	SingleMovieModel({this.imdbId, this.title, this.year, this.popularity, this.description, this.contentRating, this.movieLength, this.rating, this.createdAt, this.trailer, this.imageUrl, this.release, this.plot, this.banner, this.type, this.gen, this.keywords});

	SingleMovieModel.fromJson(Map<String, dynamic> json) {
		imdbId = json['imdb_id'];
		title = json['title'];
		year = json['year'];
		popularity = json['popularity'];
		description = json['description'];
		contentRating = json['content_rating'];
		movieLength = json['movie_length'];
		rating = json['rating']==null?   0.0: double.parse(json['rating'].toString());
		createdAt = json['created_at'];
		trailer = json['trailer'];
		imageUrl = json['image_url'];
		release = json['release'];
		plot = json['plot'];
		banner = json['banner'];
		type = json['type'];
		if (json['gen'] != null) {
			gen = <Gen>[];
			json['gen'].forEach((v) { gen!.add(new Gen.fromJson(v)); });
		}
		if (json['keywords'] != null) {
			keywords = <Keywords>[];
			json['keywords'].forEach((v) { keywords!.add(new Keywords.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imdb_id'] = this.imdbId;
		data['title'] = this.title;
		data['year'] = this.year;
		data['popularity'] = this.popularity;
		data['description'] = this.description;
		data['content_rating'] = this.contentRating;
		data['movie_length'] = this.movieLength;
		data['rating'] = this.rating;
		data['created_at'] = this.createdAt;
		data['trailer'] = this.trailer;
		data['image_url'] = this.imageUrl;
		data['release'] = this.release;
		data['plot'] = this.plot;
		data['banner'] = this.banner;
		data['type'] = this.type;
		if (this.gen != null) {
      data['gen'] = this.gen!.map((v) => v.toJson()).toList();
    }
		if (this.keywords != null) {
      data['keywords'] = this.keywords!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}


class Gen {
	int? id;
	String ?genre;

	Gen({this.id, this.genre});

	Gen.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		genre = json['genre'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['genre'] = this.genre;
		return data;
	}
}

class Keywords {
	int? id;
	String ?keyword;

	Keywords({this.id, this.keyword});

	Keywords.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		keyword = json['keyword'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['keyword'] = this.keyword;
		return data;
	}
}
