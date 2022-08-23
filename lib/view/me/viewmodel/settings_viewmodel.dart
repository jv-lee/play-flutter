import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/tools/cache_tools.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:playflutter/widget/dialog/confirm_dialog.dart';
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
    var cache = await CacheTools.loadApplicationCache();
    viewStates.cacheSize = CacheTools.formatSize(cache);
    notifyListeners();
  }

  void clearCache() {
    showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
            titleText: ThemeStrings.settingsClearTitle,
            onCancel: () => Navigator.pop(context),
            onConfirm: () async {
              Navigator.pop(context);
              Directory directory = await getApplicationDocumentsDirectory();
              CacheTools.delDir(directory).then((value) => _changeCache());
            }));
  }

  void logout() {
    showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
            titleText: ThemeStrings.settingsLogoutTitle,
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
