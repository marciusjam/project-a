import 'package:Makulay/models/CustomGraphQL.dart';
import 'package:Makulay/models/Post.dart';
import 'package:Makulay/screens/auth_page.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/login.dart';
import 'package:Makulay/widgets/post_card.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';


class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage>
    with SingleTickerProviderStateMixin {
  var _scrollController, _tabController;
  late final Function onIconTap;
  List<Widget> allPosts = [];

  List<Widget> activites = [
    Row(children: [
      Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: InkWell(
                                        onTap: () => {},
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage('assets/profile-shaye.jpg'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),),
      Text('shayecrispo', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
      Text(' added a new post.', style: TextStyle(color: Colors.white)),
      Spacer(),
      Text('1 mins ago', style: TextStyle(
                                                    //color: Colors.grey,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11),)
    ],),
    Row(children: [
      Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: InkWell(
                                        onTap: () => {},
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage('assets/story_image_2.jpg'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),),
      Text('narutouzumaki', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      Text(' is now Live.', style: TextStyle(color: Colors.white)),
      Spacer(),
      Text('2 mins ago', style: TextStyle(
                                                    //color: Colors.grey,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11),)
    ],),
    Row(children: [
      Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: InkWell(
                                        onTap: () => {},
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage('assets/story_image_3.jpg'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),),
      
      Text('sasukeuchiha', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      Text(' added a comment on a post.', style: TextStyle(color: Colors.white)),
      Spacer(),
      Text('5 mins ago', style: TextStyle(
                                                    //color: Colors.grey,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11),)
    ],),
    Row(children: [
      Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: InkWell(
                                        onTap: () => {},
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage('assets/profile-jam.jpg'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),),
      
      Text('marciusjam', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      Text(' shared a post.', style: TextStyle(color: Colors.white)),
      Spacer(),
      Text('10 mins ago', style: TextStyle(
                                                    //color: Colors.grey,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11),)
    ],),
    Row(children: [
      Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: InkWell(
                                        onTap: () => {},
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage('assets/story_image_5.jpg'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),),
      
      Text('luffy', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      Text(' reacted to a post.', style: TextStyle(color: Colors.white)),
      Spacer(),
      Text('10 mins ago', style: TextStyle(
                                                    //color: Colors.grey,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11),)
    ],),
  ];


  Future<String> getFileUrl(String fileKey) async {
      try {
        final result = await Amplify.Storage.getUrl(
      key: fileKey,
      options: const StorageGetUrlOptions(
        accessLevel: StorageAccessLevel.guest,
        pluginOptions: S3GetUrlPluginOptions(
          expiresIn: Duration(days: 1),
        ),
      ),
    ).result;
        //debugPrint('result ' + result.url.toString());
        
        return result.url.toString();
      } catch (e) {
        throw e;
      }
    }
  
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  
  _pageView(List myList) {
    return Container(
        child: ListView.builder(
      itemCount: myList.length,
      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemBuilder: (BuildContext context, int index) {
        return myList[index];
        /*Column(
          children: [
            Divider(
              height: .5,
              color: Colors.white,
              thickness: .5,
              indent: 0,
              endIndent: 0,
            ),
          ],
        );*/
        
    
  
      },
    ));
  }

  
  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 5);
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return //Login();
    Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.black,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              //statusBarColor: Colors.black,
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.dark),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: Icon(Icons.arrow_back_ios, color: Colors.white,),
            ),
          ),
          actions: <Widget>[
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.qr_code_2_rounded,
          size: 30.0,
          color: Colors.white,
        ),
      )
    ),
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: Icon(
            Icons.settings,
            size: 30.0,
            color: Colors.white,
        ),
      )
    ),
  ],
        ),
        body: Container(color: Colors.black, child: Padding(
              padding: const EdgeInsets.all(15),
              child: Stack(children: [
                Column(
                  children: [
                    //Text('Text')
                    ListView.separated(
                      shrinkWrap: true,
                  itemCount: activites.length,
                  separatorBuilder: (_, __) => const Divider(color: Colors.transparent,),
                  padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                  itemBuilder: (BuildContext context, int actindex) {
                    return activites[actindex];
                  },
                )
                  ]
         )],
    )),),

                        //  _buildBox(),
                      
                    
                    
                  
    );
  }
}
