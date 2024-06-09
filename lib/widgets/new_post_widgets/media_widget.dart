import 'dart:io';
import 'package:Makulay/widgets/custom_videoplayer.dart';
import 'package:Makulay/widgets/new_post_widgets/description_page.dart';
import 'package:Makulay/widgets/new_post_widgets/image_item_widget.dart';
import 'package:Makulay/widgets/new_post_widgets/preview_widget.dart';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';

class TextMediaWidget extends StatefulWidget {
    final List<CameraDescription> cameras;
   final String username;
   final String profile;
   final List<AssetEntity> preselectedAssets;
   final List<String> preentityPaths;
   final TextEditingController descriptionController;
  const TextMediaWidget(this.username, this.profile, this.cameras, this.preselectedAssets, this.preentityPaths, this.descriptionController, {Key? key}) : super(key: key);
  @override
  _TextMediaWidgetState createState() => _TextMediaWidgetState();
}

class _TextMediaWidgetState extends State<TextMediaWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  List<AssetEntity> selectedAssets = [];
  int _selectedIndex = 1;
  String selectedOption = '';
  //late VideoPlayerController _videoController;
  late TextEditingController _textController;
  List<AssetEntity> _galleryImages = [];
  XFile? _pickedVideo;
  final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );
  final int _sizePerPage = 50;

  String? orientation;
  String descriptionCurrentValue = '';

  late List<String> entityPaths = [];

  AssetPathEntity? _path;
  List<AssetEntity>? _entities;
  int _totalEntitiesCount = 0;

  int _page = 0;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

  //late VideoPlayerController _vidcontroller;

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
    debugPrint('paths list ' + _path.toString());
    debugPrint('widget.preselectedAssets ' + widget.preselectedAssets.toString());
    _requestAssets().then((_) {
        debugPrint('done running');
      });

      if(widget.preselectedAssets.length != 0 && widget.preentityPaths.length != 0){
        int fileHeight = widget.preselectedAssets![0].height;
                  int fileWidth = widget.preselectedAssets![0].width;
                  
                  
          setState(() {
            selectedAssets = widget.preselectedAssets!;
            entityPaths = widget.preentityPaths!;
            if(fileHeight > fileWidth){
                    orientation = 'vertical';
                  }else{
                    orientation = 'horizontal';
                  }
          });
          
      }

      if(widget.descriptionController.text != null || widget.descriptionController.text != ''){
        _descriptionController.text = widget.descriptionController.text;
      }
    debugPrint('selectedAssets ' + selectedAssets.toString());

    _descriptionController.addListener(_listenToDescValue);
    
  }

  Future<void> _listenToDescValue() async {
   setState(() {
      if(_descriptionController.text.isNotEmpty){
        descriptionCurrentValue = _descriptionController.text;
      }else{
        descriptionCurrentValue = '';
      }
      
    });
  }

  Future<void> _requestAssets() async {
    final status = await Permission.photos.request();
    debugPrint('ps status ' + status.toString());
    if (status == PermissionStatus.permanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enables it in the system settings.
      await openAppSettings();
    }
    if (status.isGranted) {
      // You have permission; proceed with fetching images

      setState(() {
        _isLoading = true;
      });
      // Request permissions.
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      if (!mounted) {
        return;
      }
      // Further requests can be only proceed with authorized or limited.
      if (!ps.hasAccess) {
        setState(() {
          _isLoading = false;
        });
        showToast('Permission is not accessible.');
        return;
      }

      debugPrint('ps permission ' + ps.toString());

      // Obtain assets using the path entity.
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        hasAll: true,
        //filterOption: _filterOptionGroup,
      );

      debugPrint('paths list ' + paths.toString());

      if (!mounted) {
        return;
      }
      // Return if not paths found.
      if (paths.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        showToast('No paths found.');
        return;
      }
      setState(() {
        _path = paths.first;
      });
      _totalEntitiesCount = await _path!.assetCountAsync;
      final List<AssetEntity> entities = await _path!.getAssetListPaged(
        page: 0,
        size: _sizePerPage,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _entities = entities;
        _isLoading = false;
        _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
      });
    }
  }

  @override
  void dispose() {
    //_vidcontroller.dispose();
    //_textController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    setState(() {
      _pickedVideo = pickedVideo;
    });
  }

  Future<void> _loadMoreAsset() async {
    final List<AssetEntity> entities = await _path!.getAssetListPaged(
      page: _page + 1,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities!.addAll(entities);
      _page++;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
      _isLoadingMore = false;
    });
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    if (_path == null) {
      return const Center(child: Text('Request paths first.'));
    }
    if (_entities?.isNotEmpty != true) {
      return const Center(child: Text('No assets found on this device.'));
    }

    //debugPrint('entities' + _entities.toString());


    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == _entities!.length - 8 &&
              !_isLoadingMore &&
              _hasMoreToLoad) {
            _loadMoreAsset();
          }
          final AssetEntity entity = _entities![index];
          
          final isSelected = selectedAssets.contains(entity);
          return GestureDetector(
            onTap: () async {
                debugPrint('isSelected ' + isSelected.toString());
                debugPrint('_path' + _path.toString());
                debugPrint('entity' + entity.toString());

                if(selectedAssets.isEmpty){
                  int fileHeight = entity.height;
                  int fileWidth = entity.width;
                  
                  if(fileHeight > fileWidth){
                    orientation = 'vertical';
                  }else{
                    orientation = 'horizontal';
                  }
                }
                

                await _getFile(entity).then((value){

                  if (isSelected) {
                    entityPaths.remove(value!.path);
                  }else{
                    entityPaths.add(value!.path);
                  }
                  
                  return value!.path;
                });
                

              setState(() {
                

                if (isSelected) {
                  selectedAssets.remove(entity);
                } else {
                  selectedAssets.add(entity);
                }
                debugPrint('selectedAssets ' + selectedAssets.toString());

                debugPrint('entityPaths ' + entityPaths.toString());
              });
            },
            child: Stack(
              //fit: StackFit.expand,
              children: [
                /*Image(
                  image: AssetEntityImageProvider(entity),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),*/
                ImageItemWidget(
                  key: ValueKey<int>(index),
                  entity: entity,
                  option:
                      const ThumbnailOption(size: ThumbnailSize.square(200)),
                ),
                if (isSelected)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 32,
                    ),
                  ),
              ],
            ),
          );
        },
        childCount: _entities!.length,
        findChildIndexCallback: (Key key) {
          // Re-use elements.
          if (key is ValueKey<int>) {
            return key.value;
          }
          return null;
        },
      ),
    );
  }

  Future<File?> _getFile(AssetEntity loadedFile) {
   final fileLoaded = loadedFile.loadFile(isOrigin: true);
   
   return fileLoaded;
   
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

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.amber,
        content: Text(
          message.toString(),
          style: TextStyle(fontSize: 15),
        )));
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'New Post',
          style: TextStyle(
            color: Colors.black, // 3
          ),
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            //statusBarColor: Colors.black,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light),
        foregroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.black),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: Icon(Icons.close_rounded, color: Colors.black,),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,20,0),
            child: GestureDetector(
              onTap: (){Navigator.pop(context, true);
                        if(selectedAssets.length != 0){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DescriptionPage(widget.username, widget.profile, selectedAssets, widget.cameras, entityPaths, _descriptionController)),
                          );
                        }else{
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PreviewPage(widget.username, widget.profile, widget.cameras, entityPaths, descriptionController: _descriptionController, selectedAssetsController: [],)),
                          );
                        }
              },
              child: Text('Next', style: TextStyle(color: Colors.amber, fontSize: 15)),
          ),)
          ,],
      ),
      body:  Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              
              /*SizedBox(
                  height: 300,
                  child: Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: 
                  ))),*/
              //Divider(color: Colors.black),
            
Stack(alignment: Alignment.bottomCenter, children: [
  /**/

        selectedAssets.length != 0 && entityPaths.length != 0 ? 
        Container(height: MediaQuery.sizeOf(context).height - 210, width: double.maxFinite,
        child: AspectRatio(
              aspectRatio: selectedAssets[0].height > selectedAssets[0].width ? 9/16 : 16/9,
          child: CarouselSlider.builder(
        itemCount: selectedAssets.length,
        options: CarouselOptions(
          //autoPlay: true,
          //height: MediaQuery.of(context).size.height/2,
          aspectRatio: selectedAssets[0].height > selectedAssets[0].width ? 9/16 : 16/9,
          viewportFraction: 1,
          padEnds: selectedAssets.length == 1 ? true : false,
              enlargeCenterPage: false,
          enableInfiniteScroll: false
        ),
        itemBuilder: (context, index, realIdx) {
          return Container(
            child: Center(
                child: 
                selectedAssets[index].type == AssetType.image ?
                Image(
                  image: AssetEntityImageProvider(selectedAssets[index]),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ): 
                CustomVideoPlayer(orientation.toString() + '-file', null, 9/16, 'description', 'username', 'profilepicture', 2, entityPaths[index], true, null)
            )
          );
        },
      )),)
             : /*Container(height: MediaQuery.sizeOf(context).height - 210, width: double.maxFinite,
        child:AspectRatio(
              aspectRatio: 3/2, child: Center(child: Text('Choose a content to use', style: TextStyle(color: Colors.white),),)),),*/
              Container(
                height: MediaQuery.sizeOf(context).height - 210, width: double.maxFinite,
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                  child: Column(children: [
                    Card(
                        color: Colors.white, //Dark Mode
                        elevation: 1,
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
                                          10, // Set to null or a value greater than 1 for a large text field
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                          hintText: 'Got something in your mind?',
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

      descriptionCurrentValue == '' ?
      ExpansionTile(
            title: Container(),
            //Text(selectedAssets.length.toString() + '/5', style: TextStyle(color: Colors.black),),
            initiallyExpanded: true,
            leading: Padding(padding: EdgeInsets.fromLTRB(5,0,0,0), child: Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black, size: 40,)),
            tilePadding: EdgeInsets.fromLTRB(5,0,5,0),
            backgroundColor: Colors.white,
            trailing: 
            Padding(padding: EdgeInsets.fromLTRB(0,0,15,0), child: Text(selectedAssets.length.toString() + '/5', style: TextStyle(color: Colors.black, fontSize: 20),),),
            
            
            /*Container(
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white, 
                          
                          ),
                      onPressed: () {
                        Navigator.pop(context, true);
                        if(selectedAssets.length != 0){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DescriptionPage(widget.username, widget.profile, selectedAssets, widget.cameras, entityPaths, _descriptionController)),
                          );
                        }else{
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PreviewPage(widget.username, widget.profile, widget.cameras, entityPaths, descriptionController: _descriptionController, selectedAssetsController: [],)),
                          );
                        }
                        
                      },
                      child: Text('Next'),
                    ),
                  ),*/
            children: <Widget>[
              Column(
                children: [
                  
              Stack(alignment: Alignment.bottomCenter, children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: /*Padding(
                    padding: const EdgeInsets.all(15),
                    child:*/
                    SizedBox(
                  height: MediaQuery.of(context).size.height/2.5 ,
                  child:  _buildBody(context),
                ),
                //),
              ),),

              //),

              
     

             
            ],),
            
            ],
              ),
            ],
          ): 
          Container(),

          /*Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                  child: Container(
                    width: selectedAssets.isEmpty ? 200 : 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black, 
                          
                          ),
                      onPressed: () {
                        //Navigator.pop(context, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DescriptionPage(selectedAssets, widget.cameras)),
                        );
                      },
                      child: selectedAssets.isEmpty ? Text('Continue without content') : Text('Next'),
                    ),
                  ),
                ),
              ),*/
 

])


 

            

              



            ],
          ),
        ),
      ),)
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
