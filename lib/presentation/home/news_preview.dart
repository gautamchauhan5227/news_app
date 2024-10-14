import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class NewsPreview extends StatefulWidget {
  final String webUrl;
  const NewsPreview({
    super.key,
    required this.webUrl,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NewsPreviewState createState() => _NewsPreviewState();
}

class _NewsPreviewState extends State<NewsPreview> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: WebViewX(
              initialContent: widget.webUrl,
              initialSourceType: SourceType.url,
              javascriptMode: JavascriptMode.disabled,
              width: double.infinity,
              height: double.infinity,
              onPageFinished: (url) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
