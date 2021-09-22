import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_database/screens/homePage.dart';
import '/store/action.dart' as action;
import '../main.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {    
    super.initState();

      store.dispatch(action.fetchUpcomingMovies(context, 7));
    store.dispatch(action.fetchLatestMovies(context, 20));
    Timer(Duration(seconds: 5), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage("assets/image/splashScreen.png"),
             fit: BoxFit.fill,
           ),
         ),
       ),
    );
  }
}