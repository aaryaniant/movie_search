import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LocalVideoPlayer extends StatefulWidget {
  final String? imdbId;

  LocalVideoPlayer({Key? key,required this.imdbId}) : super(key: key);

  @override
  _LocalVideoPlayerState createState() => _LocalVideoPlayerState();
}

class _LocalVideoPlayerState extends State<LocalVideoPlayer> {
  
  String? localVideoPath;
   VideoPlayerController? _videoPlayerController;
@override
  void initState() {
    super.initState();
    playVideo();
  }
playVideo() async {
  if(mounted){
  String?  imdbId = widget.imdbId;

var tempDir = await getExternalStorageDirectory();
 String fullPath = tempDir!.path + "/$imdbId.mp4";
  File file = File(fullPath);
 
  
 setState(() {
     _videoPlayerController = VideoPlayerController.file(file);
 });
Future.delayed(Duration(seconds: 3),(){
  _videoPlayerController!.initialize().then((value) => _videoPlayerController!.play());
});
 }

}


 @override
  void dispose() {
    _videoPlayerController!.removeListener(() {});
    _videoPlayerController!.dispose();
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
          child:   _videoPlayerController != null 
                ?  AspectRatio(
              aspectRatio: _videoPlayerController!.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_videoPlayerController!),
                  _ControlsOverlay(controller: _videoPlayerController),
                  VideoProgressIndicator(_videoPlayerController!, allowScrubbing: true),
                ],
              ),
            )
                : Container(),
        ),
      
      ),
    );
  }
}











//////controls over lay
///
class _ControlsOverlay extends StatefulWidget {
   final VideoPlayerController? controller;

  _ControlsOverlay({Key? key,required this.controller}) : super(key: key);



  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
    static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 500),
          child: widget.controller!.value.isPlaying
              ? Container(width: 0,)
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                    Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              
            
            widget.controller!.value.isPlaying ? widget.controller!.pause() : widget.controller!.play();
            });
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: widget.controller!.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              widget.controller!.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Container(
              
                child: Text('${widget.controller!.value.playbackSpeed}x',style:TextStyle(   color: Colors.white,))),
            ),
          ),
        ),
      ],
    );
  }
}