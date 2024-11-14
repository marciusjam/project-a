import 'package:Makulay/models/Model_Series.dart';
import 'package:Makulay/screens/chat_page.dart';
import 'package:Makulay/widgets/post_widgets/imagecard_horiz.dart';
import 'package:Makulay/widgets/post_widgets/imagecard_vert.dart';
import 'package:Makulay/widgets/post_widgets/live_horiz_card.dart';
import 'package:Makulay/widgets/post_widgets/podcast_card.dart';
import 'package:Makulay/widgets/post_widgets/series.dart';
import 'package:Makulay/widgets/post_widgets/text_post.dart';
import 'package:Makulay/widgets/post_widgets/trending_card.dart';
import 'package:Makulay/widgets/post_widgets/videocard_horiz.dart';
import 'package:Makulay/widgets/post_widgets/videocard_vert.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final String type;
  final String description;
  final Map<String, String> content;
  final String username;
  final String? profilepicture, previewvideopath;
  final int postage;
  final bool preview;
  final AssetEntity? previewcontent;
  const PostCard(this.type, this.description, this.content, this.username, this.profilepicture, this.postage, this.preview, this.previewcontent, this.previewvideopath, {Key? key}) : super(key: key);
 

  @override
  State<PostCard> createState() => _PostCardState();
}

ScrollController scrollController = ScrollController(
  initialScrollOffset: 220, // or whatever offset you wish
  keepScrollOffset: true,
);

class _PostCardState extends State<PostCard> {
  late VideoPlayerController _controller;
  final double _iconSize = 20;

  late String profileUrl;

  final double elavationVal = 3;

   final List<SeriesModel> seriesList = [
    /*SeriesModel(
        media: 'assets/series_cover.jpg', username: 'John', series_cover: true),*/
    SeriesModel(
        media: ['assets/series_1.mp4',
        'assets/series_2.mp4','assets/series_3.mp4',
        'assets/series_4.mp4'], username: 'marciusjam', profilepicture: 'assets/profile-jam.jpg'),
    SeriesModel(
        media: ['assets/series_1.mp4',
        'assets/series_2.mp4','assets/series_3.mp4',
        'assets/series_4.mp4'], username: 'shayecrispo', profilepicture: 'assets/profile-shaye.jpg'),
    SeriesModel(
        media: ['assets/series_1.mp4',
        'assets/series_2.mp4','assets/series_3.mp4',
        'assets/series_4.mp4'], username: 'Sasuke', profilepicture: 'assets/profile-shaye.jpg'),
   SeriesModel(
        media: ['assets/series_1.mp4',
        'assets/series_2.mp4','assets/series_3.mp4',
        'assets/series_4.mp4'], username: 'Goku', profilepicture: 'assets/profile-shaye.jpg'),
    SeriesModel(
        media: ['assets/series_1.mp4',
        'assets/series_2.mp4','assets/series_3.mp4',
        'assets/series_4.mp4'], username: 'Luffy', profilepicture: 'assets/profile-shaye.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    /*debugPrint('Widget Checker!!');
    debugPrint('widget.type : ' + widget.type);
    debugPrint('widget.description : ' + widget.description);
    debugPrint('widget.content : ' + widget.content.toString());
    debugPrint('widget.username : ' + widget.username);
    debugPrint('widget.profilepicture : ' + widget.profilepicture.toString());
    debugPrint('widget.postage : ' + widget.postage.toString());
    debugPrint('widget.preview : ' + widget.preview.toString());*/
  }


Future<void> getFileUrl(String fileKey) async {
      try {
        final result = await Amplify.Storage.getUrl(
      key: fileKey,
      options: const StorageGetUrlOptions(
        accessLevel: StorageAccessLevel.guest,
        pluginOptions: S3GetUrlPluginOptions(
          expiresIn: Duration(days: 1),
        ),
      ),
    ).result;
        //debugPrint('result ' + result.url.toString());
        setState(() {
                profileUrl = result.url.toString();
              });
      } catch (e) {
        throw e;
      }
    }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    if (widget.type == 'series') {
      return _seriesContainer(
          context, MediaQuery.of(context).size.height, seriesList, widget.username, widget.profilepicture, widget.postage, widget.preview);
    } else {
      return Column(
        children: [
          _mainContainer(context, double.maxFinite, widget.description, widget.content, widget.username, widget.profilepicture, widget.postage, widget.preview, widget.previewcontent, widget.previewvideopath)

          /*Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.white, Colors.black38, Colors.white])),
          width: double.maxFinite,
          height: 7,
        ),*/
        ],
      );
    }
  }

  Container _mainContainer(BuildContext context, double widthToUse, String description, Map<String, String> content, String username, String? profilepicture, int postage, bool preview, AssetEntity? previewcontent, String? previewvideopath) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 15),
        //height: 250,
        color: Colors.white,
        width: widthToUse,
        //color: Colors.black,
        /*child: Dismissible(
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              debugPrint('Left');
              //Navigate to Comment Section
              return false;
            } else if (direction == DismissDirection.endToStart) {
              debugPrint('Right');
              //Navigate to Share Section
              return false;
            }
          },
          background: Container(
            padding: EdgeInsets.fromLTRB(30, 50, 15, 0),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Icon(Icons.chat_bubble_outline, color: Colors.amber),
                Text(
                  'Comment',
                  style: TextStyle(color: Colors.amber),
                )
              ],
            ),
          ),
          secondaryBackground: Container(
            padding: EdgeInsets.fromLTRB(15, 50, 30, 0),
            alignment: Alignment.centerRight,
            child: Column(
              children: [
                Icon(Icons.swap_horiz_outlined, color: Colors.amber),
                Text(
                  'Share',
                  style: TextStyle(color: Colors.amber),
                )
              ],
            ),
          ),
          key: Key('1'),*/
        child: _buildChild(context, description, content, username, profilepicture, postage, preview, previewcontent, previewvideopath) //),
        );
  }

  _seriesContainer(BuildContext context, double heigtToUse, List seriesLis, String username, String? profilepicture, int postage, bool preview) {
    return Container(
        color: Colors.white,
        //height: (heigtToUse / 1.47),
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: elavationVal,
              surfaceTintColor: Colors.white, //IOS
              shape: new RoundedRectangleBorder(
                side: new BorderSide(color: Colors.white, width: .3),
                borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
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
                                  backgroundImage:
                                      AssetImage('assets/profile-jam.jpg'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 125,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Marcius, Shaye, Mac and 5 others',
                                style: TextStyle(
                                    color: Colors.black,
                                    //color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Row(
                                children: [
                                  RichText(
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'added a new episode on',
                                          style: TextStyle(
                                              color: Colors.black,
                                              //color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(3, 0, 0, 0),
                                    child: RichText(
                                      textScaleFactor: MediaQuery.of(context)
                                          .textScaleFactor,
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Comedy Central',
                                            style: TextStyle(
                                                color: Colors.black,
                                                //color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                child: Text(
                                  postage.toString() + 'days ago',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      //color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ]),
            ),
            Container(
                padding: new EdgeInsets.fromLTRB(3, 0, 3, 0),
                height: heigtToUse / 2,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  controller: scrollController,
                  padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                  itemBuilder: (BuildContext context, int index) {
                    return Series(
                        seriesList: seriesList[index], indexLine: index, username: username, profilepicture: profilepicture, postage, preview); //),
                  },
                ))
          ],
        ));
  }

  Widget _buildChild(BuildContext context, String description, Map<String, String> content, String username, String? profilepicture, int postage, bool preview, AssetEntity? previewcontent, String? previewvideopath) {
    //debugPrint('postType: ' + widget.type);
    //debugPrint('_buildChild profilepic: ' + profilepicture!);
    if (widget.type == 'image-Horizontal') {
      return ImageCardHoriz(description, content, username, profilepicture, postage, preview, previewcontent);
    } else if (widget.type == 'image-Vertical') {
      return ImageCardVert(description, content, username, profilepicture, postage, preview, previewcontent);
    } else if (widget.type == 'textPost') {
      //debugPrint('profilepicture to use: ' + profilepicture);
      
      return TextPost(description, username, profilepicture, postage, preview, previewcontent);
    } else if (widget.type == 'video-Horizontal') {
      return VideoCardHoriz(description, content, username, profilepicture, postage, preview, previewvideopath);
    } else if (widget.type == 'video-Vertical') {
      return VideoCardVert(description, content, username, profilepicture, postage, preview, previewvideopath);
    } else if (widget.type == 'trends') {
      return TrendingCard(description, content, username, profilepicture, postage, preview, previewcontent);
    } else if (widget.type == 'podcasts') {
      return PodcastCard(description, content, username, profilepicture, postage, preview, previewcontent);
    } else if (widget.type == 'live-horiz') {
      return LiveHorizCard(description, content, username, profilepicture, postage, preview, previewcontent);
    } else {
      return TextPost(description, username, profilepicture, postage, preview, null);
    }
  }
}
