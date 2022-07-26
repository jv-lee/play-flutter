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

  @override
  void init() {}

  @override
  void unInit() {}

  void changeShareTitle(text) {
    shareTitle = text;
  }

  void changeShareLink(text) {
    shareLink = text;
  }

  void submitShare() {
    runViewContext((context) {
      if (shareTitle.isEmpty || shareLink.isEmpty) {
        Toast.show("title || content is empty.", context);
        return;
      }
      // 隐藏输入框 延时发起逻辑
      FocusManager.instance.primaryFocus?.unfocus();
      Future.delayed(const Duration(milliseconds: 300), () {
        // 显示loading弹窗
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => const LoadingDialog());

        // 提交请求
        _model.postShareDataSync(shareTitle, shareLink).then((value) {
          Toast.show(ThemeStrings.square_share_request_success, context);
        }).catchError((onError) {
          Toast.show((onError as HttpException).message, context);
        }).whenComplete(() => Navigator.of(context).pop());
      });
    });
  }
}
