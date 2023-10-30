import 'dart:io';

import 'package:agilay/widgets/new_post_widgets/media_widget.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class CameraWidget extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraWidget(this.cameras);

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late String imagePath;
  bool _toggleCamera = false;
  CameraController? _controller;
  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();

    _initializeCamera();
  }

  void _initializeCamera() async {
    _controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    await _controller!.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  void _captureImage() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) {
          showMessage('Picture saved to $filePath');
          setCameraResult();
        }
      }
    });
  }

  void setCameraResult() {
    Navigator.pop(context, imagePath);
  }

  Future<String> takePicture() async {
    if (_controller!.value.isInitialized) {
      showMessage('Error: select a camera first.');
      //return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Images';
    await new Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (_controller!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      //return null;
    }

    try {
      await _controller!.takePicture();
    } on CameraException catch (e) {
      showException(e);
      //return null;
    }
    return filePath;
  }

  void onCameraSelected(CameraDescription cameraDescription) async {
    if (_controller! != null) await _controller!.dispose();
    _controller = CameraController(cameraDescription, ResolutionPreset.medium);

    _controller!.addListener(() {
      if (mounted) setState(() {});
      if (_controller!.value.hasError) {
        showMessage('Camera Error: ${_controller!.value.errorDescription}');
      }
    });

    try {
      await _controller!.initialize();
    } on CameraException catch (e) {
      showException(e);
    }

    if (mounted) setState(() {});
  }

  void showException(CameraException e) {
    logError(e.code, e.description.toString());
    showMessage('Error: ${e.code}\n${e.description}');
  }

  void showMessage(String message) {
    print(message);
  }

  void logError(String code, String message) =>
      print('Error: $code\nMessage: $message');

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    var camera = _controller!.value;
    // fetch screen size
    final size = MediaQuery.of(context).size;

    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * camera.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Scaffold(
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
        body: Stack(
          children: [
            Transform.scale(
              scale: scale,
              child: Center(
                child: CameraPreview(_controller!),
              ),
            ),
            /*Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: double.infinity,
                    height: 80.0,
                    padding: EdgeInsets.all(20.0),
                    color: Color.fromRGBO(00, 00, 00, 0.7),
                    child: Stack(children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: Container(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                )
                                /*Image.asset(
                            'assets/images/shutter_1.png',
                            width: 72.0,
                            height: 72.0,
                          ),*/
                                ),
                          ),
                        ),
                      ),
                    ]))),*/
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 80.0,
                  padding: EdgeInsets.all(20.0),
                  color: Color.fromRGBO(00, 00, 00, 0.7),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: Container(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.browse_gallery,
                                  color: Colors.white,
                                )
                                /*Image.asset(
                            'assets/images/shutter_1.png',
                            width: 72.0,
                            height: 72.0,
                          ),*/
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            onTap: () {
                              _captureImage();
                            },
                            child: Container(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.camera_rounded,
                                  color: Colors.white,
                                )
                                /*Image.asset(
                            'assets/images/shutter_1.png',
                            width: 72.0,
                            height: 72.0,
                          ),*/
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            onTap: () {
                              if (!_toggleCamera) {
                                onCameraSelected(widget.cameras[1]);
                                setState(() {
                                  _toggleCamera = true;
                                });
                              } else {
                                onCameraSelected(widget.cameras[0]);
                                setState(() {
                                  _toggleCamera = false;
                                });
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.cameraswitch_rounded,
                                  color: Colors.white,
                                )
                                /*Image.asset(
                            'assets/images/switch_camera_3.png',
                            color: Colors.grey[200],
                            width: 42.0,
                            height: 42.0,
                          ),*/
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));

    /*return AspectRatio(
      aspectRatio: 9 / 16, //_controller!.value.aspectRatio,
      child: CameraPreview(_controller!),
    );*/
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        //statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light)); // to re-show bars*/
  }
}
