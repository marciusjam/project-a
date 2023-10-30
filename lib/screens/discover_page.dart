import 'package:agilay/widgets/home_bar.dart';
import 'package:agilay/widgets/post_card.dart';
import 'package:agilay/widgets/post_widgets/imagecard_horiz.dart';
import 'package:agilay/widgets/post_widgets/imagecard_vert.dart';
import 'package:agilay/widgets/post_widgets/videocard_horiz.dart';
import 'package:agilay/widgets/post_widgets/videocard_vert.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'package:agilay/widgets/post_widgets/text_post.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  var _scrollController, _tabController;
  late final Function onIconTap;

  List<Widget> list = [
    PostCard('video-Vertical'),
    PostCard('image-Horizontal'),
    PostCard('textPost'),
    PostCard('image-Vertical'),
    PostCard('video-Horizontal'),
  ];

  _pageView(List myList) {
    return ListView.builder(
      itemCount: 5,
      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemBuilder: (BuildContext context, int index) {
        return myList[index];
      },
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black, child: _pageView(list));
    /*TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: <Widget>[
        _pageView(list),
        _pageView(list),
        _pageView(list),
      ],
    );*/
  }
}
