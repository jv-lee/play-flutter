import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/extensions/exception_extensions.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/model/entity/details.dart';
import 'package:playflutter/core/widget/dialog/loading_dialog.dart';
import 'package:playflutter/module/details/theme/theme_details.dart';
import 'package:playflutter/module/me/model/me_model.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author jv.lee
/// @date 2022/8/8
/// @description 详情页viewModel
class DetailsViewModel extends BaseViewModel {
  final _meModel = MeModel();
  final viewStates = _DetailsViewState();

  DetailsViewModel(super.context);

  @override
  void init() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    runViewContext((context) => {
          getArgument<DetailsData>()
              ?.run((self) => viewStates.detailsData = self)
        });
  }

  @override
  void onCleared() {
    _meModel.dispose();
  }

  /// 收藏该文章
  void onCollect() async {
    // 校验是否已收藏
    if (viewStates.detailsData.isCollect) {
      Toast.show(ThemeDetails.strings.menuCollectCompleted);
      return;
    }

    // 添加延时过渡loading弹窗
    await Future.delayed(const Duration(milliseconds: 300));
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    // 发起收藏
    _meModel.postCollectAsync(viewStates.detailsData.id).then((value) {
      viewStates.detailsData.isCollect = true;
      Toast.show(ThemeDetails.strings.menuCollectComplete);
    }).catchError((onError) {
      onFailedToast(onError);
    }).whenComplete(() => Navigator.of(context).pop());
  }

  /// 分享该文章链接
  void onShare() {
    if (isDisposed()) return;
    Share.share(
        "${viewStates.detailsData.title}:${viewStates.detailsData.link}");
  }

  /// 监听webView是否可回退拦截back事件处理web回退逻辑
  Future<bool> onBackChange() async {
    var canGoBack = await viewStates.webViewController?.canGoBack() ?? false;
    if (canGoBack) {
      viewStates.webViewController?.goBack();
      return false;
    }
    return true;
  }

  /// 处理scheme intent跳转原生逻辑
  FutureOr<NavigationDecision> navigationDelegate(NavigationRequest request) {
    if (request.url.startsWith("https://") ||
        request.url.startsWith("http://")) {
      return NavigationDecision.navigate;
    } else {
      return NavigationDecision.prevent;
    }
  }
}

class _DetailsViewState {
  WebViewController? webViewController;
  DetailsData detailsData = DetailsData();
}
