import 'package:flutter/widgets.dart';
import 'package:playflutter/base/vm_state.dart';
import 'package:playflutter/view/account/viewmodel/register_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 注册页面
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends VMState<RegisterPage, RegisterViewModel> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("register page."));
  }
}
