// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/model/entity/details.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/me/model/me_model.dart';
import 'package:playflutter/widget/dialog/loading_dialog.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author jv.lee
/// @date 2022/8/8
/// @description
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

    // 显示loading弹窗
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    // 延时请求让loading显示更平滑
    Future.delayed(const Duration(milliseconds: 300), () {
      _model.postCollectAsync(detailsData.id).then((value) {
        detailsData.isCollect = true;
        Toast.show(ThemeStrings.menuCollectComplete);
      }).catchError((onError) {
        if (onError is HttpException) Toast.show(onError.message);
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

  void onPageFinished(item) {
    viewStates.progressVisible = false;
    notifyListeners();
  }

  void onProgress(progress) {
    viewStates.progress = progress;
    notifyListeners();
  }
}

class _DetailsViewState {
  WebViewController? webViewController;
  var progressVisible = true;
  var progress = 0;
}
