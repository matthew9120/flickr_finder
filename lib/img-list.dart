import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ImgList extends StatefulWidget {
  const ImgList({super.key, required this.title});

  final String title;

  static String searchingTag = '';

  @override
  State<ImgList> createState() => _ImgListState();
}

class _ImgListState extends State<ImgList> {
  static const String _host = 'api.flickr.com';
  static const String _path = '/services/feeds/photos_public.gne';

  Text _loadingText = Text('Loading...');
  late Column _mainColumn;

  Future<void> _downloadImages() async {
    try {
      String jsonText = await _getImagesListJsonText();
      Map json = jsonDecode(jsonText) as Map;

      // _mainColumn = Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: <Widget>[],
      // );

      //length
      for (int i = 0; i < json['items'].length; i++) {
        setState(() {
          _mainColumn.children[0] = Text(json['items'][i]['media']['m']);
        });
        // _mainColumn.children.add(
        //   Container(
        //     alignment: Alignment.center,
        //     margin: const EdgeInsets.all(40.0),
        // child: Image(
        //   image: NetworkImage(_data['media']['m'])
        // ),
        // ),
        // );
        // });
      }
    } catch(e) {
      _loadingText = Text(e.toString());
    }

  }

  Future<String> _getImagesListJsonText() async {
    try {
      Uri url = Uri.https(_host, _path, {
        'tags': ImgList.searchingTag,
        'format': 'json',
        'nojsoncallback': '1'
      });
      http.Response response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('HTTP request error');
      }

      return response.body;
    } catch (e) {
      _loadingText = const Text('There was an error, while downloading the list of images.');
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _downloadImages();

    _mainColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _loadingText,
      ],
    );

    return Scaffold(
      body: Center(
        child: _mainColumn
      ),
    );
  }
}
