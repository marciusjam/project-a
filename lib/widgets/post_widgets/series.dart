import 'dart:developer';

import 'package:agilay/models/Model_Series.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../custom_videoplayer.dart';

class Series extends StatelessWidget {
  const Series({required this.seriesList, required this.indexLine, Key? key})
      : super(key: key);
  final double elavationVal = 3;
  final SeriesModel seriesList;
  final int indexLine;

  _perEpisodeView(BuildContext context, int index) {
    if (index == 0) {
      return Stack(children: [
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
                //padding: const EdgeInsets.all(20),
                child: AspectRatio(
                    aspectRatio: 9 / 16,
                    /*Container(
              height: 300,
              width: double.infinity,*/
                    //aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Image.asset(seriesList.media.toString(),
                              height: double.infinity,
                              //height: 600,
                              width: double.infinity,
                              fit: BoxFit.cover),
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

                                            /*Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: SizedBox(
                                              //MediaQuery.of(context).size.width - 125,

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
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 3, 0, 0),
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
                                      */
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
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 10,
                                                                    0, 0),
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
                                                                          .chat_bubble_outline,
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
                                                                          '1.2k',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 15))),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 10,
                                                                    0, 0),
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
                                                                          .favorite_outline,
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
                                                                          '20',
                                                                          style: TextStyle(
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
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          0),
                                                              child: SizedBox(
                                                                  width: 70,
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .swap_horiz_outlined,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              5,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child: Text(
                                                                              '104',
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15))),
                                                                    ],
                                                                  ))),
                                                        ]))
                                              ])),
                                    ],
                                  ),
                                ],
                              )),
                        ])))
          ]))
        ])
      ]);
    } else {
      return Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomVideoPlayer('series', seriesList.media.toString(), 9 / 16),
          ],
        )
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(seriesList.toString());
    debugPrint('indexLine ' + indexLine.toString());
    double aspectRatio;
    double widthToUse;
    if (indexLine == 0) {
      aspectRatio = 9 / 16;
      widthToUse = 1;
    } else {
      aspectRatio = 9 / 16;
      widthToUse = 1;
    }
    debugPrint('aspectRatio ' + aspectRatio.toString());
    debugPrint('widthToUse ' + widthToUse.toString());
    return Container(
        width: ((MediaQuery.of(context).size.width) / 1.5) + widthToUse,
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
                shape: new RoundedRectangleBorder(
                  //side: new BorderSide(color: Colors.black, width: .3),
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: AspectRatio(
                          aspectRatio: (aspectRatio),
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ClipRRect(
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(10)),
                                    child: _perEpisodeView(context, indexLine)),
                              ])),
                    ),
                  ],
                ))
            //Divider( thickness: 5, color: Colors.black12)
          ],
        ));
  }
}
