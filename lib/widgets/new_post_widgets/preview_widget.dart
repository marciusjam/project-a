import 'dart:async';
import 'dart:io';
import 'package:agilay/models/ModelProvider.dart';
import 'package:agilay/models/Post.dart';
import 'package:agilay/widgets/new_post_widgets/image_item_widget.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_player/video_player.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';

class PreviewPage extends StatefulWidget {
  final TextEditingController descriptionController;
  const PreviewPage({Key? key, required this.descriptionController})
      : super(key: key);
  @override
  _PreviewPageState createState() =>
      _PreviewPageState(descriptionController: descriptionController);
}

class _PreviewPageState extends State<PreviewPage> {
  final TextEditingController descriptionController;
  late AmplifyDataStore datastorePlugin;
  var _isLoading;

  final hubSubscription =
      Amplify.Hub.listen(HubChannel.Auth, (AuthHubEvent hubEvent) async {
    if (hubEvent.eventName == 'SIGNED_OUT') {
      try {
        await Amplify.DataStore.clear();
        safePrint('DataStore is cleared as the user has signed out.');
      } on DataStoreException catch (e) {
        safePrint('Failed to clear DataStore: $e');
      }
    }
  });

  bool _listeningToHub = true;

  /*bool _amplifyConfigured = false;

  final AmplifyDataStore _dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  final AmplifyAPI _apiPlugin = AmplifyAPI();
  final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();*/

  _PreviewPageState({required this.descriptionController});
  @override
  void initState() {
    super.initState();
    //_configureAmplify();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _createPost() async {
    final content = this.descriptionController.text;
    debugPrint('content: ' + content);
    try {
      final post = Post(
          description: content,
          likes: 15,
          status: PostStatus.ACTIVE,
          content: "Lorem ipsum dolor sit amet");

      await Amplify.DataStore.save(post);
      //changeSync();
      // Post created successfully, navigate to the next screen or show a success message
    } on DataStoreException {
      safePrint('Could not update post, maybe the title has been changed?');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> changeSync() async {
    try {
      await Amplify.DataStore.stop();
    } catch (error) {
      print('Error stopping DataStore: $error');
    }

    try {
      await Amplify.DataStore.start();
    } on Exception catch (error) {
      print('Error starting DataStore: $error');
    }
  }

  void _configureAmplify() async {
    try {
      datastorePlugin = AmplifyDataStore(
        modelProvider: ModelProvider.instance,
        errorHandler: ((error) =>
            {print("Custom ErrorHandler received: " + error.toString())}),
      );
      await Amplify.addPlugin(datastorePlugin);

      // Configure

      // Uncomment the below lines to enable online sync.
      // await Amplify.addPlugin(AmplifyAPI());
      // await Amplify.configure(amplifyconfig);

      // Remove this line when using the lines above for online sync
      await Amplify.configure("{}");
    } on AmplifyAlreadyConfiguredException {
      await Amplify.DataStore.start();
      print(
          'Amplify was already configured. Looks like app restarted on android.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Got something to share?',
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
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context, true),
            child: Icon(Icons.close_rounded),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //const SizedBox(height: 10),

                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: SizedBox(
                                            width: 45,
                                            height: 45,
                                            child: InkWell(
                                              onTap: () => {},
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.amber,
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage: AssetImage(
                                                          'assets/profile-jam.jpg'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  125,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Marcius',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        //color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: RichText(
                                                      textScaleFactor:
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                      text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                descriptionController
                                                                    .text,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                //color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ]),
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

              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: Container(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                      _createPost();
                    },
                    child: const Text('Post'),
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
