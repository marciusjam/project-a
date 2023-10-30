import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageCardVert extends StatelessWidget {
  const ImageCardVert({Key? key}) : super(key: key);
  final double elavationVal = 3;

  @override
  Widget build(BuildContext context) {
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
            color: Colors.white, //Dark Mode
            shape: new RoundedRectangleBorder(
              side: new BorderSide(color: Colors.white, width: .3),
              borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
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
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          child: Image.network(
                              'https://terrigen-cdn-dev.marvel.com/content/prod/1x/axejudgement2022001_cover.jpg',
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
                                                  //color: Colors.white,
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
                                                        //color: Colors.white,
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
                                                    //color: Colors.white,
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
                                                            color:
                                                                Colors.black12,
                                                            //color: Colors.white,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text('32',
                                                                style: TextStyle(
                                                                    color: Colors.grey,
                                                                    //color: Colors.white,
                                                                    fontWeight: FontWeight.normal,
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
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Icon(
                                                            Icons
                                                                .favorite_outline,
                                                            color:
                                                                Colors.black12,
                                                            //color: Colors.white,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text('20',
                                                                style: TextStyle(
                                                                    color: Colors.grey,
                                                                    //color: Colors.white,
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
                                                                    .swap_horiz_outlined,
                                                                color: Colors
                                                                    .black12,
                                                                //color: Colors.white,
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
                                                                        color: Colors.grey,
                                                                        //color: Colors.white,
                                                                        fontWeight: FontWeight.normal,
                                                                        fontSize: 15))),
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
}
