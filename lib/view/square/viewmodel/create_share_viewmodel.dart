import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/square/model/SquareModel.dart';
import 'package:playflutter/widget/dialog/loading_dialog.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/7/22
/// @description 创建分享内容viewModel
class CreateShareViewModel extends ViewModel {
  final SquareModel _model = SquareModel();
  late String shareTitle = "";
  late String shareLink = "";

  CreateShareViewModel(super.context);

  @override
  void init() {}

  @override
  void onCleared() {}

  void changeShareTitle(text) {
    shareTitle = text;
  }

  void changeShareLink(text) {
    shareLink = text;
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
      if (shareTitle.isEmpty || shareLink.isEmpty) {
        Navigator.of(context).pop();
        Toast.show("title || content is empty.");
        return;
      }

      // 提交请求
      _model.postShareDataSync(shareTitle, shareLink).then((value) {
        Toast.show(ThemeStrings.square_share_request_success);
        Navigator.of(context).pop();
      }).catchError((onError) {
        Toast.show((onError as HttpException).message);
      }).whenComplete(() => Navigator.of(context).pop());
    });
  }
}
