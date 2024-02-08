import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videotype;
  final String video;
  final double size;
  final String description;
  final String username;
  final String? profilepicture;

  const CustomVideoPlayer(this.videotype, this.video, this.size, this.description, this.username, this.profilepicture, {Key? key})
      : super(key: key);

  

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  
  @override
  void initState() {
    super.initState();
    Uri videoUrl = Uri.parse(widget.video.toString());
    _controller = VideoPlayerController.networkUrl(
      videoUrl,
      //'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      //'https://www.tiktok.com/@redbedonia_/video/7034010235475987739',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.pause();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double controlsBorder;
    if (widget.videotype == 'horizontal') {
      //video = 'assets/horizvideo.mp4';
      //size = 16 / 9;
    }
    if (widget.videotype == 'vertical') {
      //video == 'assets/vertvideo.mp4';
      //size == 4 / 5;
    }
    if (widget.videotype == 'vertical' || widget.videotype == 'series') {
      controlsBorder = 5;
    } else {
      controlsBorder = 0;
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            //padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: widget.size,
              /*Container(
              height: 300,
              width: double.infinity,*/
              //aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  if (widget.videotype == 'horizontal')
                    ClipRRect(
                      borderRadius: new BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                      child: VideoPlayer(_controller),
                    ),
                  if (widget.videotype == 'vertical' ||
                      widget.videotype == 'series')
                    ClipRRect(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(10.0)),
                      child: VideoPlayer(_controller),
                    ),
                  if (widget.videotype == 'vertical' ||
                      widget.videotype == 'series')
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //const SizedBox(height: 10),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: SizedBox(
                                          width: 45,
                                          height: 45,
                                          child: InkWell(
                                            onTap: () => {},
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.amber,
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage: CachedNetworkImageProvider(widget.profilepicture!)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: SizedBox(
                                            //MediaQuery.of(context).size.width - 125,

                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.username,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                RichText(
                                                  textScaleFactor:
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: widget.description,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 3, 0, 0),
                                                  child: Text(
                                                    '1 day ago',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 11),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ]),
                                Container(
                                    height: 40,

                                    //color: Colors.black.withOpacity(0.5),
                                    //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          /**/
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 10, 0, 0),
                                                      child: SizedBox(
                                                        width: 70,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Icon(
                                                                Icons
                                                                    .chat_bubble_outline,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                    '1.2k',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            15))),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 10, 0, 0),
                                                      child: SizedBox(
                                                        width: 70,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Icon(
                                                                Icons
                                                                    .favorite_outline,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                    '20',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            15))),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 10, 0, 0),
                                                        child: SizedBox(
                                                            width: 70,
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .swap_horiz_outlined,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                        '104',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.normal,
                                                                            fontSize: 15))),
                                                              ],
                                                            ))),
                                                  ]))
                                        ])),
                              ],
                            ),
                          ],
                        )),
                  _ControlsOverlay(controller: _controller),
                  if (widget.videotype == 'horizontal')
                    ClipRRect(
                      borderRadius: new BorderRadius.only(
                          bottomRight: Radius.circular(controlsBorder),
                          bottomLeft: Radius.circular(controlsBorder)),
                      child: VideoProgressIndicator(_controller,
                          allowScrubbing: true),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

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

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: new BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 50),
            reverseDuration: Duration(milliseconds: 200),
            child: controller.value.isPlaying
                ? SizedBox.shrink()
                : Container(
                    color: Colors.black26,
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 100.0,
                        semanticLabel: 'Play',
                      ),
                    ),
                  ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        /*Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
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
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),*/
      ],
    );
  }
}
