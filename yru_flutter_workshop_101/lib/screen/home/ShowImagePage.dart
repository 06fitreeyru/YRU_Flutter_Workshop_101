import 'package:flutter/material.dart';

class ShowImagePage extends StatefulWidget {

  final String title;
  final String imgUrl;

  const ShowImagePage({Key key, this.title, this.imgUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ShowImagePageState();
  }
}

class _ShowImagePageState extends State<ShowImagePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
        // title: Text(widget.title),
      // ),
      body: new Container(
          color: Colors.white,
          padding: new EdgeInsets.all(16.0),
          child: Column(
          children: [
            Text('${widget.title}'),
            Image.network('${widget.imgUrl}'),
          ],
        ),
      ),
    );
  }


}

