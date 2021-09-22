import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_database/ModelActor/searchActorsModel.dart';
import 'package:movie_database/Models/discoverApiModel.dart';
import 'package:movie_database/Models/discoverMovieModel.dart';
import 'package:movie_database/Models/latestMovieModel.dart';
import 'package:movie_database/Models/loader.dart';
import 'package:movie_database/Models/searchModel.dart';
import 'package:movie_database/Models/singleMovieModel.dart';
import 'package:movie_database/Models/upcomingMovieModel.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'appState.dart';

Map<String, String>? headers = {
  'x-rapidapi-host': 'data-imdb1.p.rapidapi.com',
  'x-rapidapi-key': '685d86b0d9mshf78dcddef51d2cbp15ff6ajsn4db205f2b2ba'
};






//////////////////////////////////////////////////Movies//////////////////////////////////////////////////////////

//search image pixeles

Future<String?> searchImage(value) async {
  // print(["searchImage api running"]);r
  // String? urlImage;
  //   var url = Uri.parse("https://api.pexels.com/v1/search?query=$value&per_page=1");
  //   var response = await http.get(url,
  //   headers: {

  //   'Authorization': '563492ad6f91700001000001e1c9ff57cbed4fcfa66d4228c3ade2d8' });
  //   // print(response.body);
  //   // print(["search image api",response.body]);
  //   if(response.statusCode==200){
  //     var res = jsonDecode(response.body);

  //   urlImage = res['photos'][0]['src']['small'];
  //     print(["search image api", res['photos'][0]['src']['small']]);
  //   }
  return "https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=130"; // urlImage;
}

//fetch movies genere
ThunkAction<AppState> fetchGenere(context) {
  print(['fetchGenere api running ']);
  return (Store<AppState> store) async {
    store.dispatch(Loader(showLoader: true));

    var url = Uri.parse("https://data-imdb1.p.rapidapi.com/genres/");
    var response = await http.get(url, headers: headers);
    // print(response.body);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      List gen = res['Genres'];
      // print(["action generedata res", res]);
      List _newGen = [];
      gen.map((element) async {
        String? imgGen = await searchImage(element['genre']);
        Map map = {"genre": "${element['genre']}", "imageUrl": "$imgGen"};
        if (!_newGen.contains(map)) {
          _newGen.add(jsonEncode(map));
        }
        store.dispatch(DiscoverApiModel.fromJson({"Genres": _newGen}));
      }).toList();//    
      store.dispatch(Loader(showLoader: false));
    }
  };
}


//fetch upcoming movies 
ThunkAction<AppState> fetchUpcomingMovies(context,limit) {
  print(['fetchUpcomingMovies api running ']);
  return (Store<AppState> store) async {
    store.dispatch(Loader(showLoader: true));
List newRes = [];
    var url = Uri.parse("https://data-imdb1.p.rapidapi.com/movie/order/upcoming/");
    var response = await http.get(url,headers: headers);
      //  print(["action upcomingMoviesdata res", response.body]); 
    if(response.statusCode==200){
      var res = jsonDecode(response.body);
      List upCome = res["Movies Upcoming"];
      // print(["action upcomingMoviesdata res", res]); 
      
      upCome.take(limit).map(( element) async {
        String title = element['title']; 
        String id = element['imdb_id'];
        String date = element['release'];
        List? listMovie = await movieImageSearch(title,id);
        Map<String,dynamic> newArray = {
            "title": "$title",
            "imdb_id": "$id",
            "release": "$date",
            "imgUrl":"${listMovie!.first}"
        };
        newArray.addAll({"imgUrl":"${listMovie.first}"});
        if(!newRes.contains(newArray)){
          newRes.add(newArray);
          //  print(["upcomingMoviesdata sdf",newRes]);
        }   
          // print(["upcomingMoviesdata",newRes]);
         
          Future.delayed(Duration(milliseconds: 300),(){
             store.dispatch(UpcomingMovieModel.fromJson({"Movies Upcoming":newRes}));
             store.dispatch(Loader(showLoader: false));
          });
      }).toList(); 

    }else{
      store.dispatch(Loader(showLoader: false));
    }

  };
}
//image for Movies,
Future<List?> movieImageSearch(title,movieId) async {
 
  var url = Uri.parse("https://data-imdb1.p.rapidapi.com/movie/id/$movieId/");
  var response = await http.get(url,headers: headers);
  //  print(["searchImage api running",response.body]);
  if(response.statusCode==200){
    var res = jsonDecode(response.body);
   
    var movieImageUrl = res["Data"]['banner'];
    var popularity = res["Data"]['popularity'];
    return [movieImageUrl,popularity];
  }
}


//fetch latest movies 
ThunkAction<AppState> fetchLatestMovies(context,limit) {
  print(['fetchlatestMovies api running ']);
  return (Store<AppState> store) async {
    store.dispatch(Loader(showLoader: true));

    int year =DateTime.now().year;
    var url = Uri.parse("https://data-imdb1.p.rapidapi.com/movie/byYear/$year/");
    var response = await http.get(url,headers: headers);
      // print(['fetchlatestMovies api running ',response.body]);
    if(response.statusCode==200){
      var res = jsonDecode(response.body);
       List latest = res["Data"];
        List newRes = [];
      latest.take(limit).map(( element) async {
        String title = element['title']; 
        String id = element['imdb_id'];        
        List? listMovies = await movieImageSearch(title,id);
        Map<String,dynamic> newArray = {
            "title": "$title",
            "imdb_id": "$id",            
            "imgUrl":"${listMovies!.first}",
            "popularity":"${listMovies.last}"
        };
        //  newArray.addAll({"imgUrl":"${listMovies.first}"});
        if(!newRes.contains(newArray)){
          newRes.add(newArray);
          //  print(["upcomingMoviesdata sdf",newRes]);
        }   
          // print(["latestMoviesdata",newRes]);
          Future.delayed(Duration(milliseconds: 500),(){
            store.dispatch(LatestMovieModel.fromJson({"Movies $year":newRes}));
             store.dispatch(Loader(showLoader: false));
          });
      }).toList(); 
    }else{
         store.dispatch(Loader(showLoader: false));
    }
  };
}

//Discover movie by genres.
ThunkAction<AppState> fetchDiscoverMovieModel(context,genreId,limit) {
  print(['fetchSingleMovieModel api running $genreId']);
  return (Store<AppState> store) async {
    store.dispatch(Loader(showLoader: true));   
     var url = Uri.parse("https://data-imdb1.p.rapidapi.com/movie/byGen/$genreId/");
    var response = await http.get(url,headers: headers);
    if(response.statusCode==200){
       var res = jsonDecode(response.body); 
       List genres = res["Movies $genreId"];
      //  print(["DiscoverMoviedata",res]);
        List newRes = [];
        genres.take(limit).forEach(( element) async {
          String title = element['title']; 
          String id = element['imdb_id'];
          List? listMovies = await movieImageSearch(title,id);
           Map<String,dynamic> newArray = {
            "title": "$title",
            "imdb_id": "$id",            
            "imgUrl":"${listMovies!.first}",            
          };
          if(!newRes.contains(newArray)){
          newRes.add(newArray);
          //  print(["upcomingMoviesdata sdf",newRes]);
          } 
        
             Future.delayed(Duration(milliseconds: 300),(){
                 store.dispatch(DiscoverMovieModel.fromJson({"Movies Drama":newRes}));
             store.dispatch(Loader(showLoader: false)); 
             });
        });
  
 
    }else{
      store.dispatch(Loader(showLoader: false));   
    }
  };
}



//Single Movie
ThunkAction<AppState> fetchSingleMovieModel(context,movieId,title) {
  print(['fetchSingleMovieModel api running $movieId']);
  return (Store<AppState> store) async {
    store.dispatch(Loader(showLoader: true));

     var url = Uri.parse("https://data-imdb1.p.rapidapi.com/movie/id/$movieId/");
    var response = await http.get(url,headers: headers);
      print(["fetchSingleMovieModel",response.body]);  
    if(response.statusCode==200){
      var res = jsonDecode(response.body);    
    
     
      store.dispatch(SingleMovieModel.fromJson(res['Data']));
      Future.delayed(Duration(milliseconds: 500),(){
          store.dispatch(Loader(showLoader: false));
      });
    }else{
        store.dispatch(Loader(showLoader: false));
    }
  }; 
}

///Search
ThunkAction<AppState> fetchSearchTitle(context,seTitle) {
  print(['fetchSearchTitle api running ']);
  return (Store<AppState> store) async {
  var url = Uri.parse("https://data-imdb1.p.rapidapi.com/movie/imdb_id/byTitle/$seTitle/");
  var response = await http.get(url,headers: headers);
  if(response.statusCode==200){
    var res = jsonDecode(response.body);
    //  print(['fetchSearchTitle res',res]);
    List search =res['Data'];
    List newRes = [];
    //  print(['fetchSearchTitle res',res]);
     search.forEach(( element) async {     
     String title = element['title']; 
     String id = element['imdb_id'];
     List? listMovies = await movieImageSearch(title,id);
     Map<String,dynamic> newArray = {
      "title": "$title",
      "imdb_id": "$id",            
      "imgUrl":"${listMovies!.first}",            
     };
     if(!newRes.contains(newArray)){
          newRes.add(newArray);
          //  print(["upcomingMoviesdata sdf",newRes]);
          } 
    store.dispatch(SearchModel.fromJson({
      "Result":newRes
    }));
    store.dispatch(Loader(showLoader: false));
     });
  }else{
    store.dispatch(Loader(showLoader: false));
  }
  };
}
  
    
//////////////////////////////////////////////////////Actors///////////////////////////////////////////////////////

///Image of Actor,

Future<List?> searchActorsImage(name,actorId) async {
 
  var url = Uri.parse("https://data-imdb1.p.rapidapi.com/actor/id/$actorId/");
  var response = await http.get(url,headers: headers);
   print(["searchActorsImage api running",response.body]);
  if(response.statusCode==200){
    var res = jsonDecode(response.body);   
    var actorImageUrl = res["ActorDetails"]['image_url'];    
    return [actorImageUrl];
  }
}


///Search  by name of Actor,

ThunkAction<AppState> fetchSearchActor(context,seName) {
  print(['fetchSearchActor api running ']);
  return (Store<AppState> store) async {
    var url = Uri.parse("https://data-imdb1.p.rapidapi.com/actor/imdb_id_byName/$seName/");
    var response = await http.get(url,headers: headers);
     
    if(response.statusCode==200){
      var res = jsonDecode(response.body);
      List search = res['Actors'];
      List newRes = [];
      search.forEach((element) async{
        String name = element['name'];
        String actorId =element['imdb_id'];
        List? listActors = await searchActorsImage(name,actorId);
        Map<String,dynamic> newArray = {
          "name" : "$name",
          "imdb_id" : "$actorId",
          "imgUrl" : "${listActors!.first}"
        };
        if(!newRes.contains(newArray)){
          print(["fetchSearchActor ",newRes]);
          newRes.add(newArray);
        }
        store.dispatch(SearchActorsModel.fromJson({
          "actors":newRes,
        }));
        
        store.dispatch(Loader(showLoader: false));        
      });
    }else{
      store.dispatch(Loader(showLoader: false));
    }
  };
}