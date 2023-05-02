import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'img_page.dart';

class ImgList extends StatefulWidget {
  const ImgList({super.key});

  static String searchingTag = '';

  @override
  State<ImgList> createState() => _ImgListState();
}

class _ImgListState extends State<ImgList> {
  static const String _host = 'api.flickr.com';
  static const String _path = '/services/feeds/photos_public.gne';

  List<Widget> _imgList = List<Widget>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _downloadImages();
  }

  void _goToImageScreen(String imgUrl) {
    imgUrl = imgUrl.replaceAll('_m.jpg', '_b.jpg');
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImgPage(imgUrl)
      )
    );
  }

  Future<void> _downloadImages() async {
    try {
      String jsonText = await _getImagesListJsonText();
      Map json = jsonDecode(jsonText) as Map;

      json['items'].forEach((var item) {
        setState(() {
          _imgList.add(
            InkWell(
              child: Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.all(40.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          image: NetworkImage(item['media']['m'])
                      ),
                      Text(item['title'])
                    ]
                ),
              ),
              onTap: () => _goToImageScreen(item['media']['m']),
            ),
          );
        });
      });

    } catch(e) {
      print(e);
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
      print(e);
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollable(
        viewportBuilder: (context, scrollController) {
          return SingleChildScrollView(
            // controller: scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _imgList
            ),
          );
        },
      ),
    );
  }
}
