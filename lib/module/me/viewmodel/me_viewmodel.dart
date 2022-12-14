import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/core/base/base_viewmodel.dart';
import 'package:playflutter/core/extensions/function_extensions.dart';
import 'package:playflutter/core/route/route_names.dart';
import 'package:playflutter/core/theme/theme_images.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/module/account/service/account_service.dart';
import 'package:playflutter/module/me/model/entity/me_item.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 我的页面 viewModel
class MeViewModel extends BaseViewModel {
  var viewStates = _MeViewState();
  late AccountService accountService;

  MeViewModel(super.context);

  @override
  void init() {
    accountService = context.read<AccountService>();
    accountService.addListener(_changeViewState);
    _changeViewState();
  }

  @override
  void onCleared() {
    accountService.removeListener(_changeViewState);
  }

  void headerClick() {
    if (!viewStates.isLogin) {
      Navigator.pushNamed(context, RouteNames.login);
    }
  }

  void itemClick(route) {
    // 无需校验登陆状态
    if (route == RouteNames.settings) {
      Navigator.pushNamed(context, route);
      return;
    }

    // 需要校验登陆状态
    if (viewStates.isLogin) {
      Navigator.pushNamed(context, route);
    } else {
      Toast.show("login_alert".localized());
      Navigator.pushNamed(context, RouteNames.login);
    }
  }

  void _changeViewState() {
    accountService.viewStates.run((self) {
      if (self.isLogin) {
        viewStates
          ..userName = self.nickname
          ..userDesc = "等级：${self.level} 排名：${self.rank}"
          ..headerWidget = Image.asset(ThemeImages.launcherRoundPng);
      } else {
        viewStates = _MeViewState();
      }
      viewStates.isLogin = self.isLogin;
      notifyListeners();
    });
  }
}

class _MeViewState {
  Widget headerWidget = Padding(
      padding: const EdgeInsets.all(6),
      child: SvgPicture.asset(ThemeImages.meAccountSvg));
  String userName = "me_account_default_text".localized();
  String userDesc = "";
  bool isLogin = false;
  List<MeItem> meItems = MeItem.getMeItems();
}
