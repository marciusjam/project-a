import 'package:Makulay/widgets/custom_videoplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class VideoCardVert extends StatelessWidget {
  final String description;
  final String username;
  final String? profilepicture;
  final Map<String, String> content;
  const VideoCardVert(this.description, this.content, this.username, this.profilepicture, {Key? key}) : super(key: key);
  final double elavationVal = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Card(
          elevation: elavationVal,
          shape: new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.black, width: .3),
            borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
          ),
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomVideoPlayer(
                    'vertical', content.entries.first.value, 9 / 16, description, username, profilepicture),
              ],
            )
          ])),
    ]));
  }
}
