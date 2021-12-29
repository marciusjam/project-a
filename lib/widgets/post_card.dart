import 'package:agilay/screens/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  const PostCard(this.type, {Key? key}) : super(key: key);
  final String type;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late VideoPlayerController _controller;
  final double _iconSize = 20;

  final double elavationVal = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return _mainContainer(context);
  }

  Container _mainContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
      //height: 250,
      width: double.maxFinite,
      color: Colors.white,
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
    } else {
      return _textPost(context);
    }
  }

  Card _textPost(BuildContext context) {
    return Card(
      elevation: elavationVal,
      shape: ContinuousRectangleBorder(
        borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 200,
              width: 100,
              //color: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              decoration: BoxDecoration(
                  //color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.all(const Radius.circular(5.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      /*subtitle: Text('location',
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black)),*/

                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: InkWell(
                          onTap: () => {},
                          child: Container(
                            height: 35,
                            width: 35,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Container(
                                height: 30,
                                width: 30,
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
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text('John Marcius Tolentino',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                            child: Text(
                              'I know I got this. I just need to grind this son of a bitch. Lorem ipsum is the key to generate random sentences. 💯',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14),
                            ),
                          ))),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.chat_bubble_outline),
                          iconSize: _iconSize,
                        ),
                      ),*/
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 12, 1),
                                child: Text('100',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17))),
                          ],
                        )),
                        Spacer(),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Icon(
                                Icons.favorite_outline,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 12, 1),
                                child: Text('3.4k',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17))),
                          ],
                        )),
                        Spacer(),
                        /*IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.swap_horiz_outlined),
                        iconSize: _iconSize,
                      ),*/
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Icon(
                                Icons.swap_horiz_outlined,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 12, 1),
                                child: Text('8',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17))),
                          ],
                        )),
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Card _imageCardHoriz(BuildContext context) {
    return Card(
      elevation: elavationVal,
      shape: ContinuousRectangleBorder(
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
      ),
      child: Column(children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
              child: Image.network(
                  'https://scontent.fmnl17-2.fna.fbcdn.net/v/t1.6435-9/78563221_10215679511648949_4317568491948343296_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=e3f864&_nc_eui2=AeFMuKilzn9h3KO48fFTMlF1Z6PB8bneBn5no8Hxud4GfjnO3kFIT3Ki7ezD0lantms&_nc_ohc=ajS-PJd3eiUAX-bzl1z&_nc_ht=scontent.fmnl17-2.fna&oh=00_AT99csXJD5VzCOFSTDA8fMaALXkwwETIlo1Mx346pBDiaA&oe=61E48B41',
                  height: 300,
                  //height: 600,
                  width: double.infinity,
                  fit: BoxFit.cover),
            ),
            Positioned(
                top: 200,
                //top: 500,
                left: 0,
                right: 0,
                child: Container(
                    height: 100,
                    width: 100,
                    //color: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      //color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            /*subtitle: Text('location',
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black)),*/

                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: InkWell(
                                onTap: () => {},
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text('John Marcius Tolentino',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                                  child: Text(
                                    'Fam ❤️💯',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /*Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.chat_bubble_outline),
                          iconSize: _iconSize,
                        ),
                      ),*/
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 12, 1),
                                      child: Text('100',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 17))),
                                ],
                              )),
                              Spacer(),
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Icon(
                                      Icons.favorite_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 12, 1),
                                      child: Text('2.5k',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 17))),
                                ],
                              )),
                              Spacer(),
                              /*IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.swap_horiz_outlined),
                        iconSize: _iconSize,
                      ),*/
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Icon(
                                      Icons.swap_horiz_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 12, 1),
                                      child: Text('8',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 17))),
                                ],
                              )),
                            ],
                          ),
                        )
                      ],
                    ))),
          ],
        ),
      ]),
    );
  }

  Card _imageCardVert(BuildContext context) {
    return Card(
      elevation: elavationVal,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
              child: Image.network(
                  'https://scontent.fmnl17-3.fna.fbcdn.net/v/t1.15752-9/263603893_436599031313032_8787735521029487826_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=ae9488&_nc_eui2=AeE_ZFwUcAT3W9RiB4eGRfECa8drJL9HW3prx2skv0dbetoWO3Bz7LWlerIr2lUngTo&_nc_ohc=B3Eyi6JWii4AX_cE6lh&_nc_ht=scontent.fmnl17-3.fna&oh=03_AVJ_uK2kWhzj0jvTbEyCIwhFIQrq8uTkMHBE1fGsuk54pA&oe=61E72AAF',
                  //height: 300,
                  height: 600,
                  width: double.infinity,
                  fit: BoxFit.cover),
            ),
            Positioned(
                //top: 200,
                top: 500,
                left: 0,
                right: 0,
                child: Container(
                    height: 100,
                    width: 100,
                    //color: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      //color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            /*subtitle: Text('location',
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black)),*/

                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: InkWell(
                                onTap: () => {},
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: ClipRRect(
                                        borderRadius: new BorderRadius.all(
                                            const Radius.circular(50.0)),
                                        child: Image.network(
                                          'https://scontent.fmnl17-1.fna.fbcdn.net/v/t1.15752-9/263180874_1959467470892086_1174552887281066520_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=ae9488&_nc_eui2=AeG9FRgr-YyROVarBlhMh-_8BIn-cP40bdoEif5w_jRt2kBIy7JTc2FTT6i5_ZkmL0A&_nc_ohc=JcrGD4lYYSkAX_Brjb8&_nc_ht=scontent.fmnl17-1.fna&oh=03_AVLwxz8U1XHUWtvV8pJqWqiOIFt_YOIwDiU57SQ7fyjhpQ&oe=61E6CA03',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text('Shaye Crispo',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                                  child: Text(
                                    'Forever ❤️',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /*Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.chat_bubble_outline),
                          iconSize: _iconSize,
                        ),
                      ),*/
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 12, 1),
                                      child: Text('100',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 17))),
                                ],
                              )),
                              Spacer(),
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Icon(
                                      Icons.favorite_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 12, 1),
                                      child: Text('2.5k',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 17))),
                                ],
                              )),
                              Spacer(),
                              /*IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.swap_horiz_outlined),
                        iconSize: _iconSize,
                      ),*/
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Icon(
                                      Icons.swap_horiz_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 12, 1),
                                      child: Text('8',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 17))),
                                ],
                              )),
                            ],
                          ),
                        )
                      ],
                    ))),
          ],
        ),
      ]),
    );
  }

  Card _videoCardHoriz(BuildContext context) {
    return Card(
      elevation: elavationVal,
      shape: ContinuousRectangleBorder(
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
      ),
      child: Column(children: [
        Stack(
          children: [
            ClipRRect(
                borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
                child: Column(children: <Widget>[
                  Column(
                    children: <Widget>[
                      Stack(children: <Widget>[
                        _CreateVideoAsset(),
                        //Image.asset('assets/flutter-mark-square-64.png'),
                      ]),
                    ],
                  ),
                ])),
          ],
        ),
      ]),
    );
  }
}

class _CreateVideoAsset extends StatefulWidget {
  @override
  _CreateVideoAssetState createState() => _CreateVideoAssetState();
}

class _CreateVideoAssetState extends State<_CreateVideoAsset> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/tarik.mp4',
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            //padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              /*Container(
              height: 300,
              width: double.infinity,*/
              //aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  Container(
                      height: 100,
                      //color: Colors.black.withOpacity(0.5),
                      //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: BoxDecoration(
                        //color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              /*subtitle: Text('location',
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black)),*/

                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: InkWell(
                                  onTap: () => {},
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text('John Marcius Tolentino',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                                    child: Text(
                                      'Fam ❤️💯',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /*Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.chat_bubble_outline),
                          iconSize: _iconSize,
                        ),
                      ),*/
                                Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: Icon(
                                        Icons.chat_bubble_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 12, 1),
                                        child: Text('100',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 17))),
                                  ],
                                )),
                                Spacer(),
                                Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: Icon(
                                        Icons.favorite_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 12, 1),
                                        child: Text('2.5k',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 17))),
                                  ],
                                )),
                                Spacer(),
                                /*IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.swap_horiz_outlined),
                        iconSize: _iconSize,
                      ),*/
                                Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: Icon(
                                        Icons.swap_horiz_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 12, 1),
                                        child: Text('8',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 17))),
                                  ],
                                )),
                              ],
                            ),
                          )
                        ],
                      )),
                  _ControlsOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
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
        AnimatedSwitcher(
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
