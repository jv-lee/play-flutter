import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/extensions/exception_extensions.dart';
import 'package:playflutter/model/entity/details.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/me/model/me_model.dart';
import 'package:playflutter/widget/dialog/loading_dialog.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author jv.lee
/// @date 2022/8/8
/// @description 详情页viewModel
class DetailsViewModel extends BaseViewModel {
  final _model = MeModel();
  final viewStates = _DetailsViewState();
  final DetailsData detailsData;

  DetailsViewModel(super.context, {required this.detailsData});

  @override
  void init() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void onCleared() {
    _model.dispose();
  }

  /// 收藏该文章
  void onCollect() async {
    // 校验是否已收藏
    if (detailsData.isCollect) {
      Toast.show(ThemeStrings.menuCollectCompleted);
      return;
    }

    // 添加延时过渡loading弹窗
    await Future.delayed(const Duration(milliseconds: 300));
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    // 发起收藏
    _model.postCollectAsync(detailsData.id).then((value) {
      detailsData.isCollect = true;
      Toast.show(ThemeStrings.menuCollectComplete);
    }).catchError((onError) {
      onFailedToast(onError);
    }).whenComplete(() => Navigator.of(context).pop());
  }

  /// 分享该文章链接
  void onShare() {
    if (isDispose()) return;
    Share.share("${detailsData.title}:${detailsData.link}");
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
}
