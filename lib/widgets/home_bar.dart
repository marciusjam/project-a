import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light,
      ),
      title: Text('agila',
          style: GoogleFonts.lexendDeca(
              color: Colors.amber, fontSize: 25, fontWeight: FontWeight.bold)),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Container(
            width: 30,
            height: 30,
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
      ],
    );
  }
}
