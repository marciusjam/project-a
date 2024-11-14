import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostViewer extends StatelessWidget {
  final String imageUrl, orientation;
  const PostViewer({super.key, required this.imageUrl, required this.orientation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page')),
      body: AspectRatio(
        aspectRatio: orientation == 'horizontal' ? 16/9 : 9/16,
        //width: MediaQuery.sizeOf(context).width,
        child: Hero(
          tag: 'imageHero', // Same tag as the first page
          child: CachedNetworkImage(
                                            //key: globalImageKey,
                                            imageUrl: imageUrl,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Container(
                                                  height: double.infinity,
                                                  //height: 600,
                                                  width: double.infinity,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            height: double.infinity,
                                            //height: 600,
                                            width: double.infinity,
                                            fit: BoxFit.cover)
        ),
      ),
    );
  }
}