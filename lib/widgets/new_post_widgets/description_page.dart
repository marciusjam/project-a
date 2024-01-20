import 'package:Makulay/models/Post.dart';
import 'package:Makulay/widgets/new_post_widgets/preview_widget.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/src/types/entity.dart';

class DescriptionPage extends StatefulWidget {
  final List<AssetEntity> selectedAssets;
  const DescriptionPage(this.selectedAssets, {super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final TextEditingController _descriptionController = TextEditingController();
  
  String selectedOption = '';

  @override
  void initState() {
    super.initState();
    /*_videoController = VideoPlayerController.network(
        'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8')
      ..initialize().then((_) {
        setState(() {});
      });
    _textController = TextEditingController();*/
    // Fetch gallery images
    debugPrint('Description page');
    debugPrint('slected LISTS ' + widget.selectedAssets.toString());
    
    
  }

  Widget buildRadioButton(String title, String value) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Radio(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            value: value,
            groupValue: selectedOption,
            onChanged: (newValue) {
              setState(() {
                selectedOption = newValue.toString();
              });
            },
          ),
        ),
        Text(title),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Write something about it',
          style: TextStyle(
            color: Colors.black, // 3
          ),
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            //statusBarColor: Colors.black,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light),
        foregroundColor: Colors.black,
        actionsIconTheme: IconThemeData(color: Colors.black),
        /*leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context, true),
            child: Icon(Icons.close_rounded),
          ),
        ),*/
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                  child: Column(children: [
                    Card(
                        color: Colors.white, //Dark Mode
                        elevation: 3,
                        shape: new RoundedRectangleBorder(
                          side: new BorderSide(color: Colors.white, width: .3),
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(10.0)),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Stack(children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: TextField(
                                      controller: _descriptionController,
                                      keyboardType: TextInputType.multiline,
                                      maxLines:
                                          5, // Set to null or a value greater than 1 for a large text field
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          hintText: 'Description...',
                                          //hintStyle: TextStyle(fontSize: 20),
                                          border: InputBorder.none
                                          //UnderlineInputBorder(),
                                          ),
                                    ),
                                  )
                                ],
                              )
                            ]))),
                  ])),

              /*SizedBox(
                  height: 300,
                  child: Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: 
                  ))),*/
              //Divider(color: Colors.black),

              //),

              SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildRadioButton('Public', 'Option 1'),
                    buildRadioButton('Followers', 'Option 2'),
                    buildRadioButton('Option 3', 'Option 3'),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Container(
                    width: 100,
                    child: ElevatedButton(
                      /*style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20)
                          ),*/
                      onPressed: () {
                        //Navigator.pop(context, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviewPage(
                                  descriptionController:
                                      _descriptionController, selectedAssetsController: widget.selectedAssets,)),
                        );
                      },
                      child: const Text('Next'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      /*persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: <Widget>[
        Icon(
          Icons.settings,
          color: Colors.black,
        ),
        SizedBox(width: 5),
        Icon(Icons.exit_to_app, color: Colors.black),
        SizedBox(
          width: 10,
        ),
      ],*/

      /*floatingActionButton: FloatingActionButton(
        onPressed: _requestAssets,
        child: const Icon(Icons.developer_board),
      ),*/
    );
  }
}
