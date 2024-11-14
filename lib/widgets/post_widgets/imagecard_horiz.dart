import 'package:Makulay/screens/post_viewer.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class ImageCardHoriz extends StatelessWidget {
  final String description;
  final Map<String, String> content;
  final String username;
  final String? profilepicture;
  final int postage;
  final bool preview;
  final AssetEntity? previewcontent;
  const ImageCardHoriz(this.description, this.content, this.username,
      this.profilepicture, this.postage, this.preview, this.previewcontent,
      {Key? key})
      : super(key: key);

  final double elavationVal = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostViewer(imageUrl: content.entries.first.value, orientation: 'horizontal'),
              ),
            );
          },
          child:
        Card(
            elevation: elavationVal,
            surfaceTintColor: Colors.white, //IOS
            color: Colors.white,
            shape: new RoundedRectangleBorder(
              side: new BorderSide(color: Colors.white12, width: .3),
              borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: /*AspectRatio(
                      aspectRatio: 2/1, //3/2*/
                      Container(
                          height: MediaQuery.sizeOf(context).height / 3.5,
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ClipRRect(
                                  borderRadius: new BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                  child: preview == false
                                      ? CachedNetworkImage(
                                          //key: globalImageKey,
                                          imageUrl: content.entries.first.value,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Container(
                                                height: double.infinity,
                                                //height: 600,
                                                width: double.infinity,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          height: double.infinity,
                                          //height: 600,
                                          width: double.infinity,
                                          fit: BoxFit.cover)
                                      : Image(
                                          image: AssetEntityImageProvider(
                                              previewcontent!),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),

                                  /*Image.network(
                              globalImageUrl.toString(),
                              height: double.infinity,
                              //height: 600,
                              width: double.infinity,
                              fit: BoxFit.cover),*/
                                ),
                              ])),
                ),
                Padding(
                    padding: const EdgeInsets.all(15),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //const SizedBox(height: 10),

                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                          profilepicture!)), /*AssetImage(
                                                    'assets/profile-jam.jpg'),
                                              ),*/
                                           
                                  ),

                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: SizedBox(
                                        //width: MediaQuery.of(context).size.width - 125,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              username,
                                              style: TextStyle(
                                                  //color: Colors.black,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            RichText(
                                              textScaleFactor:
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: description,
                                                    style: TextStyle(
                                                        //color: Colors.black,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
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
                                                postage.toString() +
                                                    ' days ago',
                                                style: TextStyle(
                                                    //color: Colors.grey,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ]),

                            /*Container(
                          //width: 30,
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                          child: Text(
                            '10 mins ago',
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.normal,
                                fontSize: 10),
                          ),
                        ),*/

                            //Spacer(),
                            preview == false
                                ? Container(
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
                                                      10, 0, 10, 0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 10, 0, 0),
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
                                                                //color:Colors.black12,
                                                                color: Colors
                                                                    .black12,
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
                                                                    '32',
                                                                    style: TextStyle(
                                                                        //color: Colors.grey,
                                                                        color: Colors.grey,
                                                                        fontWeight: FontWeight.normal,
                                                                        fontSize: 15))),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 10, 0, 0),
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
                                                                //color:Colors.black12,
                                                                color: Colors
                                                                    .black12,
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
                                                                        //color: Colors.grey,
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.normal,
                                                                        fontSize: 15))),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 10, 0, 0),
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
                                                                    //color: Colors.black12,
                                                                    color: Colors
                                                                        .black12,
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
                                                                        '1.2k',
                                                                        style: TextStyle(
                                                                            //color: Colors.grey,
                                                                            color: Colors.grey,
                                                                            fontWeight: FontWeight.normal,
                                                                            fontSize: 15))),
                                                              ],
                                                            ))),
                                                  ]))
                                        ]))
                                : Container()
                          ],
                        ),
                      ],
                    ))
              ],
            ))
        //Divider( thickness: 5, color: Colors.black12)
        )],
    ));
  }
}
