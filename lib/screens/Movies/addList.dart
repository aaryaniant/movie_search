// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:flutter/painting.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:movie_database/Models/singleMovieModel.dart';
// import 'package:movie_database/helper/theme/theme.dart';
// import 'package:movie_database/screens/Movies/singleMovie.dart';
// import 'package:swipeable_tile/swipeable_tile.dart';

// class AddList extends StatefulWidget {
//   AddList({Key? key}) : super(key: key);

//   @override
//   _AddListState createState() => _AddListState();
// }

// class _AddListState extends State<AddList> {

//   final LocalStorage storage = new LocalStorage("downloads");

//   List localStoredAddList=[];

//   @override
//   void initState() {    
//     super.initState();
//     Future.delayed(Duration(milliseconds: 1000),(){
//      fatchLocalAddlist();
//     });
    
//   }



// ///for fatch list from local storage

//   fatchLocalAddlist() async {
//     var res = await storage.getItem("addToList");
//     print({["fatchLocalAddlist",res]});
//     if(mounted && res !=null){
//       setState(() {
//         localStoredAddList = res;
//       });
//     }
//   }

// //for delete item from local storage 

// deleteAddList(imdbId) async {
//   List res = await storage.getItem("addToList");
//   res.removeWhere((element) {
//     SingleMovieModel re = SingleMovieModel.fromJson(jsonDecode(element));
//     return re.imdbId = imdbId;
//   });
//   Future.delayed(Duration(milliseconds: 2000),(){
//     storage.setItem("addToList", res);
//   });
//   setState(() {});
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(
//         actions: [
//           Tooltip(
//             message: "for Delete Swipe Left",
//             child: Container(
//                 margin: EdgeInsets.only(right: 10), child: Icon(Icons.help)),
//             waitDuration: Duration(milliseconds: 10),
//             showDuration: Duration(seconds: 3),
//             triggerMode: TooltipTriggerMode.tap,
//           ),
          
//         ],
//         title: Text(
//           "List",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.black54,
//       ),
//       body:  Container(
//         padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//           image: NetworkImage(
//               "https://static.pexels.com/photos/1526/dark-blur-blurred-gradient-landscape.jpg"),
//           fit: BoxFit.fill,
//         )),
//         child: localStoredAddList.isEmpty ?  Center(child: Text("Empty",style: TextStyle( color: white,fontSize: 020,fontWeight: FontWeight.bold),),)  :
        
//         SingleChildScrollView(
//           child: Column(
//               children: localStoredAddList.map((e) {
//             SingleMovieModel? localMovie =
//                 SingleMovieModel.fromJson(jsonDecode(e));
//             return Column(
//               children: [
                
//                 InkWell(                  
//                   child: downloadItem(context, localMovie),
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => SingleMovie(movieId: localMovie.imdbId, movieTitle: localMovie.title)));
//                   },
//                 ),
//                 Divider(
//                   color: Colors.grey[300],
//                 ),
//               ],
//             );
//           }).toList()),
//         ),
//       ),
//     );
//   }

//   Container downloadItem(BuildContext context, SingleMovieModel localMovie) {
//     return Container(
//               padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//               child: Dismissible(
//                 key: UniqueKey(),
//                 direction: DismissDirection.endToStart,
//                 resizeDuration: Duration(milliseconds: 2),
//                 onDismissed: (DismissDirection direction){
//                   if(direction==DismissDirection.endToStart){
//                     showDialog(      
//                        context: context, 
//                       builder: (context){
//                       return  AlertDialog(
//                           title: Text("Are you Sure ?",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
//                           actions: [
//                             TextButton(onPressed: (){Navigator.of(context).pop(false);setState(() {});}, child: Text("No",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
//                             TextButton(onPressed: (){deleteAddList(localMovie.imdbId);setState(() {Navigator.of(context).pop(false);});}, child: Text("Yes",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
//                           ],
//                         );
//                       }                
//                     );
//                   }
//                   setState(() {
                    
//                   });
//                 },
//                 background: Container(),
//                 secondaryBackground:  Container(
//                   child: Center(
//                     child: Text(
//                       'Delete',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   color: Colors.red,
//                 ),

//                 child:  ListTile(
//                 leading: Image.network(localMovie.imageUrl.toString()),
//                 title: Text("${localMovie.title}",
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     )),
//                 trailing: Icon(Icons.chevron_right,color: white,size: 35,),
//               ),
//               ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:localstorage/localstorage.dart';
import 'package:movie_database/Models/singleMovieModel.dart';
import 'package:movie_database/helper/theme/theme.dart';
import 'package:movie_database/screens/Movies/singleMovie.dart';

class AddList extends StatefulWidget {
  AddList({Key? key}) : super(key: key);

  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  final LocalStorage storage = new LocalStorage('downloads');
  List localStoredFavourite = [];

  @override
  void initState() {
    super.initState();
  Future.delayed(Duration(milliseconds: 1000),(){
  
    fatchLocalAddlist();
   
  });}

  fatchLocalAddlist() async {
    var res = await storage.getItem("addToList");
    print(['fatchLocalAddlist',res]);
    if (mounted && res != null) {
      setState(() {
        localStoredFavourite = res;
      });
    }
  }

  delete(imdbId) async {
    //delete file local

    List res = await storage.getItem("addToList");    
    
    res.removeWhere((element) {
      SingleMovieModel s = SingleMovieModel.fromJson(jsonDecode(element));
      return s.imdbId == imdbId;
    });

  Future.delayed(Duration(milliseconds: 2000),(){
  storage.setItem("addToList", res);
  });
    setState(() {});
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Tooltip(
            message: "for Delete Swipe Left",
            child: Container(
                margin: EdgeInsets.only(right: 10), child: Icon(Icons.help)),
            waitDuration: Duration(milliseconds: 10),
            showDuration: Duration(seconds: 3),
            triggerMode: TooltipTriggerMode.tap,
          ),
          
        ],
        title: Text(
          "List",
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
        child: localStoredFavourite.isEmpty ?  Center(child: Text("Empty",style: TextStyle( color: white,fontSize: 020,fontWeight: FontWeight.bold),),)  :
        
        SingleChildScrollView(
          child: Column(
              children: localStoredFavourite.map((e) {
            SingleMovieModel? localMovie =
                SingleMovieModel.fromJson(jsonDecode(e));
            return Column(
              children: [
                
                InkWell(                  
                  child: downloadItem(context, localMovie),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SingleMovie(movieId: localMovie.imdbId, movieTitle: localMovie.title)));
                  },
                ),
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
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                resizeDuration: Duration(milliseconds: 2),
                onDismissed: (DismissDirection direction){
                  if(direction==DismissDirection.endToStart){
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
                  }
                  setState(() {
                    
                  });
                },
                background: Container(),
                secondaryBackground:  Container(
                  child: Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: Colors.red,
                ),

                child:  ListTile(
                leading: Image.network(localMovie.imageUrl.toString()),
                title: Text("${localMovie.title}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                trailing: Icon(Icons.chevron_right,color: white,size: 35,),
              ),
              ),
    );
  }                
}