import 'package:movie_database/ModelActor/searchActorsModel.dart';
import 'package:movie_database/Models/discoverApiModel.dart';
import 'package:movie_database/Models/discoverMovieModel.dart';
import 'package:movie_database/Models/latestMovieModel.dart';
import 'package:movie_database/Models/loader.dart';
import 'package:movie_database/Models/singleMovieModel.dart';  
import 'package:movie_database/Models/upcomingMovieModel.dart';
import 'package:movie_database/Models/searchModel.dart';

import 'appState.dart';

//combine reducers
AppState appReducer(AppState state, action) {
  return AppState(
    loader: showLoader(state.loader as Loader, action),
    discoverApiModel: discoverReducer(state.discoverApiModel as DiscoverApiModel, action),
    upcomingMovieModel: upcomingMovieModel(state.upcomingMovieModel as UpcomingMovieModel, action),
    latestMovieModel: latestMovieModel(state.latestMovieModel as LatestMovieModel, action),    
    singleMovieModel: singleMovieModel(state.singleMovieModel as SingleMovieModel, action),    
    discoverMovieModel: discoverMovieModel(state.discoverMovieModel as DiscoverMovieModel, action),    
    searchModel: searchModel(state.searchModel as SearchModel, action),    
    searchActorsModel: searchActorsModel(state.searchActorsModel as SearchActorsModel, action),    
  );


}

//loader reducer
showLoader(Loader prevState, dynamic action) {
  if (action is Loader) {
    return action;
  }
  return prevState;
}


//discoverApi reducer
discoverReducer(DiscoverApiModel prevState, dynamic action) {
  if (action is DiscoverApiModel) {
    return action;
  }
  return prevState;
}

//upcomingMovie reducer
upcomingMovieModel(UpcomingMovieModel prevState,dynamic action){
  if( action is UpcomingMovieModel) {
    return action;
  }
  return prevState;
}

//upcomingMovie reducer
latestMovieModel(LatestMovieModel prevState,dynamic action){
  if( action is LatestMovieModel) {
    return action;
  }
  return prevState;
}

//singleMovie reducer
singleMovieModel(SingleMovieModel prevState,dynamic action){
  if( action is SingleMovieModel) {
    return action;
  }
  return prevState;
}

//DiscoverMovie reducer
discoverMovieModel(DiscoverMovieModel prevState,dynamic action){
  if( action is DiscoverMovieModel) {
    return action;
  }
  return prevState;
}


//Search reducer
searchModel(SearchModel prevState,dynamic action){
  if( action is SearchModel) {
    return action;
  }
  return prevState;
}


//Search Actor reducer
searchActorsModel(SearchActorsModel prevState,dynamic action){
  if( action is SearchActorsModel) {
    return action;
  }
  return prevState;
}
