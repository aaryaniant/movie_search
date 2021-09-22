import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String? videoUrl;

  VideoPlayerScreen({Key? key,required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  

  YoutubePlayerController? _controller ;
@override
  void initState() {
    super.initState();
 if(mounted){
  String?  myVideoId = widget.videoUrl.toString().split("/").toList().last;
    _controller = YoutubePlayerController(
    initialVideoId: myVideoId,
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,

    ),
  );

 }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
//       appBar: AppBar(
//         leading:IconButton(onPressed: (){
// setState(() {
//   print(_controller!.initialVideoId);

// });

//         }, icon: Icon(Icons.refresh))
//       ),
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: YoutubePlayer(
            controller: _controller!,
            liveUIColor: Colors.amber,
          ),
        ),
        
        //  child: WebView(
        //    initialUrl: widget.videoUrl.toString(),
        //    javascriptMode: JavascriptMode.unrestricted,
        //    allowsInlineMediaPlayback:true,
        //    initialMediaPlaybackPolicy:AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
        //   onWebViewCreated: (WebViewController webViewController) {
        //     _controller.complete(webViewController);
        //   },
        //   onProgress: (int progress) {
        //     print("WebView is loading (progress : $progress%)");
        //   },
        //  ),
      ),
    );
  }
}