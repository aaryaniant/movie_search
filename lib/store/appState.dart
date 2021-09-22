import 'package:flutter/material.dart';
import 'package:movie_database/ModelActor/searchActorsModel.dart';
import 'package:movie_database/Models/discoverApiModel.dart';
import 'package:movie_database/Models/discoverMovieModel.dart';
import 'package:movie_database/Models/loader.dart';
import 'package:movie_database/Models/singleMovieModel.dart';
import 'package:movie_database/Models/upcomingMovieModel.dart';
import 'package:movie_database/Models/latestMovieModel.dart';
import 'package:movie_database/Models/searchModel.dart';

@immutable
class AppState {
  final Loader? loader;
  final DiscoverApiModel? discoverApiModel;
  final UpcomingMovieModel? upcomingMovieModel; 
  final LatestMovieModel? latestMovieModel;  
  final SingleMovieModel? singleMovieModel;  
  final DiscoverMovieModel? discoverMovieModel;  
  final SearchModel? searchModel;  
  final SearchActorsModel? searchActorsModel;  
  AppState({
    @required this.loader,
    @required this.discoverApiModel,
    @required this.upcomingMovieModel,
    @required this.latestMovieModel,    
    @required this.singleMovieModel,    
    @required this.discoverMovieModel,    
    @required this.searchModel,    
    @required this.searchActorsModel,    
  });

  factory AppState.initial() => AppState(
        loader: Loader(showLoader: false),
        discoverApiModel: DiscoverApiModel.fromJson({  "Genres": [] }),
        upcomingMovieModel: UpcomingMovieModel.fromJson({ "Movies Upcoming" : [] }),
        latestMovieModel: LatestMovieModel.fromJson({ "Movies 2021" : [] }),        
        singleMovieModel: SingleMovieModel.fromJson({}),   
        discoverMovieModel: DiscoverMovieModel.fromJson({}),
        searchModel: SearchModel.fromJson({}),
        searchActorsModel: SearchActorsModel.fromJson({}),
             
      );

  AppState copyWith({Loader? loader}) {
    return AppState(
      loader: loader ?? this.loader ?? Loader(showLoader: false),
      discoverApiModel: discoverApiModel??this.discoverApiModel,
      upcomingMovieModel: upcomingMovieModel??this.upcomingMovieModel,
      latestMovieModel: latestMovieModel??this.latestMovieModel,      
      singleMovieModel: singleMovieModel??this.singleMovieModel,      
      discoverMovieModel: discoverMovieModel??this.discoverMovieModel,      
      searchModel: searchModel??this.searchModel,      
      searchActorsModel: searchActorsModel??this.searchActorsModel,      
    );
  }
}

