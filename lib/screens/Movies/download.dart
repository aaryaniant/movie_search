import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:localstorage/localstorage.dart';
import 'package:movie_database/Models/singleMovieModel.dart';
import 'package:movie_database/helper/theme/theme.dart';
import 'package:movie_database/screens/Movies/singleMovie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'localPlayer.dart';

class Download extends StatefulWidget {
  Download({Key? key}) : super(key: key);

  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  final LocalStorage storage = new LocalStorage('downloads');
  List localStoredTrailes = [];

  @override
  void initState() {
    super.initState();
  Future.delayed(Duration(milliseconds: 1000),(){

  
    fetchLocalDownloads();
   
  });}

  fetchLocalDownloads() async {
    var res = await storage.getItem("downTrailers");
    print(['fetchLocalDownloads',res]);
    if (mounted && res != null) {
      setState(() {
        localStoredTrailes = res;
      });
    }
  }

  delete(imdbId) async {
    //delete file local

    var tempDir = await getExternalStorageDirectory();
    String fullPath = tempDir!.path + "/$imdbId.mp4";
    File file = File(fullPath);
    file.delete();
    List res = await storage.getItem("downTrailers");
    
    
    res.removeWhere((element) {
      SingleMovieModel s = SingleMovieModel.fromJson(jsonDecode(element));
      return s.imdbId == imdbId;
    });

  Future.delayed(Duration(milliseconds: 2000),(){
  storage.setItem("downTrailers", res);
  });
    setState(() {});
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Tooltip(
            message: "for Delete Swipe Left And For Info Swipe Right",
            child: Container(
                margin: EdgeInsets.only(right: 10), child: Icon(Icons.help)),
            waitDuration: Duration(milliseconds: 10),
            showDuration: Duration(seconds: 3),
            triggerMode: TooltipTriggerMode.tap,
          ),
          
        ],
        title: Text(
          "Downloads",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              "https://static.pexels.com/photos/1526/dark-blur-blurred-gradient-landscape.jpg"),
          fit: BoxFit.fill,
        )),
        child: localStoredTrailes.isEmpty ?  Center(child: Text("Empty",style: TextStyle( color: white,fontSize: 020,fontWeight: FontWeight.bold),),)  :
        
        SingleChildScrollView(
          child: Column(
              children: localStoredTrailes.map((e) {
            SingleMovieModel? localMovie =
                SingleMovieModel.fromJson(jsonDecode(e));
            return Column(
              children: [
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 60,                  
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [Color(0xff4f5f5d),Color(0xffb3bdba),Color(0xff4b4d47),Color(0xff293737)],
                //       end: Alignment.topRight,
                //       begin: Alignment.topLeft,
                //     ),
                //   ),
                // ),
                downloadItem(context, localMovie),
                Divider(
                  color: Colors.grey[300],
                ),
              ],
            );
          }).toList()),
        ),
      ),
    );
  }

  Container downloadItem(BuildContext context, SingleMovieModel localMovie) {
    return Container(      
             decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff4f5f5d),Color(0xffb3bdba),Color(0xff4b4d47),Color(0xff293737)],
                      end: Alignment.topRight,
                      begin: Alignment.topLeft,
                    ),
                  ),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SwipeableTile(
           movementDuration:Duration(milliseconds: 0),
           resizeDuration:Duration(milliseconds: 2) ,
                key: UniqueKey(),
                
                direction: SwipeDirection.horizontal,                  
                backgroundBuilder: (context, direction, progress) {
                 print(["value",progress.value]);
                  if(direction==SwipeDirection.endToStart){
                    return Container(
                  child: Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: Colors.red,
                );
                  }
                  else if(direction==SwipeDirection.startToEnd){
                    return  Container(
                  child: Center(
                    child: Text(
                      'Info',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: Colors.greenAccent,
                );
                  }
                   return Container();

                  
                },                   
                onSwiped: (direction){
                  if(direction==SwipeDirection.endToStart){
                    showDialog(
                      context: context, 
                      builder: (context){
                      return  AlertDialog(
                          title: Text("Are you Sure ?",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                          actions: [
                            TextButton(onPressed: (){Navigator.of(context).pop(false);setState(() {});}, child: Text("No",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                            TextButton(onPressed: (){delete(localMovie.imdbId);setState(() {Navigator.of(context).pop(false);});}, child: Text("Yes",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                          ],
                        );
                      }
                    );
                    // delete(localMovie.imdbId);
                  }
                  else{
                      if(direction==SwipeDirection.startToEnd){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SingleMovie(movieId: localMovie.imdbId,movieTitle:localMovie.title)));
                  }
                    setState(() {
                     
                    });
                  }
                 
                },
                 color: Colors.grey.shade600,
                 child: ListTile(
                leading: Image.network(localMovie.imageUrl.toString()),
                title: Text("${localMovie.title}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                trailing: playButton(localMovie),
              ),
              ),
              //
            );
  }






  Widget playButton(localMovie) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LocalVideoPlayer(
                      imdbId: localMovie!.imdbId,
                    )));
        //  delete(localMovie.imdbId);
      },
      child: Container(
        width: 55,        
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: white),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                color: Colors.grey,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              "Play",
              style: TextStyle(color: white),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(27),
                        bottomRight: Radius.circular(27)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo,
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ]),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: white,
                )),
          ],
        ),
      ),
    );
  }











                //  Dismissible(
                //     key: UniqueKey(),
                // resizeDuration:Duration(milliseconds: 10),
                //   direction:DismissDirection.horizontal,
                //   onDismissed: (DismissDirection direction) {
                    
                //       setState(() {
                        
                //       });
                  
                //     if (direction == DismissDirection.endToStart) {
                //       delete(localMovie.imdbId);
                //     } 
                //     if(direction == DismissDirection.startToEnd) {
                    
                    
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //                   SingleMovie(movieId: localMovie.imdbId,movieTitle:localMovie.title)));
                                  
                //     }
                     
                //   },
                //   secondaryBackground: Container(
                //     child: Center(
                //       child: Text(
                //         'Delete',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //     color: Colors.red,
                //   ),
                //   background: Container(
                //     child: Center(
                //       child: Text(
                //         'Info',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //     color: Colors.greenAccent,
                //   ),
                //   child: ListTile(
                //     leading: Image.network(localMovie.imageUrl.toString()),
                //     title: Text("${localMovie.title}",
                //         overflow: TextOverflow.ellipsis,
                //         style: TextStyle(
                //           color: white,
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //         )),
                //     trailing: playButton(localMovie),
                //   ),
                
                // ),
                // ListTile(
                //   leading: Image.network(localMovie.imageUrl.toString()),
                //   title: Text("${localMovie.title}",
                //       overflow: TextOverflow.ellipsis,
                //       style: TextStyle(
                //         color: white,
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //       )),
                //   trailing: playButton(localMovie),
                // ),
}
