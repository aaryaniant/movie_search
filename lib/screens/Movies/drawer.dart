import 'package:flutter/material.dart';

import 'addList.dart';
import 'download.dart';
import 'favourite.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return  Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration:  BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff4f5f5d),Color(0xffb3bdba),Color(0xff4b4d47),Color(0xff293737)],
                      end: Alignment.bottomLeft,
                      begin: Alignment.topLeft ,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(       
                        style: ButtonStyle(          
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)),                
                          shadowColor: MaterialStateProperty.all(Colors.transparent),
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Download()));
                        }, 
                        child: Center(child: Text("Downloads",textAlign:TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                      ),
                      Divider(color: Colors.grey[300],),
                      ElevatedButton(       
                        style: ButtonStyle(          
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)),                
                          shadowColor: MaterialStateProperty.all(Colors.transparent),
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Favourite()));
                        }, 
                        child: Container(
                                               
                          child: Text("Favourite",textAlign:TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        
                        ),
                      ),
                      Divider(color: Colors.grey[300],),
                      ElevatedButton(       
                        style: ButtonStyle(          
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10)),                
                          shadowColor: MaterialStateProperty.all(Colors.transparent),
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddList()));
                        }, 
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,                          
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Text("List",textAlign:TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey[200],),
                    ],
                  ),
              );
  }
}