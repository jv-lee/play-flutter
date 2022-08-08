import 'dart:io';

import 'package:playflutter/base/base_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author jv.lee
/// @date 2022/8/8
/// @description
class DetailsViewModel extends BaseViewModel {
  final viewStates = _DetailsViewState();

  DetailsViewModel(super.context);

  @override
  void init() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void onCleared() {}

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
    if (isMounted()) {
      viewStates.progressVisible = false;
      notifyListeners();
    }
  }

  void onProgress(progress) {
    if (isMounted()) {
      viewStates.progress = progress;
      notifyListeners();
    }
  }
}

class _DetailsViewState {
  WebViewController? webViewController;
  var progressVisible = true;
  var progress = 0;
}
