import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/tools/cache_tools.dart';
import 'package:playflutter/view/account/service/account_service.dart';
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

  void clearCache() async {
    Directory directory = await getApplicationDocumentsDirectory();
    CacheTools.delDir(directory).then((value) => _changeCache());
  }

  void logout() {
    accountService.requestLogout(context);
  }
}

class _SettingsViewState {
  String cacheSize = "0.0kb";
}
