import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class ArticleWebScreen extends StatefulWidget {
  String blogUrl;

  ArticleWebScreen({super.key, required this.blogUrl});

  @override
  State<ArticleWebScreen> createState() => _ArticleWebScreenState();
}

class _ArticleWebScreenState extends State<ArticleWebScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.blogUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (value) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            const Center(
              child: SpinKitCircle(
                color: Colors.blue, // You can customize the color
                size: 50.0, // You can customize the size
              ),
            ),
        ],
      ),
    );
  }
}
