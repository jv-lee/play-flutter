import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:playflutter/view/me/model/entity/me_item.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description
class MeViewModel extends ViewModel {
  late AccountService accountService;
  late VoidCallback _accountListener;
  List<MeItem> meItems = MeItem.getMeItems();
  var viewStates = _MeViewState();

  MeViewModel(super.context);

  @override
  void init() {
    accountService = context.read<AccountService>();
    _changeViewState();
    accountService.addListener(_accountListener = () {
      _changeViewState();
      notifyListeners();
    });
  }

  @override
  void onCleared() {
    accountService.removeListener(_accountListener);
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
      Toast.show(ThemeStrings.login_alert);
      Navigator.pushNamed(context, RouteNames.login);
    }
  }

  void _changeViewState() {
    viewStates.isLogin = accountService.viewStates.isLogin;
    if (accountService.viewStates.isLogin) {
      final accountData = accountService.viewStates.accountData?.data;
      viewStates.headerWidget = Image.asset(ThemeImages.launcher_round_png);
      viewStates.userName = accountData?.userInfo.nickname ?? "";
      viewStates.userDesc =
          "等级：${accountData?.coinInfo.level} 排名：${accountData?.coinInfo.rank}";
    } else {
      viewStates = _MeViewState();
    }
  }
}

class _MeViewState {
  Widget headerWidget = Padding(
      padding: const EdgeInsets.all(6),
      child: SvgPicture.asset(ThemeImages.me_account_svg));
  String userName = ThemeStrings.me_account_default_text;
  String userDesc = "";
  bool isLogin = false;
}
