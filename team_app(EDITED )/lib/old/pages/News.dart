import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NewsPage> {
  late WebViewController _controller;

  List pages = ["https://google.com", "https://apple.com"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: <Widget>[
        Container(
          width: 100,
          child: ListView.builder(
            itemCount: pages.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(pages[index]),
                onTap: () {
                  _controller.loadUrl(pages[index]);
                },
              );
            },
          ),
        ),
        Expanded(
          child: WebView(
            onWebViewCreated: (WebViewController c) {
              _controller = c;
            },
            initialUrl: 'https://stackoverflow.com',
          ),
        ),
      ],
    ));
  }
}
