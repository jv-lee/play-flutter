import 'package:flutter/widgets.dart';
import 'package:playflutter/base/page_state.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 注册页面
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends PageState<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("register page."));
  }
}
