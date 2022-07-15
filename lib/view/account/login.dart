import 'package:flutter/material.dart';
import 'package:playflutter/base/vm_state.dart';
import 'package:playflutter/view/account/viewmodel/login_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 登陆页面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends VMState<LoginPage, LoginViewModel> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("login page."));
  }
}
