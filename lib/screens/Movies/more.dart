import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:movie_database/Actors/searchActors.dart';
import 'package:movie_database/helper/theme/theme.dart';
import 'package:movie_database/screens/Movies/addList.dart';

import 'favourite.dart';

class More extends StatefulWidget {
  More({Key? key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.black54,
         title: Text("More",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
       ),
       body: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          width: MediaQuery.of(context).size.width,   
       
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://static.pexels.com/photos/1526/dark-blur-blurred-gradient-landscape.jpg"),
              fit: BoxFit.fill,
            )
          ),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  series(context),
                  InkWell(
                    onTap:(){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchActors()));
                    },
                    child: actors(context),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              favourite(),
              SizedBox(height: 20,),
              addToList(),
            ],
          ), 
       ),
    );
  }
 



 //Favourite,
 Widget favourite() {
   return InkWell(
     onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context) => Favourite()));
     },
     child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Colors.grey.shade300,Colors.grey.shade600,Colors.grey.shade900],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffff375f),
                          offset: Offset(0,3),
                          spreadRadius: 1,
                          blurRadius: 3,
                        )
                      ]
                    ),
                    child: Center(
                      child: Text("Favourites",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: white),),
                    ),
                  ),
   );
 }
 ///Actors,
  Container actors(BuildContext context) {
    return Container(
                  width: MediaQuery.of(context).size.width/2.2,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Colors.grey.shade300,Colors.grey.shade600,Colors.grey.shade900],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffff375f),
                        offset: Offset(0,3),
                        spreadRadius: 1,
                        blurRadius: 3,
                      )
                    ]
                  ),
                  child: Center(
                    child: Text("Actors",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: white),),
                  ),
                );
  }


///Series,
  Container series(BuildContext context) {
    return Container(
                  width: MediaQuery.of(context).size.width/2.2,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Colors.grey.shade300,Colors.grey.shade600,Colors.grey.shade900],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffff375f),
                        offset: Offset(0,3),
                        spreadRadius: 1,
                        blurRadius: 3,
                      )
                    ]
                  ),
                  child: Center(
                    child: Text("Series",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: white),),
                  ),
                );
  }

 //AddList
 Widget addToList() {
   return InkWell(
     onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context) => AddList()));
     },
     child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Colors.grey.shade300,Colors.grey.shade600,Colors.grey.shade900],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffff375f),
                          offset: Offset(0,3),
                          spreadRadius: 1,
                          blurRadius: 3,
                        )
                      ]
                    ),
                    child: Center(
                      child: Text("List",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: white),),
                    ),
                  ),
   );
 }

}