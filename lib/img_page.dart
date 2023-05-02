import 'package:flutter/material.dart';

class ImgPage extends StatelessWidget {
  const ImgPage(this._imgUrl, {super.key});

  final String _imgUrl;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: NetworkImage(_imgUrl)
        ),
      ),
    );
  }
}
