import 'package:flutter/material.dart';

class ImgList extends StatefulWidget {
  const ImgList({super.key, required this.title});

  final String title;

  static String searchingTag = '';

  @override
  State<ImgList> createState() => _ImgListState();
}

class _ImgListState extends State<ImgList> {
  //https://api.flickr.com/services/feeds/photos_public.gne?tags=${this.tags}&format=json&nojsoncallback=1

  Text _toShow = const Text('Loading...');

  @override
  Widget build(BuildContext context) {
    sth();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(40.0),
              child: _toShow,
            ),
          ],
        ),
      ),
    );
  }
}
