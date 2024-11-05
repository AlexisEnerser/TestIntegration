import 'package:flutter/Material.dart';
import 'package:zohoanalytics/Views/Components/NoResults.dart';
import '../FirstPageLogic.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '../../../../../CustomLibraries/WebWebView/fwfh_webview.dart';

class FirstPageWeb extends StatefulWidget {
  final FirstPageLogic logic;
  const FirstPageWeb({super.key, required this.logic});

  @override
  State<FirstPageWeb> createState() => _FirstPageWebState();
}

class _FirstPageWebState extends State<FirstPageWeb> {
  late String url;

  @override
  void initState() {
    url = widget.logic.getUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return url.isNotEmpty
    ?LayoutBuilder(
      builder: (_,constraints){
        return HtmlWidget(
          '<iframe src="$url" width=${constraints.constrainWidth()} height="100%"></iframe>',
          factoryBuilder: () => MyWidgetFactory(),
        );
      }
    )
    :const NoResults();
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}