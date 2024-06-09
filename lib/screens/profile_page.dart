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


class ProfilePage extends StatefulWidget {
  final String username, profilepicture;
  const ProfilePage(this.username, this.profilepicture, {Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  var _scrollController, _tabController;
  late final Function onIconTap;
  List<Widget> allPosts = [];

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

  Future<void> getPostsByUser() async {
    final result = await Amplify.Auth.getCurrentUser();
    var postsData = await searchPostsByUserId(result.userId);
    debugPrint('searchPostsByUserId Response: ' + postsData.data.toString());
    
    if(postsData.data != null){
      PaginatedResult<Post>? gatheredPosts = postsData.data;
      for (var eachPosts in gatheredPosts!.items) {
        debugPrint('eachPosts :' + eachPosts.toString());
        debugPrint('eachPosts description :' + eachPosts!.description);
        String description = eachPosts!.description;
        String? orientation = eachPosts.orientation;
        String? contenttype = eachPosts.contenttype;
        
        TemporalDateTime? createddate = eachPosts!.createdAt;
        final datecreated = DateTime.parse(createddate.toString());
        final datenow = DateTime.now();
        int postage = daysBetween(datecreated, datenow); // Works!
        debugPrint('postage '+ postage.toString());

        String? content = eachPosts.content;
        Map<String, String> contentList = {};
        await getFileUrl(eachPosts.user!.profilePicture.toString()).then((value) => {
          if(content != '' && content != "null" && content != null){
            
            getFileUrl(content.toString()).then((contentvalue) {
              //_precacheImage(value, content);
              contentList[content] = contentvalue;

              if(orientation == 'vertical'){
            if(contenttype == 'image'){
              setState(() {
                allPosts.add(PostCard('image-Vertical', description, contentList, widget.username, value, postage, false, null, null));
              });
            }else{
              setState(() {
                allPosts.add(PostCard('video-Vertical', description, contentList, widget.username, value, postage, false, null, null));
              });
            }
          }else{
            if(contenttype == 'image'){
              setState(() {
                allPosts.add(PostCard('image-Horizontal', description, contentList, widget.username, value, postage, false, null, null));
              });
            }else{
              setState(() {
                allPosts.add(PostCard('video-Horizontal', description, contentList, widget.username, value, postage, false, null, null));
              });
            }
          }
          })
          
        }else{ 
          setState(() {
            allPosts.add(PostCard('textPost', description, {}, widget.username, value, postage, false, null, null));
          })
        }
        });


      }
    }
    
  }

  _pageView(List myList) {
    return Container(
      color: Colors.black,
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

  Widget mainProfile(BuildContext context){
   return Stack(  alignment: Alignment.bottomCenter, children: <Widget>[
      AspectRatio(
        aspectRatio: 9 / 16,
        child: Container(
          //height: MediaQuery.of(context).size.height / 1.5,
          //width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black,
            //borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/profile-shaye.jpg'),
              fit: BoxFit.cover,
              colorFilter: 
      ColorFilter.mode(Colors.black.withOpacity(0.5), 
      BlendMode.dstATop),
            ),
          ),
        ),
      ),
      
      
      /*Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child:*/Column(
            
            children: [
      
      Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
            
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: InkWell(
                        onTap: () => {},
                        child: Container(
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Container(
                              height: 95,
                              width: 95,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: CachedNetworkImageProvider(widget.profilepicture),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
              Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      widget.username,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
                        child: Text(
                          '1.1m',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Followers',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  )),

              Container(
      padding: EdgeInsets.all(30),
      child: Align(
        alignment: Alignment.center,
        child: Text(
        'I know I got this. I just need to grind this son of a bitch. Lorem ipsum is the key to generate random sentences. 💯',
        style: TextStyle(
            color: Colors.white,
            //color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 15),
      ),) 
    ),
            ],
          )),]),//),
    
    ]);
    }
    /*PostCard('textPost', '', {}),
    PostCard('series', '', {}),
    PostCard('image-Horizontal', '', {}),
    PostCard('image-Vertical', '', {}),
    PostCard('video-Horizontal', '', {}),
    PostCard('series', '', {}),
    PostCard('video-Vertical', '', {}),
    PostCard('textPost', '', {}),*/
  
  

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 5);
    super.initState();
    setState(() {
      allPosts.add(mainProfile(context));
    });
    getPostsByUser();
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
        body: _pageView(allPosts),

                        //  _buildBox(),
                      
                    
                    
                  
    );
  }
}
