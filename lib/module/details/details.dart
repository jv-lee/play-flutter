import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/model/entity/details.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/core/theme/theme_strings.dart';
import 'package:playflutter/core/widget/common/app_popup_menu_divider.dart';
import 'package:playflutter/core/widget/common/route_lazy_load.dart';
import 'package:playflutter/module/details/mixin/web_navigation_mixin.dart';
import 'package:playflutter/module/details/mixin/web_progress_mixin.dart';
import 'package:playflutter/module/details/viewmodel/details_viewmodel.dart';
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
    with TickerProviderStateMixin, WebProgressMixin, WebNavigationMixin {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<DetailsViewModel>(
        create: (context) =>
            DetailsViewModel(context, detailsData: widget.detailsData),
        // ios直接使用内容页面，无需拦截back事件，android需要拦截back事件处理web页面回退
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
          onPointerCancel: onUpEvent,
          child: RouteLazyLoad(
              child: WebView(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  initialUrl: viewModel.detailsData.link,
                  javascriptMode: JavascriptMode.unrestricted,
                  gestureNavigationEnabled: true,
                  onWebViewCreated: (controller) {
                    viewModel.viewStates.webViewController = controller;
                    bindWebViewController(controller);
                  },
                  onPageStarted: (url) {
                    onNavigationPageStarted(url);
                    onProgressPageStarted(url);
                  },
                  onPageFinished: (url) {
                    onNavigationPageFinished(url);
                    onProgressPageFinished(url);
                  },
                  navigationDelegate: viewModel.navigationDelegate))),
      Visibility(
          visible: webNavigationViewStates.pageHolderVisible,
          child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Theme.of(context).scaffoldBackgroundColor)),
      Visibility(
          visible: webProgressViewStates.progressVisible,
          child: LinearProgressIndicator(
              value: (webProgressViewStates.progress / 100))),
      Align(
          alignment: Alignment.bottomCenter,
          child: Visibility(
              visible: webNavigationViewStates.webNavigationInit,
              child: buildWebNavigationBar(viewModel)))
    ]);
  }

  Widget buildWebNavigationBar(DetailsViewModel viewModel) {
    return Container(
        width: double.infinity,
        height: ThemeDimens.toolbarHeight,
        decoration:
            BoxDecoration(color: Theme.of(context).cardColor, boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              offset: Offset.zero,
              blurRadius: 15.0,
              spreadRadius: 1.0)
        ]),
        transform: Transform.translate(
                offset: Offset(0, webNavigationViewStates.offsetY))
            .transform,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          GestureDetector(
              onTap: () => onGoBack(),
              child: Icon(Icons.arrow_back_ios,
                  color: webNavigationViewStates.canGoBack
                      ? Theme.of(context).primaryColorLight
                      : Colors.grey)),
          GestureDetector(
              onTap: () => onGoForward(),
              child: Icon(Icons.arrow_forward_ios,
                  color: webNavigationViewStates.canGoForward
                      ? Theme.of(context).primaryColorLight
                      : Colors.grey))
        ]));
  }
}
