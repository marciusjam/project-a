import 'package:Makulay/screens/post_viewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PodcastCard extends StatelessWidget {
  final String description;
  final Map<String, String> content;
  final String username;
  final String? profilepicture;
  final int postage;
  final bool preview;
  final AssetEntity? previewcontent;
  const PodcastCard(this.description, this.content, this.username,
      this.profilepicture, this.postage, this.preview, this.previewcontent,
      {Key? key})
      : super(key: key);

  final double elavationVal = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostViewer(imageUrl: content.entries.first.value, orientation: 'horizontal',),
              ),
            );
          },
          child:
      Card(
          surfaceTintColor: Colors.white, //IOS
          elevation: elavationVal,
          color: Colors.white,
          shape: new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.white12, width: .3),
            borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
          ),
          child: Padding(
              padding: const EdgeInsets.all(0),
              child: Stack(children: [
                Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //const SizedBox(height: 10),

                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 140,
                                    height: 140,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: CachedNetworkImage(
                                            //key: globalImageKey,
                                            imageUrl:
                                                content.entries.first.value,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Container(
                                                  height: double.infinity,
                                                  //height: 600,
                                                  width: double.infinity,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            height: double.infinity,
                                            //height: 600,
                                            width: double.infinity,
                                            fit: BoxFit.cover)),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Container(
                                      width: 140,
                                      height: 140,
                                      color: Color.fromRGBO(00, 00, 00, 0.25),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    left: 5,
                                    child: CircleAvatar(
                                        radius: 15,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                profilepicture!)),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: Text(
                                      '🎧' + postage.toString(),
                                      style: TextStyle(
                                          //color: Colors.grey,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Icon(Icons.play_arrow, color: Colors.white,),
                                  )
                                ],
                              ))
                        ]),
                  ],
                )
              ]))),
   )]));
  }
}
