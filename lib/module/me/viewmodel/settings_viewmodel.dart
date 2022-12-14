import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/tools/file_tools.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/core/widget/dialog/confirm_dialog.dart';
import 'package:playflutter/module/account/service/account_service.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/8/4
/// @description app设置页面viewModel
class SettingsViewModel extends BaseViewModel {
  final viewStates = _SettingsViewState();
  late AccountService accountService;

  SettingsViewModel(super.context);

  @override
  void init() {
    accountService = context.read<AccountService>();
    accountService.addListener(notifyListeners);
    _changeCache();
  }

  @override
  void onCleared() {
    accountService.removeListener(notifyListeners);
  }

  void _changeCache() async {
    var cacheSize = await FileTools.loadApplicationCache();
    viewStates.cacheSize = FileTools.formatSize(cacheSize);
    notifyListeners();
  }

  void clearCache() {
    showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
            titleText: "settings_clear_title".localized(),
            onCancel: () => Navigator.pop(context),
            onConfirm: () async {
              Navigator.pop(context);
              FileTools.clearApplicationCache().then((value) => _changeCache());
            }));
  }

  void logout() {
    showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
            titleText: "settings_logout_title".localized(),
            onCancel: () => Navigator.pop(context),
            onConfirm: () {
              Navigator.pop(context);
              runViewContext(
                  (context) => accountService.requestLogout(context));
            }));
  }
}

class _SettingsViewState {
  String cacheSize = "0.0kb";
}
