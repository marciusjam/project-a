import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextPost extends StatelessWidget {
  const TextPost({Key? key}) : super(key: key);
  final double elavationVal = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Card(
          color: Colors.white, //Dark Mode
          elevation: elavationVal,
          shape: new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.white, width: .3),
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
                                                'I know I got this. I just need to grind this son of a bitch. Lorem ipsum is the key to generate random sentences. 💯',
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
                                          const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                      child: Text(
                                        '10 mins ago',
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
                                                    color: Colors.black12,
                                                    //color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 0, 0, 0),
                                                    child: Text('300',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            //color: Colors.white,
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
                                                    color: Colors.black12,
                                                    //color: Colors.white,
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 0, 0, 0),
                                                    child: Text('1.2m',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            //color: Colors.white,
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
                                                        color: Colors.black12,
                                                        //color: Colors.white,
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
                                                                //color: Colors.white,
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
}
