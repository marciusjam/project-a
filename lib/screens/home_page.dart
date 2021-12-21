import 'package:agilay/widgets/home_bar.dart';
import 'package:agilay/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _selectedIndex = 1;

  List<Widget> list = [
    PostCard('image-Horizontal'),
    PostCard('textPost'),
    PostCard('image-Vertical'),
  ];

  SliverList _getSlivers(List myList, BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return myList[index];
        },
        childCount: myList.length,
      ),
    );
  }

  buildRow(String title) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        HomeBar(),
        _getSlivers(list, context),
        /*SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (_selectedIndex == 1) {
              return articles;
            }
          }, childCount: 5),
        )*/
      ],
    );

    /*Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('a'),
          actions: [
            /*MaterialButton(
              onPressed: () {
                Amplify.Auth.signOut().then((_) {
                  Navigator.pushReplacementNamed(context, '/');
                });
              },
              child: Icon(
                Icons.logout,
                color: Colors.purple,
              ),
            )*/
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, //remove this when you add image.
                ),
                child: InkWell(
                  onTap: () => {},
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 30 / 2,
                    backgroundImage: AssetImage('assets/profile-jam.jpg'),
                  ),
                ),
              ),
            ),

            /*IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/profile.svg',
                height: 20,
                width: 20,
                fit: BoxFit.scaleDown,
                //color: amber,
              ),
            )*/
          ],
        ),
        body: Container(
            color: Colors.white,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*if (_user == null)
                  Text(
                    'Loading....',
                  )
                else
                  Text(
                    'Hello 👋',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                Text(_user.username),
                SizedBox(height: 10),
                Text(_user.userId),*/
              ],
            ))));*/
  }
}

/*class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthUser _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Amplify.Auth.getCurrentUser().then((user) {
      setState(() {
        _user = user;
      });
    }).catchError((error) {
      debugPrint((error as AuthException).message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            MaterialButton(
              onPressed: () {
                Amplify.Auth.signOut().then((_) {
                  Navigator.pushReplacementNamed(context, '/');
                });
              },
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Container(
            color: Colors.amber,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_user == null)
                  Text(
                    'Loading....',
                  )
                else
                  Text(
                    'Hello 👋',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                Text(_user.username),
                SizedBox(height: 10),
                Text(_user.userId),
              ],
            ))));
  }
}*/
