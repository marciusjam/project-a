import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StreamWidget extends StatefulWidget {
  const StreamWidget({super.key});

  @override
  State<StreamWidget> createState() => _StreamWidgetState();
}

class _StreamWidgetState extends State<StreamWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'New Stream',
          style: TextStyle(
            color: Colors.white, // 3
          ),
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            //statusBarColor: Colors.black,
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark),
        foregroundColor: Colors.black,
        actionsIconTheme: IconThemeData(color: Colors.white),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: Icon(Icons.close_rounded, color: Colors.white,),
          ),
        )
      ),);
  }
}