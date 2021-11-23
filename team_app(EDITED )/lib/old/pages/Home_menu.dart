import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<Home> {
  late WebViewController _controller;

  List pages = ["https://google.com", "https://apple.com"];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Main Page"),
        ),
        body: ListView(
          padding: EdgeInsets.all(24),
          children: [
            buildNewCard(),
          ],
        ),
      );

  Widget buildNewCard() => Card(
      shadowColor: Colors.red,
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.orangeAccent],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 400,
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
          ),
        ),
      ));
}

/*class ColorFilters {
  static final greyscale = ColorFilter.matrix(<double>[
    /// greyscale filter
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0
  ]);
}*/
