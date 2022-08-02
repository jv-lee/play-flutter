import 'package:flutter/material.dart';
import 'package:playflutter/base/page_state.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 登陆页面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends PageState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("login page."));
  }
}
