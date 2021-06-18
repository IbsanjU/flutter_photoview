import 'package:flutter/material.dart';
import 'package:flutter_photoview/photoview.dart';
import 'package:flutter_photoview/photoview_clipped.dart';
import 'package:flutter_photoview/photoview_controller.dart';
import 'package:flutter_photoview/photoview_gallery.dart';

void main() {
  runApp(MaterialApp(
    title: 'Ibs Photoview',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ibs photoview')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('PhotoView'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoViewListPage(title: 'PhotoView'),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('PhotoView Clipped'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ClippedPhotoViewPage(title: 'PhotoView Clipped'),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('PhotoView Controller'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ControllerPhotoViewPage(title: 'PhotoView Controller'),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('PhotoView Controller'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PhotoViewGalleryPage(title: 'PhotoView Gallery'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
