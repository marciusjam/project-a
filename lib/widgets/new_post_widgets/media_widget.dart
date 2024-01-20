import 'dart:io';
import 'package:Makulay/widgets/new_post_widgets/description_page.dart';
import 'package:Makulay/widgets/new_post_widgets/image_item_widget.dart';
import 'package:Makulay/widgets/new_post_widgets/preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_player/video_player.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';

class TextMediaWidget extends StatefulWidget {
  const TextMediaWidget({Key? key}) : super(key: key);
  @override
  _TextMediaWidgetState createState() => _TextMediaWidgetState();
}

class _TextMediaWidgetState extends State<TextMediaWidget> {
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

  AssetPathEntity? _path;
  List<AssetEntity>? _entities;
  int _totalEntitiesCount = 0;

  int _page = 0;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

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
    _requestAssets().then((_) {
        debugPrint('done running');
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
        type: RequestType.image,
        filterOption: _filterOptionGroup,
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
    //_videoController.dispose();
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

    debugPrint('entities' + _entities.toString());

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
            onTap: () {
              setState(() {
                debugPrint('isSelected ' + isSelected.toString());
                if (isSelected) {
                  selectedAssets.remove(entity);
                } else {
                  
                  selectedAssets.add(entity);
                }
                debugPrint('selectedAssets ' + selectedAssets.toString());
              });
            },
            child: Stack(
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
          'Upload',
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
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: /*Padding(
                    padding: const EdgeInsets.all(15),
                    child:*/
                    SizedBox(
                  height: 400,
                  child: Expanded(child: _buildBody(context)),
                ),
                //),
              ),

              //),

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
                              builder: (context) =>
                                  DescriptionPage(selectedAssets)),
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
