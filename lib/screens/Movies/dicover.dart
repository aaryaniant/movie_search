import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:http/http.dart' as http;
import 'package:movie_database/Models/discoverApiModel.dart';
import 'package:movie_database/Models/loader.dart';
import 'package:movie_database/helper/theme/theme.dart';
import 'package:movie_database/screens/Movies/searchAction.dart';

import 'package:movie_database/store/action.dart' as action;
import 'package:movie_database/store/appState.dart';

import '../../main.dart';
import 'discoverMovie.dart';

class Discover extends StatefulWidget {
  Discover({Key? key}) : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  void initState() {
    store.dispatch(action.fetchGenere(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          var deviceHeight = MediaQuery.of(context).size.height;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: deviceHeight,
            decoration: BoxDecoration(               
                image: DecorationImage(                  
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://static.pexels.com/photos/1526/dark-blur-blurred-gradient-landscape.jpg"))),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  discoverAndSearch(),
                  (store.state.loader!.showLoader) as bool &&
                          store.state.discoverApiModel!.genres!.isEmpty
                      ? Container(
                          height: deviceHeight / 1.2,
                          child: Center(
                            child: Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Color(0xffe41212),
                                  strokeWidth: 2,
                                )),
                          ),
                        )
                      : store.state.discoverApiModel!.genres!.isEmpty
                          ? Container(
                              height: deviceHeight / 1.2,
                              child: Center(
                                  child: Text("Empty",
                                      style: TextStyle(color: white))))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: store
                                  .state.discoverApiModel!.genres!.length,
                              itemBuilder: (BuildContext context, int index) {
                                Genres item = store
                                    .state.discoverApiModel!.genres![index];
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DiscoverMovie(
                                          genreId: item.genre,
                                        )));
                                      },
                                      child: ListTile(
                                        //  leading: Image.network("$imageUrl",width: 50,height: 50,),
                                        title: Text(
                                          "${item.genre}",
                                          style: TextStyle(color: white),
                                        ),
                                        trailing: Icon(
                                          Icons.chevron_right,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                    Divider(height: 2,thickness: 1,color: Colors.grey[700],),
                                  ],
                                );
                              }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget discoverAndSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Discover",
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        IconButton(
           icon: Icon(Icons.search_rounded,
          color: Colors.white,
          size: 30,),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchAction()));
          },         
        ),
      ],
    );
  }
}
