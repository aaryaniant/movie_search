import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_database/screens/homePage.dart';
import 'package:movie_database/splash%20screen/splashScreen.dart';
import 'package:movie_database/store/appState.dart';
import 'package:movie_database/store/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import '/store/action.dart' as action;
import 'helper/theme/theme.dart';


//redux
final store = Store<AppState>(appReducer,
    middleware: [thunkMiddleware], initialState: AppState.initial());

Color? mainColor, mainColorA, secondColor;

Future setColors() async {
  mainColor = lightBlack; //Color.fromRGBO(mcr, mcg, mcb, mca); //ecc55d
  mainColorA = Color(0xfffff8f7);
  secondColor = Color(0xffe41212); //Color.fromRGBO(scr, scg, scb, sca);
}
Future<void> main() async {
  await setColors();
   //lock orientation
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(
    StoreProvider(store: store, child: MyApp())
    );
}

class MyApp extends StatefulWidget {
 
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 @override
  void initState() {
      store.dispatch(action.fetchGenere(context));
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(

       builder: (context, widget) => ResponsiveWrapper.builder(
          widget,
          maxWidth: 1200,
          minWidth: 400,
          defaultScale: true,
          
          breakpoints: [
            ResponsiveBreakpoint.resize(400, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
     
      title: 'Flutter Demo',
     theme: _buildShrineTheme(),
      home: SplashScreen(),
    );
  }

  ThemeData _buildShrineTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      accentColor: mainColor,
      primaryColor: mainColor,
      buttonTheme: buttonThemeData,
      buttonBarTheme: base.buttonBarTheme.copyWith(
        buttonTextTheme: ButtonTextTheme.accent,
      ),
      
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      textTheme: getTextTheme(base.primaryTextTheme),
      primaryTextTheme: getTextTheme(base.primaryTextTheme).apply(
        bodyColor: mainColor,
        displayColor: mainColor,
      ),
      accentTextTheme: textTheme,
      errorColor: Colors.red[400],
    );
  }
}



