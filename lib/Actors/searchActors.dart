// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:movie_database/helper/theme/theme.dart';
// import 'package:movie_database/store/appState.dart';
// import '/store/action.dart' as action;
// import '../../main.dart';

// class SearchActors extends StatefulWidget {
  
//   SearchActors({Key? key,}) : super(key: key) ;

//   @override
//   _SearchActorsState createState() => _SearchActorsState();
// }

// class _SearchActorsState extends State<SearchActors> {
//   TextEditingController _searchController = TextEditingController();
//   @override
//   void initState() {    
//     super.initState();
   
//   }
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState,AppState>(
//       converter: (store)=>store.state,
//       builder: (context,state){
//         // print(["store.state.searchActorsModel!.result",store.state.searchActorsModel!.actors]);
//         return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar:AppBar(            
//             elevation: 10,
//             backgroundColor: Colors.black,
//             shadowColor: Colors.grey,
//             centerTitle: true,
//             title: TextField(
//               onChanged: (value){
               
//                },
//               controller: _searchController,
//               style:TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintStyle: TextStyle(color: Colors.white),
//                 hintText: "Search here...",
//                 fillColor: Colors.red,
//               ),
//             ),
//             actions: [ 
//               IconButton(onPressed: (){
//              _searchController.text.contains(" ") && _searchController.text.length > 5 ?   store.dispatch(action.fetchSearchActor(context, _searchController.text.trim())): print("");
//               }, icon: Icon(Icons.search),),
//             ],
//           ),
//         body: Container(
//           padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//           width: MediaQuery.of(context).size.width,   
       
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: NetworkImage("https://static.pexels.com/photos/1526/dark-blur-blurred-gradient-landscape.jpg"),
//               fit: BoxFit.fill,
//             )
//           ),  
//           child: 
//           store.state.searchActorsModel!.actors == null ?  Container(
//                height:  MediaQuery.of(context).size.height,
//             child: Center(child: Text("Search here"))) :
//           // (store.state.loader!.showLoader) as bool ||  store.state.searchActorsModel!.actors!.isEmpty ?  Container(
//           //                 height: MediaQuery.of(context).size.height / 1.2,
//           //                 child: Center(
//           //                   child: Container(
//           //                       height: 30,
//           //                       width: 30,
//           //                       child: CircularProgressIndicator(
//           //                         color: Color(0xffe41212),
//           //                         strokeWidth: 2,
//           //                       )),
//           //                 ),
//           //               )  :
//            StaggeredGridView.countBuilder(            
//              mainAxisSpacing: 20,
//              crossAxisSpacing: 10,
//             itemCount: store.state.searchActorsModel!.actors!.length,
//             crossAxisCount: 2,
//             staggeredTileBuilder:  (index) {
//               return StaggeredTile.count(1 , 1.7);
//             },
              
//             itemBuilder: (context,index){
//               var item = store.state.searchActorsModel!.actors![index];
             
//                return 
//             // item.imgUrl.toString() == "aa.com"  ? Container()  :
//            !item.name!.toLowerCase().contains( _searchController.text.toLowerCase().trim()) ? Container():
           
//               Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: 280,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: item.imgUrl == null ? NetworkImage("https://shenandoahcountyva.us/bos/wp-content/uploads/sites/4/2018/01/picture-not-available-clipart-12.jpg") :
//                             NetworkImage(item.imgUrl.toString()),
//                             fit: BoxFit.fill,
//                           )
//                         ),
//                         // child: Image.network(item.imgUrl.toString(),height: 250,)
//                       ),
//                       SizedBox(height: 8,),
//                       Text(item.name.toString(),overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: white),),
//                     ],
//                   ),
//                 );
            
//             },
//           ),
//         ),
//       ),
//     );
//    }  
//  );
// } }









