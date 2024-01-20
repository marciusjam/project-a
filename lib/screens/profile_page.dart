import 'package:Makulay/screens/auth_page.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/login.dart';
import 'package:Makulay/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

void _signOutAndNavigateToLogin(BuildContext context) async {
  try {
    await Amplify.Auth.signOut();
    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AuthPage(),
      ),
    );
  } catch (e) {
    print('Error during sign-out: $e');
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  var _scrollController, _tabController;
  late final Function onIconTap;

  List<Widget> list = [
    Stack(alignment: Alignment.bottomCenter, children: <Widget>[
      AspectRatio(
        aspectRatio: 9 / 16,
        child: Container(
          //height: MediaQuery.of(context).size.height / 1.5,
          //width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/profile-jam.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
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
                      width: 40,
                      height: 40,
                      child: InkWell(
                        onTap: () => {},
                        child: Container(
                          height: 40,
                          width: 40,
                          child: CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: Container(
                              height: 35,
                              width: 35,
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
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      'Marcius',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
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
            ],
          ))
    ]),
    Container(
      padding: EdgeInsets.all(30),
      child: Text(
        'I know I got this. I just need to grind this son of a bitch. Lorem ipsum is the key to generate random sentences. 💯',
        style: TextStyle(
            color: Colors.black,
            //color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 15),
      ),
    ),
    PostCard('textPost', '', []),
    PostCard('series', '', []),
    PostCard('image-Horizontal', '', []),
    PostCard('image-Vertical', '', []),
    PostCard('video-Horizontal', '', []),
    PostCard('series', '', []),
    PostCard('video-Vertical', '', []),
    PostCard('textPost', '', []),
  ];

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 5);
    super.initState();
  }

  _pageView(List myList) {
    return ListView.builder(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return //Login();
        Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
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
                  child: Icon(Icons.close_rounded),
                ),
              ),
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: _pageView(list),

                        //  _buildBox(),
                      ),

                      /*SizedBox(
                        height: 100,
                        //padding: EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/grid_image_$index.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),*/
                    ],
                  ),
                )));
  }
}
