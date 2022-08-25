import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/extensions/exception_extensions.dart';
import 'package:playflutter/model/entity/details.dart';
import 'package:playflutter/model/http/constants/api_constants.dart';
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
  void onCollect() {
    // 校验是否已收藏
    if (detailsData.isCollect) {
      Toast.show(ThemeStrings.menuCollectCompleted);
      return;
    }

    // 添加延时过渡loading
    Future.delayed(const Duration(milliseconds: 300), () {
      // 显示loading弹窗
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => const LoadingDialog());
      _model.postCollectAsync(detailsData.id).then((value) {
        detailsData.isCollect = true;
        Toast.show(ThemeStrings.menuCollectComplete);
      }).catchError((onError) {
        onFailedToast(onError);
      }).whenComplete(() => Navigator.of(context).pop());
    });
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

  /// webView开始加载
  void onPageStarted(url) {
    viewStates.pageHolderVisible = false;
    notifyListeners();
  }

  /// webView加载完毕
  void onPageFinished(url) {
    viewStates.progressVisible = false;
    notifyListeners();
  }

  /// webView加载Progress
  void onProgress(progress) {
    viewStates
      ..progressVisible = progress != 100
      ..progress = progress;
    notifyListeners();
  }

  /// 处理scheme intent跳转原生逻辑
  FutureOr<NavigationDecision> navigationDelegate(NavigationRequest request) {
    for (var scheme in ApiConstants.WEB_SCHEME_LIST) {
      if (request.url.startsWith(scheme)) {
        return NavigationDecision.prevent;
      }
    }
    return NavigationDecision.navigate;
  }
}

class _DetailsViewState {
  WebViewController? webViewController;
  var pageHolderVisible = true;
  var progressVisible = true;
  var progress = 0;
}
