import 'package:flutter/material.dart';
import 'package:playflutter/entity/details.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 内容详情页
class DetailsPage extends StatefulWidget {
  final DetailsData detailsData;

  const DetailsPage({super.key, required this.detailsData});

  @override
  State<StatefulWidget> createState() => _DetailsState();
}

class _DetailsState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detailsData.title),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () => {},
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const Text(ThemeStrings.menu_collect),
                        )),
                    PopupMenuItem(
                        onTap: () => {},
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const Text(ThemeStrings.menu_share),
                        ))
                  ])
        ],
      ),
      body: WebView(
        initialUrl: widget.detailsData.link,
        onProgress: (progress) => {},
      ),
    );
  }
}
