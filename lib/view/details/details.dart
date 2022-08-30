import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/model/entity/details.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/details/mixin/web_scroll_mixin.dart';
import 'package:playflutter/view/details/viewmodel/details_viewmodel.dart';
import 'package:playflutter/widget/common/app_popup_menu_divider.dart';
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

class _DetailsState extends BasePageState<DetailsPage>
    with SingleTickerProviderStateMixin, WebScrollMixin {
  @override
  void initState() {
    bindTickerProvider(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildViewModel<DetailsViewModel>(
        create: (context) =>
            DetailsViewModel(context, detailsData: widget.detailsData),
        viewBuild: (context, viewModel) => Platform.isIOS
            ? buildContent(viewModel)
            : WillPopScope(
                onWillPop: viewModel.onBackChange,
                child: buildContent(viewModel)));
  }

  Widget buildContent(DetailsViewModel viewModel) {
    return Scaffold(
        appBar: AppBar(
            title: Text(viewModel.detailsData.title),
            actions: [buildActionMenu(viewModel)],
            leading: BackButton(onPressed: () => Navigator.pop(context))),
        body: buildWebPage(viewModel));
  }

  /// 构建更多菜单按钮弹窗
  Widget buildActionMenu(DetailsViewModel viewModel) {
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ThemeDimens.offsetRadiusMedium)),
        constraints: const BoxConstraints(maxWidth: 75),
        offset: const Offset(0, ThemeDimens.toolbarHeight),
        itemBuilder: (context) => [
              PopupMenuItem(
                  height: 30,
                  onTap: () => viewModel.onCollect(),
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(ThemeStrings.menuCollect))),
              AppPopupMenuDivider(
                  height: 1, color: Theme.of(context).primaryColorLight),
              PopupMenuItem(
                  height: 30,
                  onTap: () => viewModel.onShare(),
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(ThemeStrings.menuShare)))
            ]);
  }

  /// 构建webView页面
  Widget buildWebPage(DetailsViewModel viewModel) {
    return Stack(children: [
      Listener(
          onPointerMove: onMoveEvent,
          onPointerUp: onUpEvent,
          child: WebView(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              initialUrl: viewModel.detailsData.link,
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              onWebViewCreated: (controller) {
                viewModel.viewStates.webViewController = controller;
                bindWebViewController(controller);
              },
              onProgress: viewModel.onProgress,
              onPageStarted: viewModel.onPageStarted,
              onPageFinished: viewModel.onPageFinished,
              navigationDelegate: viewModel.navigationDelegate)),
      Visibility(
          visible: viewModel.viewStates.pageHolderVisible,
          child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Theme.of(context).scaffoldBackgroundColor)),
      Visibility(
          visible: viewModel.viewStates.progressVisible,
          child: LinearProgressIndicator(
              value: (viewModel.viewStates.progress / 100))),
      Align(
          alignment: Alignment.bottomCenter,
          child: Visibility(
              visible: viewModel.viewStates.webNavigationVisible,
              child: buildWebNavigationBar(viewModel)))
    ]);
  }

  Widget buildWebNavigationBar(DetailsViewModel viewModel) {
    return Container(
      width: double.infinity,
      height: ThemeDimens.toolbarHeight,
      color: Theme.of(context).cardColor,
      transform:
          Transform.translate(offset: Offset(0, webScrollViewStates.offsetY))
              .transform,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () => viewModel.viewStates.webViewController?.goBack(),
              child: Icon(Icons.arrow_back_ios,
                  color: viewModel.viewStates.canGoBack
                      ? Theme.of(context).primaryColorLight
                      : Colors.grey)),
          GestureDetector(
              onTap: () => viewModel.viewStates.webViewController?.goForward(),
              child: Icon(Icons.arrow_forward_ios,
                  color: viewModel.viewStates.canGoForward
                      ? Theme.of(context).primaryColorLight
                      : Colors.grey))
        ],
      ),
    );
  }
}
