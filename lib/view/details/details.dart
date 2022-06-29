import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/entity/details.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
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
  var progressVisible = true;
  var progress = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detailsData.title),
        actions: [
          PopupMenuButton(
              offset: const Offset(0, ThemeDimens.toolbar_height),
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
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.detailsData.link,
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
            onProgress: onProgress,
            onPageFinished: onPageFinished,
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith("jianshu://")) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onWebViewCreated: (controller) {},
          ),
          Visibility(
              visible: progressVisible,
              child: LinearProgressIndicator(
                value: (progress / 100),
              ))
        ],
      ),
    );
  }

  void onPageFinished(item) {
    setState(() {
      progressVisible = false;
    });
  }

  void onProgress(progress) {
    setState(() {
      this.progress = progress;
    });
  }
}
