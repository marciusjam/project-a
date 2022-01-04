import 'package:agilay/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  const PostCard(this.type, {Key? key}) : super(key: key);
  final String type;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late VideoPlayerController _controller;
  final double _iconSize = 20;

  final double elavationVal = 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        _mainContainer(context),
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

  Container _mainContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
      //height: 250,

      width: double.maxFinite,
      //color: Colors.white,
      child: Dismissible(
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
          key: Key('1'),
          child: _buildChild(context)),
    );
  }

  Widget _buildChild(BuildContext context) {
    debugPrint('postType: ' + widget.type);
    if (widget.type == 'image-Horizontal') {
      return _imageCardHoriz(context);
    } else if (widget.type == 'image-Vertical') {
      return _imageCardVert(context);
    } else if (widget.type == 'textPost') {
      return _textPost(context);
    } else if (widget.type == 'video-Horizontal') {
      return _videoCardHoriz(context);
    } else if (widget.type == 'video-Vertical') {
      return _videoCardVert(context);
    } else {
      return _textPost(context);
    }
  }

  Container _textPost(BuildContext context) {
    return Container(
        child: Column(children: [
      Card(
          elevation: elavationVal,
          shape: ContinuousRectangleBorder(
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
                                        backgroundImage: AssetImage(
                                            'assets/profile-jam.jpg'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 125,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Marcius',
                                      style: TextStyle(
                                          color: Colors.black,
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
                                                'I know I got this. I just need to grind this son of a bitch. Lorem ipsum is the key to generate random sentences. 💯',
                                            style: TextStyle(
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
                                        '10 mins ago',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
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
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 0, 0, 0),
                                                    child: Text('300',
                                                        style: TextStyle(
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
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 0, 0, 0),
                                                    child: Text('1.2m',
                                                        style: TextStyle(
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
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                5, 0, 0, 0),
                                                        child: Text('25',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 15))),
                                                  ],
                                                ))),
                                      ]))
                            ])),
                  ],
                )
              ]))),
    ]));
  }

  Container _imageCardHoriz(BuildContext context) {
    return Container(
        child: Column(
      children: [
        /*Card(
            elevation: elavationVal,
            shape: ContinuousRectangleBorder(
              borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
            ),
            child: Column(
              children: [
                AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      ClipRRect(
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(5.0)),
                        child: Image.network(
                            'https://scontent.fmnl17-2.fna.fbcdn.net/v/t1.6435-9/78563221_10215679511648949_4317568491948343296_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=e3f864&_nc_eui2=AeFMuKilzn9h3KO48fFTMlF1Z6PB8bneBn5no8Hxud4GfjnO3kFIT3Ki7ezD0lantms&_nc_ohc=ajS-PJd3eiUAX-bzl1z&_nc_ht=scontent.fmnl17-2.fna&oh=00_AT99csXJD5VzCOFSTDA8fMaALXkwwETIlo1Mx346pBDiaA&oe=61E48B41',
                            height: double.infinity,
                            //height: 600,
                            width: double.infinity,
                            fit: BoxFit.cover),
                      ),
                    ]))
              ],
            )),*/
        Card(
            elevation: elavationVal,
            shape: ContinuousRectangleBorder(
              borderRadius: new BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child:
                          Stack(alignment: Alignment.bottomCenter, children: [
                        ClipRRect(
                          borderRadius: new BorderRadius.only(
                              topRight: Radius.circular(5),
                              topLeft: Radius.circular(5)),
                          child: Image.network(
                              'https://scontent.fmnl17-2.fna.fbcdn.net/v/t1.6435-9/78563221_10215679511648949_4317568491948343296_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=e3f864&_nc_eui2=AeFMuKilzn9h3KO48fFTMlF1Z6PB8bneBn5no8Hxud4GfjnO3kFIT3Ki7ezD0lantms&_nc_ohc=ajS-PJd3eiUAX-bzl1z&_nc_ht=scontent.fmnl17-2.fna&oh=00_AT99csXJD5VzCOFSTDA8fMaALXkwwETIlo1Mx346pBDiaA&oe=61E48B41',
                              height: double.infinity,
                              //height: 600,
                              width: double.infinity,
                              fit: BoxFit.cover),
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
                                                backgroundImage: AssetImage(
                                                    'assets/profile-jam.jpg'),
                                              ),
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
                                        width:
                                            MediaQuery.of(context).size.width -
                                                125,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Marcius',
                                              style: TextStyle(
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
                                                    text:
                                                        'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ❤️💯',
                                                    style: TextStyle(
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
                                                'Aug 20, 2021',
                                                style: TextStyle(
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
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                                  child: SizedBox(
                                                    width: 70,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .chat_bubble_outline,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text('32',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                                  child: SizedBox(
                                                    width: 70,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .favorite_outline,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text('20',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                                    .swap_horiz_outlined,
                                                                color:
                                                                    Colors.grey,
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
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            15))),
                                                          ],
                                                        ))),
                                              ]))
                                    ])),
                          ],
                        ),
                      ],
                    ))
              ],
            ))
        //Divider( thickness: 5, color: Colors.black12)
      ],
    ));
  }

  Container _imageCardVert(BuildContext context) {
    return Container(
        child: Column(
      children: [
        /*Card(
            elevation: elavationVal,
            shape: ContinuousRectangleBorder(
              borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
            ),
            child: Column(
              children: [
                AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      ClipRRect(
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(5.0)),
                        child: Image.network(
                            'https://scontent.fmnl17-2.fna.fbcdn.net/v/t1.6435-9/78563221_10215679511648949_4317568491948343296_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=e3f864&_nc_eui2=AeFMuKilzn9h3KO48fFTMlF1Z6PB8bneBn5no8Hxud4GfjnO3kFIT3Ki7ezD0lantms&_nc_ohc=ajS-PJd3eiUAX-bzl1z&_nc_ht=scontent.fmnl17-2.fna&oh=00_AT99csXJD5VzCOFSTDA8fMaALXkwwETIlo1Mx346pBDiaA&oe=61E48B41',
                            height: double.infinity,
                            //height: 600,
                            width: double.infinity,
                            fit: BoxFit.cover),
                      ),
                    ]))
              ],
            )),*/
        Card(
            elevation: elavationVal,
            shape: ContinuousRectangleBorder(
              borderRadius: new BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child:
                          Stack(alignment: Alignment.bottomCenter, children: [
                        ClipRRect(
                          borderRadius: new BorderRadius.only(
                              topRight: Radius.circular(5),
                              topLeft: Radius.circular(5)),
                          child: Image.network(
                              'https://scontent.fmnl17-3.fna.fbcdn.net/v/t1.15752-9/263603893_436599031313032_8787735521029487826_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=ae9488&_nc_eui2=AeE_ZFwUcAT3W9RiB4eGRfECa8drJL9HW3prx2skv0dbetoWO3Bz7LWlerIr2lUngTo&_nc_ohc=B3Eyi6JWii4AX_cE6lh&_nc_ht=scontent.fmnl17-3.fna&oh=03_AVJ_uK2kWhzj0jvTbEyCIwhFIQrq8uTkMHBE1fGsuk54pA&oe=61E72AAF',
                              height: double.infinity,
                              //height: 600,
                              width: double.infinity,
                              fit: BoxFit.cover),
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
                                                backgroundImage: AssetImage(
                                                    'assets/profile-jam.jpg'),
                                              ),
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
                                        width:
                                            MediaQuery.of(context).size.width -
                                                125,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Marcius',
                                              style: TextStyle(
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
                                                    text:
                                                        'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, but also the leap into electronic typesetting. ❤️💯',
                                                    style: TextStyle(
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
                                                '3 hours ago',
                                                style: TextStyle(
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
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                                  child: SizedBox(
                                                    width: 70,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .chat_bubble_outline,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text('32',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                                  child: SizedBox(
                                                    width: 70,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .favorite_outline,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text('20',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                                    .swap_horiz_outlined,
                                                                color:
                                                                    Colors.grey,
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
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            15))),
                                                          ],
                                                        ))),
                                              ]))
                                    ])),
                          ],
                        ),
                      ],
                    ))
              ],
            ))
        //Divider( thickness: 5, color: Colors.black12)
      ],
    ));
  }

  Container _videoCardVert(BuildContext context) {
    return Container(
        child: Column(children: [
      Card(
          elevation: elavationVal,
          shape: ContinuousRectangleBorder(
            borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
          ),
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const _CreateVideoAsset(
                    'vertical', 'assets/vertvideo.mp4', 9 / 16),
                /*Padding(
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
                                    child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: InkWell(
                                        onTap: () => {},
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage(
                                                    'assets/profile-jam.jpg'),
                                              ),
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
                                        width:
                                            MediaQuery.of(context).size.width -
                                                115,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              textScaleFactor:
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: 'Marcius',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  TextSpan(
                                                    text: ' ' + 'Back burning',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15),
                                                  ),
                                                  TextSpan(
                                                    text: '   ' + '10 mins ago',
                                                    style: TextStyle(
                                                        color: Colors.black38,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            )
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
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                                  child: SizedBox(
                                                    width: 70,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .chat_bubble_outline,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text('1.2k',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                                  child: SizedBox(
                                                    width: 70,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .favorite_outline,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text('20',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                                    .swap_horiz_outlined,
                                                                color:
                                                                    Colors.grey,
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
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            15))),
                                                          ],
                                                        ))),
                                              ]))
                                    ])),
                          ],
                        ),
                      ],
                    ))*/
              ],
            )
          ])),
    ]));
  }

  Container _videoCardHoriz(BuildContext context) {
    return Container(
        child: Column(children: [
      Card(
          elevation: elavationVal,
          shape: ContinuousRectangleBorder(
            borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
          ),
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const _CreateVideoAsset(
                    'horizontal', 'assets/horizvideo.mp4', 16 / 9),
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
                                                backgroundImage: AssetImage(
                                                    'assets/profile-jam.jpg'),
                                              ),
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
                                        width:
                                            MediaQuery.of(context).size.width -
                                                125,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Marcius',
                                              style: TextStyle(
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
                                                    text: '1v4 EZ!!!!',
                                                    style: TextStyle(
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
                                                '3 secs ago',
                                                style: TextStyle(
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
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                                  child: SizedBox(
                                                    width: 70,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .chat_bubble_outline,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text('1',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                                  child: SizedBox(
                                                    width: 70,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .favorite_outline,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text('50',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                                    .swap_horiz_outlined,
                                                                color:
                                                                    Colors.grey,
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
                                                                    '10',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            15))),
                                                          ],
                                                        ))),
                                              ]))
                                    ])),
                          ],
                        ),
                      ],
                    ))
              ],
            )
          ])),
    ]));
  }
}

class _CreateVideoAsset extends StatefulWidget {
  const _CreateVideoAsset(this.videotype, this.video, this.size, {Key? key})
      : super(key: key);
  final String videotype;
  final String video;
  final double size;

  @override
  _CreateVideoAssetState createState() => _CreateVideoAssetState();
}

class _CreateVideoAssetState extends State<_CreateVideoAsset> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      widget.video,
      //'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      //'https://www.tiktok.com/@redbedonia_/video/7034010235475987739',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videotype == 'horizontal') {
      //video = 'assets/horizvideo.mp4';
      //size = 16 / 9;
    }
    if (widget.videotype == 'vertical') {
      //video == 'assets/vertvideo.mp4';
      //size == 4 / 5;
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
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5)),
                      child: VideoPlayer(_controller),
                    ),
                  if (widget.videotype == 'vertical')
                    ClipRRect(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(5.0)),
                      child: VideoPlayer(_controller),
                    ),
                  if (widget.videotype == 'vertical')
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
                                                    backgroundImage: AssetImage(
                                                        'assets/profile-jam.jpg'),
                                                  ),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                125,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Marcius',
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
                                                        text: 'Back burning',
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
                  ClipRRect(
                    borderRadius: new BorderRadius.all(
                      Radius.circular(5),
                    ),
                    child: VideoProgressIndicator(_controller,
                        allowScrubbing: true),
                  )
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
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5)),
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
