import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_database/helper/theme/theme.dart';
import 'package:movie_database/screens/Movies/singleMovie.dart';
import 'package:movie_database/store/appState.dart';
import '/store/action.dart' as action;
import '../../main.dart';

class AllLatestMovies extends StatefulWidget {
  AllLatestMovies({Key? key}) : super(key: key);

  @override
  _AllLatestMoviesState createState() => _AllLatestMoviesState();
}

class _AllLatestMoviesState extends State<AllLatestMovies> {
  @override
  void initState() {
    super.initState();
    store.dispatch(action.fetchLatestMovies(context, 10));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          // var item =  store.state.AllLatestMoviesModel!.moviesDrama!.map((e) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar:
                  //  PreferredSize(
                  //   preferredSize: Size.fromHeight(80),
                  //   child:
                  AppBar(
                elevation: 10,
                backgroundColor: Colors.black,
                shadowColor: Colors.grey,
                title: Text(
                  "Latest Movies ${DateTime.now().year}",
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold, color: white),
                ),
              ),
              // ),
              body: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      "https://static.pexels.com/photos/1526/dark-blur-blurred-gradient-landscape.jpg"),
                  fit: BoxFit.fill,
                )),
                child: (store.state.loader!.showLoader) as bool &&
                        store.state.latestMovieModel!.movies2021!.isEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: Center(
                          child: Container(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xffe41212),
                              )),
                        ),
                      )
                    : StaggeredGridView.countBuilder(
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        itemCount: 10,
                        crossAxisCount: 2,
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(1, 1.7);
                        },
                        itemBuilder: (context, index) {
                          var item =
                              store.state.latestMovieModel!.movies2021![index];
                          return item.imgUrl.toString() == "aa.com"
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    store.dispatch(action.fetchSingleMovieModel(
                                        context, item.imdbId, item.title));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SingleMovie(
                                                  movieId: item.imdbId,
                                                  movieTitle: item.title,
                                                )));
                                  },
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:MediaQuery.of(context).size.width,
                                          height: 280,
                                          // decoration: BoxDecoration(
                                          //   image: DecorationImage(
                                          //     image: NetworkImage(item.imgUrl.toString()),
                                          //     fit: BoxFit.fill,
                                          //   )

                                          child: CachedNetworkImage(
                                            imageUrl: item.imgUrl.toString(),
                                            filterQuality: FilterQuality.low,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) => SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: Color(0xffe41212),
                                                        ))),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          item.title.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        },
                      ),
              ),
            ),
          );
        });
  }
}
