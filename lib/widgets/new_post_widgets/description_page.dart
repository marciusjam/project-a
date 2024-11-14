import 'package:Makulay/models/Post.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/widgets/new_post_widgets/media_widget.dart';
import 'package:Makulay/widgets/new_post_widgets/preview_widget.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/src/types/entity.dart';

class DescriptionPage extends StatefulWidget {
    final List<CameraDescription> cameras;
  final List<AssetEntity> selectedAssets;
  final String username, profilepicture;
  final List<String> entitypaths;
  final TextEditingController descriptionController;
  const DescriptionPage(this.username, this.profilepicture, this.selectedAssets, this.cameras, this.entitypaths, this.descriptionController, {super.key});

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
    if(widget.descriptionController.text != null || widget.descriptionController.text != ''){
        _descriptionController.text = widget.descriptionController.text;
      }
    
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
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Description',
          style: TextStyle(
            color: Colors.white, // 3
          ),
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            //statusBarColor: Colors.white,
            statusBarColor: Colors.black,
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark),
        foregroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.white),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                if(_descriptionController.text.isNotEmpty){
                  _descriptionController.clear();
                }
                Navigator.pop(context, true);
                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              
                                  NewPostPage(username: widget.username, profilepicture: widget.profilepicture,  cameras: widget.cameras, preselectedAssets: widget.selectedAssets, preentityPaths: widget.entitypaths, descriptionController: _descriptionController, onIconTap: null,
                                            selectedPageIndex: null,)
                               
                                  
                          ),
                                  );
              } ,
              child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,),
          ),
        ),
        actions: [Padding(
            padding: const EdgeInsets.fromLTRB(0,0,20,0),
            child: GestureDetector(
              onTap: (){
                        Navigator.pop(context, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviewPage(
                                  descriptionController:
                                      _descriptionController, selectedAssetsController: widget.selectedAssets, widget.username, widget.profilepicture, widget.cameras, widget.entitypaths)),
                        );
              },
              child: Text('Next', style: TextStyle(color: Colors.amber, fontSize: 15)),
          ),)]
      ),
      body: Container(
        color: Colors.black,
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
                          side: new BorderSide(color: Colors.grey.shade300, width: .3),
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(10.0)),
                        ),
                        surfaceTintColor: Colors.white,
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

              /*SizedBox(
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
              ),*/
              /*Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Container(
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white, 
                          
                          ),
                      onPressed: () {
                        //Navigator.pop(context, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviewPage(
                                  descriptionController:
                                      _descriptionController, selectedAssetsController: widget.selectedAssets, widget.username, widget.profilepicture, widget.cameras, widget.entitypaths)),
                        );
                      },
                      child: const Text('Next'),
                    ),
                  ),
                ),
              )*/
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
      )
    );
  }
}
