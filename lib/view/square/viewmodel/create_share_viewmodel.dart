import 'package:flutter/material.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/extensions/exception_extensions.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/square/model/square_model.dart';
import 'package:playflutter/widget/dialog/loading_dialog.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/7/22
/// @description 创建分享内容viewModel
class CreateShareViewModel extends BaseViewModel {
  final SquareModel _model = SquareModel();
  final viewStates = _CreateShareViewState();

  CreateShareViewModel(super.context);

  @override
  void init() {}

  @override
  void onCleared() {}

  void changeShareTitle(text) {
    viewStates.shareTitle = text;
  }

  void changeShareLink(text) {
    viewStates.shareLink = text;
  }

  void submitShare() {
    // 显示loading弹窗
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingDialog());

    // 隐藏输入框 延时发起逻辑
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (viewStates.shareTitle.isEmpty || viewStates.shareLink.isEmpty) {
        Navigator.of(context).pop();
        Toast.show("title || content is empty.");
        return;
      }

      // 提交请求
      _model.postShareDataSync(viewStates.shareTitle, viewStates.shareLink)
          .then((value) {
        Toast.show(ThemeStrings.squareShareRequestSuccess);
        Navigator.of(context).pop();
      }).catchError((onError) {
        onFailedToast(onError);
      }).whenComplete(() => Navigator.of(context).pop());
    });
  }
}

class _CreateShareViewState {
  String shareTitle = "";
  String shareLink = "";
}
