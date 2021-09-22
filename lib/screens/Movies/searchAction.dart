import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_database/Models/searchModel.dart';
import 'package:movie_database/helper/theme/theme.dart';
import 'package:movie_database/screens/Movies/singleMovie.dart';
import 'package:movie_database/store/appState.dart';
import '/store/action.dart' as action;
import '../../main.dart';

class SearchAction extends StatefulWidget {
  
  SearchAction({Key? key,}) : super(key: key) ;

  @override
  _SearchActionState createState() => _SearchActionState();
}

class _SearchActionState extends State<SearchAction> {
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {    
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,AppState>(
      converter: (store)=>store.state,
      builder: (context,state){
        print(["store.state.searchModel!.result",store.state.searchModel!.result]);
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
            centerTitle: true,
            title: TextField(
              onChanged: (value){
                if(value.isNotEmpty){
                 
               }
               },
              controller: _searchController,
              style:TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: "Search here...",
                fillColor: Colors.red,
              ),
            ),
            actions: [ 
              IconButton(onPressed: (){
                store.dispatch(action.fetchSearchTitle(context, _searchController.text.trim()));
              }, icon: Icon(Icons.search),),
            ],
          ),
        // ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          width: MediaQuery.of(context).size.width,   
       
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://static.pexels.com/photos/1526/dark-blur-blurred-gradient-landscape.jpg"),
              fit: BoxFit.fill,
            )
          ),  
          child: store.state.searchModel!.result == null ?  Container(
               height:  MediaQuery.of(context).size.height,
            child: Center(child: Text("Search here"))) :
          (store.state.loader!.showLoader) as bool ||  store.state.searchModel!.result!.isEmpty ?  Container(
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: Center(
                            child: Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Color(0xffe41212),
                                  strokeWidth: 2,
                                )),
                          ),
                        )  :
           StaggeredGridView.countBuilder(            
             mainAxisSpacing: 20,
             crossAxisSpacing: 10,
            itemCount: store.state.searchModel!.result!.length,
            crossAxisCount: 2,
            staggeredTileBuilder:  (index) {
              return StaggeredTile.count(1 , 1.7);
            },
              
            itemBuilder: (context,index){
              var item = store.state.searchModel!.result![index];
             
               return 
            // item.imgUrl.toString() == "aa.com"  ? Container()  :
           !item.title!.toLowerCase().contains( _searchController.text.toLowerCase().trim()) ? Container():
             InkWell(
              onTap: (){
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 280,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(item.imgUrl.toString()),
                            fit: BoxFit.fill,
                          )
                        ),
                        // child: Image.network(item.imgUrl.toString(),height: 250,)
                      ),
                      SizedBox(height: 8,),
                      Text(item.title.toString(),overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: white),),
                    ],
                  ),
                ),
            );
            },
          ),
        ),
      ),
    );
   }  
 );
} }









