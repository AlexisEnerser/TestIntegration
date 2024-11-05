import 'package:flutter/Material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '../../../../CustomLibraries/WebWebView/fwfh_webview.dart';

class ModalReportWeb extends StatefulWidget {
  final String url;
  const ModalReportWeb({super.key, required this.url});

  @override
  State<ModalReportWeb> createState() => _ModalReportWebState();
}

class _ModalReportWebState extends State<ModalReportWeb> {
   @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_,constraints){
        return HtmlWidget(
          '<iframe src="${widget.url}" width=${constraints.constrainWidth()} height="100%"></iframe>',
          factoryBuilder: () => MyWidgetFactory(),
        );
      }
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}

