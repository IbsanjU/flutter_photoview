import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewListPage extends StatefulWidget {
  PhotoViewListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PhotoViewListPageState createState() => _PhotoViewListPageState();
}

class _PhotoViewListPageState extends State<PhotoViewListPage> {
  @override
  void initState() {
    super.initState();
    photoViewController2 = PhotoViewController();
  }

  @override
  void dispose() {
    super.dispose();
    //! Don't forget to dispose of the controller!
    photoViewController2.dispose();
  }

  int _index = 0;
  PhotoViewController photoViewController2 = PhotoViewController();

  final imageList = [
    'https://i2.wp.com/resocoder.com/wp-content/uploads/2019/04/clipped-photo-view.gif',
    'https://images.hindustantimes.com/img/2021/06/13/550x309/ITBP_jawans_scaling_Himalayas_1623577544487_1623577548814.jpg',
  ];
  void _incrementCounter() {
    setState(() {
      if (_index < imageList.length - 1) {
        _index++;
        photoViewController2.scale = photoViewController2.initial.scale;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_index > 0) {
        _index--;
        photoViewController2.scale = photoViewController2.initial.scale;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PhotoView(
        controller: photoViewController2,
        imageProvider: CachedNetworkImageProvider(
          imageList[_index],
          cacheKey: imageList[_index],
        ),
        // Contained = the smallest possible size to fit one dimension of the screen
        minScale: PhotoViewComputedScale.contained * 0.8,
        // Covered = the smallest possible size to fit the whole screen
        maxScale: PhotoViewComputedScale.covered * 2,
        enableRotation: false,
        // Set the background color to the "classic white"
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        loadingBuilder: (context, event) => Center(
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes,
          ),
        ),
      ),
      floatingActionButton: (imageList.length > 1)
          ? Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: 'hero1',
                    onPressed: _decrementCounter,
                    tooltip: 'Increment',
                    child: Icon(Icons.chevron_left),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    '${_index + 1} / ${imageList.length}',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  SizedBox(width: 5.0),
                  FloatingActionButton(
                    heroTag: 'hero2',
                    onPressed: _incrementCounter,
                    tooltip: 'Increment',
                    child: Icon(Icons.chevron_right),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
