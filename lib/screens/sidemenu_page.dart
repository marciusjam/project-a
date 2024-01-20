import 'package:Makulay/main.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/login.dart';
import 'package:Makulay/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';

void _signOutAndNavigateToLogin(BuildContext context) async {
  try {
    await Amplify.Auth.signOut();
    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(),
      ),
    );
  } catch (e) {
    print('Error during sign-out: $e');
  }
}

class NotificationItem {
  final String title;
  final String message;
  final String time;

  NotificationItem(
      {required this.title, required this.message, required this.time});
}

class SideMenuPage extends StatefulWidget {
  const SideMenuPage({Key? key}) : super(key: key);

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage>
    with SingleTickerProviderStateMixin {
  var _scrollController, _tabController;
  late final Function onIconTap;

  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "New Message",
      message: "You have a new message from John Doe.",
      time: "9:00 AM",
    ),
    NotificationItem(
      title: "Reminder",
      message: "Don't forget to attend the meeting at 2:00 PM.",
      time: "10:30 AM",
    ),
    NotificationItem(
      title: "Update",
      message: "An update for the app is available. Please install it.",
      time: "12:15 PM",
    ),
  ];

  List<Widget> list = [
    AspectRatio(
      aspectRatio: (9 / 16) * 3,
      child: Image.network(
          'https://terrigen-cdn-dev.marvel.com/content/prod/1x/axejudgement2022001_cover.jpg',
          //height: 200, //widget._tabController.index == 1 ? 16 : 12,
          //width: double.infinity, //widget._tabController.index == 1 ? 16 : 12,
          filterQuality: FilterQuality.medium,
          fit: BoxFit.cover),
    ),
  ];

  _notificationList(List myList) {
    return ListView.builder(
      itemCount: notifications.length,
      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(notifications[index].title),
          subtitle: Text(notifications[index].message),
          trailing: Text(notifications[index].time),
        );
      },
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
            height: 250,
            width: double.maxFinite,
            child: _notificationList(notifications),
          ),
          Container(
            height: 30,
            child: ElevatedButton(
              onPressed: () => _signOutAndNavigateToLogin(context),
              child: Text('Sign Out'),
            ),
          )
        ],
      ),
    );
  }
}
