import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class TrendingCard extends StatelessWidget {
  final String description;
  final Map<String, String> content;
  final String username;
  final String? profilepicture;
  final int postage;
  final bool preview;
  final AssetEntity? previewcontent;
  const TrendingCard(this.description, this.content, this.username,
      this.profilepicture, this.postage, this.preview, this.previewcontent,
      {Key? key})
      : super(key: key);

  final double elavationVal = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Card(
          surfaceTintColor: Colors.white, //IOS
          elevation: elavationVal,
          color: Colors.white,
          shape: new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.white12, width: .3),
            borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
          ),
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Stack(children: [
                Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //const SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: CachedNetworkImageProvider(profilepicture!)),
                                   
                          ),

                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: SizedBox(
                                //width: MediaQuery.of(context).size.width - 125,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      username,
                                      style: TextStyle(
                                          color: Colors.black,
                                          //color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    RichText(
                                      textScaleFactor: MediaQuery.of(context)
                                          .textScaleFactor,
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                description,
                                            style: TextStyle(
                                                //color: Colors.black,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                      child: Text(
                                        postage.toString() + ' days ago',
                                        style: TextStyle(
                                            //color: Colors.grey,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 11),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: ClipRRect(borderRadius: BorderRadius.circular(5.0),
child:CachedNetworkImage(
         //key: globalImageKey,
       imageUrl: content.entries.first.value,
       progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                            height: double.infinity,
                            //height: 600,
                            width: double.infinity,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                        ),
                      ),
       errorWidget: (context, url, error) => Icon(Icons.error),height: double.infinity,
                            //height: 600,
                            width: double.infinity,
                            fit: BoxFit.cover
    )
                            ),
                          ),)

                        
                        ]),
                    preview == false ?
                    Container(
                        height: 40,

                        //color: Colors.black.withOpacity(0.5),
                        //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /**/
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          child: SizedBox(
                                            width: 70,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  child: Icon(
                                                    Icons.chat_bubble_outline,
                                                    //color: Colors.black12,
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 0, 0, 0),
                                                    child: Text('300',
                                                        style: TextStyle(
                                                            //color: Colors.grey,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15))),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          child: SizedBox(
                                            width: 70,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  child: Icon(
                                                    Icons.favorite_outline,
                                                    //color: Colors.black12,
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 0, 0, 0),
                                                    child: Text('1.2m',
                                                        style: TextStyle(
                                                            //color: Colors.grey,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15))),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 0, 0),
                                            child: SizedBox(
                                                width: 70,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 0),
                                                      child: Icon(
                                                        Icons
                                                            .swap_horiz_outlined,
                                                        //color: Colors.black12,
                                                        color: Colors.black12,
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                5, 0, 0, 0),
                                                        child: Text('25',
                                                            style: TextStyle(
                                                                //color: Colors.grey,
                                                                color: Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 15))),
                                                  ],
                                                ))),
                                      ]))
                            ])): Container()
                  ],
                )
              ]))),
    ]));
  }
}