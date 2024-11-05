import 'package:flutter/Material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zohoanalytics/Views/Components/NoResults.dart';

import '../FirstPageLogic.dart';

class FirstPageMovil extends StatefulWidget {
  final FirstPageLogic logic;
  const FirstPageMovil({super.key, required this.logic});

  @override
  State<FirstPageMovil> createState() => _FirstPageMovilState();
}

class _FirstPageMovilState extends State<FirstPageMovil> {

  late WebViewController _controller;
   late String url;

  @override
  void initState() {
    super.initState();
    url = widget.logic.getUrl();
    if(url.isNotEmpty){
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) { },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
          ),
        )
        ..loadRequest(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return url.isNotEmpty
    ?Center(
      child: WebViewWidget(controller: _controller),
    )
    : const NoResults();
  }
}
