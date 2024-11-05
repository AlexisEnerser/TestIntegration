import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ModalReportMovil extends StatefulWidget {
  final String url;
  const ModalReportMovil({super.key, required this.url});

  @override
  State<ModalReportMovil> createState() => _ModalReportMovilState();
}

class _ModalReportMovilState extends State<ModalReportMovil> {

  late WebViewController _controller;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  UniqueKey _key = UniqueKey();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }


  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
        key: _key,
        gestureRecognizers: gestureRecognizers,
        controller: _controller
    );
  }
}
