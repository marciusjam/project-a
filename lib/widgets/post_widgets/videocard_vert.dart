import 'package:Makulay/widgets/custom_videoplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_manager/photo_manager.dart';

class VideoCardVert extends StatelessWidget {
  final String description;
  final String username;
  final String? profilepicture;
  final Map<String, String> content;
  final int postage;
  final bool preview;
  final String? previewcontent;
  const VideoCardVert(this.description, this.content, this.username, this.profilepicture, this.postage, this.preview, this.previewcontent, {Key? key}) : super(key: key);
  final double elavationVal = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Card(
        surfaceTintColor: Colors.white,
          elevation: elavationVal,
          color: Colors.white,
          shape: new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.transparent, width: .3),
            borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
          ),
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                preview == false ? CustomVideoPlayer(
                    'vertical', content.entries.first.value, MediaQuery.sizeOf(context).height / 1.5, description, username, profilepicture, postage, null, preview, null, '20', '30', '50') :
                    CustomVideoPlayer(
                    'vertical', null, MediaQuery.sizeOf(context).height / 1.5, description, username, profilepicture, postage, previewcontent, preview, null, '20', '30', '50') 
              ],
            )
          ])),
    ]));
  }
}
