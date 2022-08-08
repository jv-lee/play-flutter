import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/model/entity/details.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/widget/common/app_popup_menu_divider.dart';
import 'package:share/share.dart';
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

class _DetailsState extends BasePageState<DetailsPage> {
  WebViewController? webViewController;
  var progressVisible = true;
  var progress = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackChange,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.detailsData.title),
            actions: [buildActionMenu()],
            leading: BackButton(onPressed: () => {Navigator.pop(context)}),
          ),
          body: buildWebPage(),
        ));
  }

  /// 监听webView是否可回退拦截back事件处理web回退逻辑
  Future<bool> onBackChange() async {
    var canGoBack = await webViewController?.canGoBack() ?? false;
    if (canGoBack) {
      webViewController?.goBack();
      return false;
    }
    return true;
  }

  /// 构建更多菜单按钮弹窗
  Widget buildActionMenu() {
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ThemeDimens.offset_radius_medium)),
        constraints: const BoxConstraints(maxWidth: 75),
        offset: const Offset(0, ThemeDimens.toolbar_height),
        itemBuilder: (context) => [
              PopupMenuItem(
                  height: 30,
                  onTap: () => {},
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(ThemeStrings.menu_collect),
                  )),
              AppPopupMenuDivider(
                  height: 1, color: Theme.of(context).primaryColorLight),
              PopupMenuItem(
                  height: 30,
                  onTap: () => {
                        Share.share(
                            "${widget.detailsData.title}:${widget.detailsData.link}")
                      },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(ThemeStrings.menu_share),
                  ))
            ]);
  }

  /// 构建webView页面
  Widget buildWebPage() {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.detailsData.link,
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          onProgress: onProgress,
          onPageFinished: onPageFinished,
          navigationDelegate: (NavigationRequest request) {
            // 处理简书页面,掘金页面 scheme intent跳转原生逻辑
            if (request.url.startsWith("jianshu://")) {
              return NavigationDecision.prevent;
            } else if (request.url.startsWith("bytedance://")) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
        ),
        Visibility(
            visible: progressVisible,
            child: LinearProgressIndicator(
              value: (progress / 100),
            ))
      ],
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
