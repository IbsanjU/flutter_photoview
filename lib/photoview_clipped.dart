import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ClippedPhotoViewPage extends StatelessWidget {
  final String title;

  const ClippedPhotoViewPage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        // Dynamically set a fixed size for the child widget,
        // so that it takes up the most possible screen space
        // while adhering to the defined aspect ratio
        child: AspectRatio(
          aspectRatio: 16 / 9,
          // Puts a "mask" on the child, so that it will keep its original, unzoomed size
          // even while it's being zoomed in
          child: ClipRect(
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(
                'https://i2.wp.com/resocoder.com/wp-content/uploads/2019/04/clipped-photo-view.gif',
              ),
              // Contained = the smallest possible size to fit one dimension of the screen
              minScale: PhotoViewComputedScale.contained * 0.8,
              // Covered = the smallest possible size to fit the whole screen
              maxScale: PhotoViewComputedScale.covered * 2,
              enableRotation: true,
              loadingBuilder: (context, event) => Center(
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
