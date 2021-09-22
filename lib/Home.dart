// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:movie_database/screens/Movies/moviesHome.dart';

// class Home extends StatefulWidget {
//   Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home"),
//       ),
//       body: Container(
//         color: Colors.black54,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [_movies(), _series(), _actors()],
//         ),
//       ),
//     );
//   }

//   Widget _movies() {
//     return InkWell(
//       onTap: (){
//         Navigator.push(context, 
//         MaterialPageRoute(builder: (context) => Movies()),
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//             color: Colors.purpleAccent,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 spreadRadius: 2,
//                 offset: Offset(0, 3),
//               )
//             ]),
//         height: 200,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.local_movies_outlined,
//               size: 150,
//             ),
//             Text(
//               "Movies",
//               style: TextStyle(
//                   color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _series() {
//     return Container(
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//           color: Colors.purpleAccent,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               spreadRadius: 2,
//               offset: Offset(0, 3),
//             )
//           ]),
//       height: 200,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.movie_filter,
//             size: 150,
//           ),
//           Text(
//             "Series",
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _actors() {
//     return Container(
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//           color: Colors.purpleAccent,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               spreadRadius: 2,
//               offset: Offset(0, 3),
//             )
//           ]),
//       height: 200,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.star_half_outlined,
//             size: 150,
//           ),
//           Text(
//             "Actors",
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
//           ),
//         ],
//       ),
//     );
//   }
// }
