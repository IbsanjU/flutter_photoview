import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ControllerPhotoViewPage extends StatefulWidget {
  final String title;

  const ControllerPhotoViewPage({Key key, this.title}) : super(key: key);
  @override
  _ControllerPhotoViewPageState createState() =>
      _ControllerPhotoViewPageState();
}

class _ControllerPhotoViewPageState extends State<ControllerPhotoViewPage> {
  @override
  void initState() {
    super.initState();
    photoViewController = PhotoViewController();
  }

  @override
  void dispose() {
    super.dispose();
    //! Don't forget to dispose of the controller!
    photoViewController.dispose();
  }

  PhotoViewController photoViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // Stack puts widgets "on top" of each other
      body: Stack(
        children: <Widget>[
          _buildPhotoView(context),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildScaleInfo(),
              _buildResetScaleButton(),
            ],
          )
        ],
      ),
    );
  }

  PhotoView _buildPhotoView(BuildContext context) {
    return PhotoView(
      controller: photoViewController,
      imageProvider: CachedNetworkImageProvider(
        'https://i2.wp.com/resocoder.com/wp-content/uploads/2019/04/clipped-photo-view.gif',
      ),
      // Contained = the smallest possible size to fit one dimension of the screen
      minScale: PhotoViewComputedScale.contained * 0.8,
      // Covered = the smallest possible size to fit the whole screen
      maxScale: PhotoViewComputedScale.covered * 2,
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
    );
  }

  StreamBuilder<PhotoViewControllerValue> _buildScaleInfo() {
    return StreamBuilder(
      // Listening on the PhotoView's controller stream
      stream: photoViewController.outputStateStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<PhotoViewControllerValue> snapshot,
      ) {
        if (!snapshot.hasData) return Container();
        return Center(
          child: Text(
            'Scale compared to the original: \n${snapshot.data.scale}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }

  RaisedButton _buildResetScaleButton() {
    return RaisedButton(
      child: Text('Reset Scale'),
      onPressed: () {
        photoViewController.scale = photoViewController.initial.scale;
      },
    );
  }
}
