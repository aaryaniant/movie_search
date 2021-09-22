import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_database/helper/theme/theme.dart';
import 'package:movie_database/main.dart';
import 'package:movie_database/screens/Movies/download.dart';
import 'package:movie_database/screens/Movies/more.dart';

import 'Movies/dicover.dart';
import 'Movies/moviesHome.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState();
  }
}
 
class _MyHomePageState extends State<MyHomePage> {
 var _selectedIndex = 0;
  final _selectedItemColor = secondColor;
  final _unselectedItemColor = Color(0xffa0a0a6);
  final _selectedBgColor = mainColor;
  final _unselectedBgColor = mainColor;

  Color? _getBgColor(int index) =>
      _selectedIndex == index ? _selectedBgColor : _unselectedBgColor;

  Color? _getItemColor(int index) =>
      _selectedIndex == index ? _selectedItemColor : _unselectedItemColor;

  Widget _buildIcon(String iconData, String text, int index) => Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Material(
          color: _getBgColor(index),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Icon(iconData),
                Padding(
                  padding: EdgeInsets.only(top: 2.0, bottom: 4.0),
                  child: 
                  Image.asset(
                    iconData,
                    height: 22.0,
                    color: _getItemColor(index)
                  ),
                ),
                Text(text,
                    textScaleFactor: 1.0,
                    style:
                        TextStyle(fontSize: 12, color: _getItemColor(index))),
              ],
            ),
            onTap: () => _onItemTapped(index),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onWillPop(index) {
    print(['index', index]);
    if (index == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return 
            AlertDialog(
              title: Text(
                'Are you sure?',
                style: TextStyle(color: Colors.black),
              ),
              content: Text('You are going to exit the application.'),
              actions: <Widget>[
                TextButton(
                  child: Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text('YES'),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            );
          });
    } else {
      setState(() {
        _selectedIndex = 0;
      });
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: WillPopScope(
        onWillPop: () => onWillPop(_selectedIndex),
        child: Scaffold(
          body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: _getBody(_selectedIndex)),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: _buildIcon("assets/icons/home.png", "Home", 0),
                  label: ""),
              BottomNavigationBarItem(
                  icon: _buildIcon("assets/icons/discover.png", "Discover", 1),
                  label: ""),
              BottomNavigationBarItem(
                  icon: _buildIcon("assets/icons/download.png", "Download", 2),
                  label: ""),
              BottomNavigationBarItem(
                  icon:
                      _buildIcon("assets/icons/more.png", "More", 3),
                  label: ""),
             
            ],
            selectedFontSize: 0,
            currentIndex: _selectedIndex,
            selectedItemColor: _selectedItemColor,
            unselectedItemColor: _unselectedItemColor,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return Movies();

      case 1:
        return Discover();

      case 2:
        return Download();
      case 3:
        return More();
    
      default:
        return Center(
          child: Text(
            "Not implemented!",
            textScaleFactor: 1.0,
          ),
        );
    }
  }
}





// import 'package:flutter/material.dart';
// import 'package:share/share.dart';

// class DemoApp extends StatefulWidget {
//   @override
//   DemoAppState createState() => DemoAppState();
// }

// class DemoAppState extends State<DemoApp> {
//   String text = '';
//   String subject = '';
//   List<String> imagePaths = [];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Share Plugin Demo',
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Share Plugin Demo'),
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   TextField(
//                     decoration: const InputDecoration(
//                       labelText: 'Share text:',
//                       hintText: 'Enter some text and/or link to share',
//                     ),
//                     maxLines: 2,
//                     onChanged: (String value) => setState(() {
//                       text = value;
//                     }),
//                   ),
//                   TextField(
//                     decoration: const InputDecoration(
//                       labelText: 'Share subject:',
//                       hintText: 'Enter subject to share (optional)',
//                     ),
//                     maxLines: 2,
//                     onChanged: (String value) => setState(() {
//                       subject = value;
//                     }),
//                   ),
                 
//                   const Padding(padding: EdgeInsets.only(top: 12.0)),
//                   Builder(
//                     builder: (BuildContext context) {
//                       return ElevatedButton(
//                         child: const Text('Share'),
//                         onPressed: text.isEmpty && imagePaths.isEmpty
//                             ? null
//                             : () => _onShare(context),
//                       );
//                     },
//                   ),
                 
//                 ],
//               ),
//             ),
//           )),
//     );
//   }

  

//   _onShare(BuildContext context) async {
  
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

 
// }