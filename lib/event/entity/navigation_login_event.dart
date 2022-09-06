import 'package:flutter/material.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/view/account/service/account_service.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/9/6
/// @description 登陆状态失效重新发起登陆事件
class NavigationLoginEvent {
  void onEvent(BuildContext context) {
    // 注销登陆状态及登陆数据
    context.read<AccountService>().updateAccountStatus(null, false);
    // 导航至登陆页面
    Navigator.pushNamed(context, RouteNames.login);
  }
}
