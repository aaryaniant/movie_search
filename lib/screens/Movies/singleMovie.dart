import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:localstorage/localstorage.dart';
import 'package:movie_database/Models/singleMovieModel.dart';
import 'package:movie_database/helper/widgets/loader.dart';
import 'package:movie_database/screens/Movies/addList.dart';
import 'package:movie_database/screens/Movies/download.dart';
import 'package:movie_database/screens/Movies/drawer.dart';
import 'package:movie_database/screens/Movies/favourite.dart';
import 'package:movie_database/screens/Movies/searchAction.dart';
import 'package:movie_database/screens/Movies/videoPlayer.dart';
import 'package:movie_database/store/appState.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';
import '/store/action.dart' as action;
import '../../main.dart';
import 'package:movie_database/helper/theme/theme.dart';

class SingleMovie extends StatefulWidget {
  final String? movieId;
  final String? movieTitle;

  SingleMovie({Key? key, required this.movieId, required this.movieTitle})
      : super(key: key);

  @override
  _SingleMovieState createState() => _SingleMovieState();
}

class _SingleMovieState extends State<SingleMovie> {
  VideoPlayerController? _videoPlayerController;
  final LocalStorage storage = new LocalStorage('downloads');
  String? dPercent;
  SingleMovieModel? movieItem;
  bool disableClick = false;
  bool isFav = false;
  bool addList = false;
GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    store.dispatch(action.fetchSingleMovieModel(
        context, widget.movieId, widget.movieTitle));
    fetchLocalFavourite();
    print(["movie imdb id", widget.movieId]);
    fatchLocalAddList();
    fatchDownload();
  }




/////Video Url And DOWNLOAD



  Future<String?> extractYoutubeLink(url) async {
    String? link;
    // getting url
    // https://www.youtube.com/embed/1dzGhJ5QGsQ
    // convert to this
    // https://www.youtube.com/watch?v=nRhYQlg8fVw
    try {
      link = await FlutterYoutubeDownloader.extractYoutubeLink(
          url.toString().replaceAll("embed/", "watch?v="), 18);
    } on PlatformException {
      link = 'Failed to Extract YouTube Video Link.';
    }
    return link;
  }

  Future<void> downloadVideo(SingleMovieModel item) async {
    setState(() {
      disableClick = true;
    });
    String? url = await extractYoutubeLink(item.trailer);
    var tempDir = await getExternalStorageDirectory();
    String fullPath = tempDir!.path + "/${item.imdbId}.mp4";

    print(["extractYoutubeLink", url]);
    print('full path ${fullPath}');

    var dio = Dio();

    await dio.download(url!, fullPath, onReceiveProgress: showDownloadProgress);
    if (dPercent == "100%") {
      var res = storage.getItem("downTrailers");
      // print(res);
      if (res == null) {
        res = [];
      }
      List movies = List.from(res);
      if (!movies.contains(jsonEncode(item.toJson()))) {
        movies.add(jsonEncode(item.toJson()));
      }

      Future.delayed(Duration(milliseconds: 2000), () {
        storage.setItem("downTrailers", movies);
      });
      setState(() {
        disableClick = false;
      });
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      // print((received / total * 100).toStringAsFixed(0) + "%");
      setState(() {
        dPercent = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }
fatchDownload() async {
  var res = await storage.getItem("downTrailers");
  if(res !=null){
    List movies = List.from(res);
    movies.map((item){      
      SingleMovieModel res = SingleMovieModel.fromJson(jsonDecode(item));
      if(res.imdbId==widget.movieId){
        setState(() {  
          dPercent="100%";        
        });
      }
    } ).toList();
  }
}
  





//////For FAVOURTIE,


  addFavourite(SingleMovieModel item) async {
    var res = storage.getItem("favourite");
    // print(['addFavourite', res]);
    if (res == null) {
      res = [];
    }
    List movies = List.from(res);
    if (!movies.contains(jsonEncode(item.toJson()))) {
      movies.add(jsonEncode(item.toJson()));
    }
    setState(() {
      isFav = true;
    });
    await Future.delayed(Duration(milliseconds: 200), () {
      storage.setItem("favourite", movies);
    });
    fetchLocalFavourite();
  }

  fetchLocalFavourite() async {
    var res = await storage.getItem("favourite");
    // print(['fetchLocalFavourite', res]);
    if (res != null) {
      List movies = List.from(res);
      movies.map((item) {
        SingleMovieModel res = SingleMovieModel.fromJson(jsonDecode(item));
        if (res.imdbId == widget.movieId) {
          setState(() {
            isFav = true;
          });
        }
      }).toList();
    }
  }


//delete file local
  deleteFav() async {

   List res = await storage.getItem("favourite");

    res.removeWhere((element) {
      SingleMovieModel s = SingleMovieModel.fromJson(jsonDecode(element));
      return s.imdbId == widget.movieId;
    });
    setState(() {
      isFav = false;
    });
    await Future.delayed(Duration(milliseconds: 100), () {
      storage.setItem("favourite", res);
    });
    fetchLocalFavourite();
  }





/////For ADDTOLIST
 
 // for add to list,
 addTOList(SingleMovieModel item) async {

   var res = storage.getItem("addToList");

   print(["addTOList",res]);
   if(res==null){
     res=[];
   }
   List moviesAdd = List.from(res);
   if(!moviesAdd.contains(jsonEncode(item.toJson()))){
     moviesAdd.add(jsonEncode(item.toJson()));
   }
   setState(() {
     addList=true;
   });
   await Future.delayed(Duration(milliseconds: 200),(){
     storage.setItem("addToList", moviesAdd);
   });
   fatchLocalAddList();
 }

//for fatch local add list
 fatchLocalAddList() async {
   var res = await storage.getItem("addToList");
   print(["fatchLocalAddList",res]);
   if(res!=null){
     List moviesAdd = List.from(res);   
     moviesAdd.map((item) {
       SingleMovieModel res = SingleMovieModel.fromJson(jsonDecode(item));
       if(res.imdbId==widget.movieId){
         setState(() {
           addList=true;
         });
       }
     } ).toList();  
   }   
 }

//for delete from the list
deleteAddList() async {
  List res = await storage.getItem("addToList");

  res.removeWhere((element) {
    SingleMovieModel res=SingleMovieModel.fromJson(jsonDecode(element));
    return res.imdbId==widget.movieId;
  });
  setState(() {
    addList=false;
  });
  await Future.delayed(Duration(milliseconds: 100),(){
    storage.setItem("addToList", res);
  });
  fatchLocalAddList();
}

@override
  void dispose() {
    
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      rebuildOnChange: true,
      builder: (context, state) {
        SingleMovieModel? item = store.state.singleMovieModel;
        return SafeArea(
          child: Scaffold(
            key:_globalKey,
            backgroundColor: Colors.black,            
            appBar: AppBar(
              backgroundColor: Colors.black54,
              elevation: 0,
              title:  Container(
                width: 300,                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                          icon: Icon(Icons.search_rounded,size: 30,),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchAction()));
                          },
                        ),
                  ],
                ),
              ),
              leading:  IconButton(
                    icon: Icon(Icons.arrow_back,size: 30,),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                 actions: [
                IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {
                 _globalKey.currentState!.openEndDrawer();
                  },
                ),
                Container(
                  width: 30,
                ),
                
              ],
            ),
            endDrawer: Drawer(
              child:DrawerScreen()
            ),
            body: (store.state.loader!.showLoader) as bool
                ? loader(context)
                : Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                          "https://static.pexels.com/photos/1526/dark-blur-blurred-gradient-landscape.jpg"),
                      fit: BoxFit.fill,
                    )),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical, child: mainBody(item!)),
                  ),
          ),
        );
      },
    );
  }

  Column mainBody(SingleMovieModel item) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        posterAndTitle(item),
        SizedBox(
          height: 30,
        ),
        _videoPlayerController != null
            ? AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              )
            : Container(),
        playButton(item),
        SizedBox(
          height: 20,
        ),
        Divider(
          color: white,
          height: 35,
        ),
        fourIconsRow(item),
        Divider(
          color: white,
          height: 35,
        ),
        SizedBox(
          height: 20,
        ),
        plotAndDescription(item),
      ],
    );
  }

  ///plot And Description

  Widget plotAndDescription(item) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Plot:",
              style: TextStyle(
                  fontSize: 20, color: white, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          Text(
            "${item.plot}",
            textAlign:TextAlign.justify,
            style: TextStyle(fontSize: 15, color: white),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Description:",
              style: TextStyle(
                  fontSize: 20, color: white, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          Text(
            "${item.description}",
            textAlign:TextAlign.justify,
            style: TextStyle(fontSize: 15, color: white,),
        
          ),
        ],
      ),
    );
  }

  ///Four Icon In Row

  Widget fourIconsRow(SingleMovieModel item) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
          ),
          InkWell(
              onTap: () {
                 if (!addList) {
                addTOList(item);
              } else {
                deleteAddList();
              }
            },
              
              child: addList
                  ? Container(
                      width: 80,
                      child: Column(
                        children: [
                          Icon(
                            Icons.cancel_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            "Remove",
                            style: TextStyle(fontSize: 13,
                             color: Colors.white
                             ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: 80,
                      child: Column(
                        children: [
                          Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            "Add to List",
                            style: TextStyle(fontSize: 13, color: white),
                          ),
                        ],
                      ),
                    )),
          //  InkWell(
          //   onTap: () {
          //     if (!addList) {
          //       addTOList(item);
          //     } else {
          //       deleteAddList();
          //     }
          //   },
          //   child: Container(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon( addList ?
          //           Icons.done : Icons.add,
          //           size: 30,
          //           color: isFav ? Colors.blue : Colors.white,
          //         ),
          //         Text( addList ? 
          //          "Added to List" : "Add to List",
          //           style: TextStyle(
          //               fontSize: 13,
          //               fontWeight: FontWeight.bold,
          //               color: isFav ? Colors.blue : white),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              if (!isFav) {
                addFavourite(item);
              } else {
                deleteFav();
              }
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                   isFav ? Icons.favorite : Icons.favorite_outline,
                    size: 30,
                    color: isFav ? Color(0xffe41212) : Colors.white,
                  ),
                  Text(
                    "Favourite",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 35,
          ),
          Container(
            width: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (disableClick == false) {
                      downloadVideo(item);
                    }
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.download,
                              size: 30,
                              color: white,
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                        Container(
                          width: 90,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              dPercent == "100%"
                                  ? Text(
                                      "Re-Download",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    )
                                  : Text(
                                      "Download ${dPercent ?? ''}",
                                      style:
                                          TextStyle(fontSize: 13, color: white),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Share.share(
                        "Movie Name: ${item.title} ,  Trailer: ${item.trailer} , WATCH NOW!!   ");
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.share,
                          size: 30,
                          color: white,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(fontSize: 13, color: white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///Play Button,

  Widget playButton(SingleMovieModel item) {
    return InkWell(
      onTap: () {
        print(["video id", item.trailer]);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                      videoUrl: item.trailer,
                    )));
        // playLocalVideos(item);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(7)),
          color: Color(0xffe41212),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_arrow,
              color: white,
            ),
            Text(
              "Play",
              style: TextStyle(
                  fontSize: 18, color: white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  //PosterAndTitle,
  Widget posterAndTitle(item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 150,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
            image: DecorationImage(
                image: NetworkImage(
                  "${item.banner}",
                ),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          height: 250,
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item.title}",
                overflow: TextOverflow.visible,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: white),
              ),
              SizedBox(
                height: 20,
              ),
             Container(
                child: Wrap(
                  children: store.state.singleMovieModel!.gen!.map<Widget>((e) {
                    int index = store.state.singleMovieModel!.gen!.indexOf(e);
                    return Text(
                      "${index == 0 ? item.year : ''}${index == 0 ? " ." : ''} ${e.genre}, ",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey[350]),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Wrap(
                  children: [
                    Text(
                      "${item.movieLength} Minutes . ${item.contentRating} Rated",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey[350]),
                    ),
                    //  Text("${item.contentRating} Rated",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey[350]),),
                  ],
                ),
              ),
              //
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Release Date: ${item.release}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey[350]),
                  ),
                  //  Text("2021-04-23",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey[350]),),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Rating: ${item.rating}/10",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.grey[350]),
              ),
            ],
          ),
        ),
      ],
    );
  }

//  _onShare(BuildContext context) async {

//     final RenderBox box = context.findRenderObject() as RenderBox;

//     if (imagePaths.isNotEmpty) {
//       await Share.shareFiles(imagePaths,
//           text: text,
//           subject: subject,
//           sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//     } else {
//       await Share.share(text,
//           subject: subject,
//           sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//     }
//   }

}
