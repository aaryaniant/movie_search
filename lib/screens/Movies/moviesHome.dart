import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_database/Models/latestMovieModel.dart';
import 'package:movie_database/helper/theme/theme.dart';
import 'package:movie_database/screens/Movies/searchAction.dart';
import 'package:movie_database/screens/Movies/singleMovie.dart';
import 'package:movie_database/store/appState.dart';
import '/store/action.dart' as action;
import '../../main.dart';
import 'allLatestMovies.dart';
import 'allUpcomingMovies.dart';
import 'discoverMovie.dart';

class Movies extends StatefulWidget {
  Movies({Key? key}) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  void initState() {
    super.initState();
    // store.dispatch(action.fetchUpcomingMovies(context, 7));
    // store.dispatch(action.fetchLatestMovies(context, 20));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          // var deviceHeight = MediaQuery.of(context).size.height;
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://static.pexels.com/photos/1526/dark-blur-blurred-gradient-landscape.jpg"),
                      fit: BoxFit.fill
                    )
                  ),
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      headerAndSearch(),
                      SizedBox(
                        height: 20,
                      ),
                      popularHead(),
                      SizedBox(
                        height: 15,
                      ),
                      popularAutoSlider(),
                      SizedBox(
                        height: 40,
                      ),
                      latestHead(),
                      SizedBox(
                        height: 20,
                      ),
                      latestAutoSlider(),
                      SizedBox(
                        height: 20,
                      ),
                      upcomingHead(),
                      SizedBox(
                        height: 20,
                      ),
                      upcomingAutoSlider(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget popularHead() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Popular",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: white,)
          ),
          // Text(
          //   "See all",
          //   style: TextStyle(color: Color(0xffe41212), fontSize: 16),
          // ),
        ],
      ),
    );
  }

  Widget latestHead() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Latest Release",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: white),
          ),
          
          InkWell(
            onTap:(){
               Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllLatestMovies()));    
            },
            child: Text(
              "See all",
              style: TextStyle(color: Color(0xffe41212), fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget upcomingHead() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Upcoming Movies",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: white),
          ),
          
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverMovie( genreId: '',)));
            },
            child: InkWell(
               onTap:(){
               Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  AllUpcomingMovies()));    
            },
              child: Text(
                "See all",
                style: TextStyle(color: Color(0xffe41212), fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget popularAutoSlider() {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        options: CarouselOptions(
          // height: 150,
          aspectRatio: 0.8,
          autoPlay: true,
          viewportFraction: 0.7,
          initialPage: 0,
          enableInfiniteScroll: true,
          //autoPlayCurve: Curves.linear,
          enlargeCenterPage: true,
        ),
        items: store.state.latestMovieModel!.movies2021!.map<Widget>((movie) {
          return _sliderCard(movie);
        }).toList(),
      ),
    );
  }

  Widget _sliderCard(Movies2021 movie) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleMovie(
                      movieId: movie.imdbId,
                      movieTitle: movie.title,
                    )));
      },
      child:CachedNetworkImage(
        imageUrl: movie.imgUrl.toString(),
        filterQuality: FilterQuality.low,
        imageBuilder:  (context, imageProvider) => Container(        
          decoration: BoxDecoration(
            image: DecorationImage(
                image: imageProvider, fit: BoxFit.contain),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
      
                // height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black54,
                      Colors.black
                    ])),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${movie.title}",
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.fromLTRB(5, 15, 0, 5),
                  decoration: BoxDecoration(
                    color: Color(0xffd33e5d).withOpacity(0.75),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                        topLeft: Radius.circular(7)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.arrow_circle_up,
                        color: white.withOpacity(0.75),
                      ),
                      Text(
                        "Popular",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: white.withOpacity(0.75),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
         placeholder: (context, url) => SizedBox(
           height: 200,
           width: 180,
           child: Center(
             child:CircularProgressIndicator(color: Color(0xffe41212),))),
             errorWidget:(context, url, error) =>Icon(Icons.error),
      ),
    );
  }

  Widget headerAndSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Movies",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.search_rounded),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchAction()));
            },
          ),
        ],
      ),
    );
  }

  Widget latestAutoSlider() {
    return CarouselSlider(
      options: CarouselOptions(
          height: 250,
          viewportFraction: 0.4,
          initialPage: 0,
          disableCenter: true,
          enableInfiniteScroll: true,
          autoPlayCurve: Curves.linear,
          reverse: true),
      items: store.state.latestMovieModel!.movies2021!.map<Widget>((item) {
        // int index = store.state.latestMovieModel!.movies2021!.indexOf(item);

        return item.imgUrl.toString() == "aa.com"
            ? Container()
            : InkWell(
              onTap: () {
                Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleMovie(
                      movieId: item.imdbId,
                      movieTitle: item.title,
                    )));                
              },
              child:Container(
                  
                  margin: EdgeInsets.only(left: 5),
                  // padding:EdgeInsets.only(left: 25),
            
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image.network(
                      //   "${item.imgUrl}",
                      //   width: 150,
                      //   height: 180,
                      //   fit: BoxFit.cover,
                      // ),
                      CachedNetworkImage(
                        imageUrl: item.imgUrl.toString(),
                        filterQuality: FilterQuality.low,
                         imageBuilder: (context, imageProvider) => Image.network(
                             "${item.imgUrl}",
                              width: 150,
                              height: 180,
                             fit: BoxFit.cover,
                         ),
                         placeholder: (context, url) => SizedBox(
                           height: 180,
                            width: 150,
                            child: Center(child: CircularProgressIndicator(color: Color(0xffe41212),))),
                             errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                        SizedBox(height: 5,),
                      Text( 
                        "${item.title}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                      Text(
                        "Movies",
                        style: TextStyle(fontSize: 14, color: white),
                      ),
                    ],
                  ),
                ),
            );
      }).toList(),
    );
  }

  ///Upcoming Auto Slider

  Widget upcomingAutoSlider() {
    return CarouselSlider(
        options: CarouselOptions(
          height: 250,
          viewportFraction: 0.4,
          initialPage: 0,
          disableCenter: true,
          enableInfiniteScroll: true,
          autoPlayCurve: Curves.linear,
        ),
        items:
            store.state.upcomingMovieModel!.moviesUpcoming!.map<Widget>((item) {
          // int index =
          //     store.state.upcomingMovieModel!.moviesUpcoming!.indexOf(item);

          return item.imgUrl.toString() == "aa.com"
              ? Container()
              : InkWell(                 
              onTap: () {
                Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleMovie(
                      movieId: item.imdbId,
                      movieTitle: item.title,
                    ))); 
              } ,
                child:Container(
                    
                    margin: EdgeInsets.only(left: 5),
                    // padding:EdgeInsets.only(left: 25),
              
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.network(
                        //   "${item.imgUrl}",
                        //   width: 150,
                        //   height: 180,
                        //   fit: BoxFit.cover,
                        // ),
                        CachedNetworkImage(
                        imageUrl: item.imgUrl.toString(),
                        filterQuality: FilterQuality.low,
                         imageBuilder: (context, imageProvider) => Image.network(
                             "${item.imgUrl}",
                              width: 150,
                              height: 180,
                             fit: BoxFit.cover,
                         ),
                         placeholder: (context, url) => SizedBox(
                           height: 180,
                            width: 150,
                            child: Center(child: CircularProgressIndicator(color: Color(0xffe41212),))),
                             errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                        SizedBox(height: 5,),
                        Text(
                          "${item.title}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                        Text(
                          "Movies",
                          style: TextStyle(fontSize: 14, color: white),
                        ),
                      ],
                    ),
                  ),
              );
        }).toList());
  }
}
