import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/module/account/theme/theme_account.dart';
import 'package:playflutter/module/account/viewmodel/login_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 登陆页面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<LoginViewModel>(
        create: (context) => LoginViewModel(context),
        viewBuild: (context, viewModel) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            // 全页面点击隐藏软键盘
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  buildTitle(),
                  buildInputContent(viewModel),
                  buildFooter(viewModel)
                ])))));
  }

  Widget buildTitle() {
    return Text(ThemeAccount.strings.loginTile,
        style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorLight));
  }

  Widget buildInputContent(LoginViewModel viewModel) {
    return Card(
        margin: EdgeInsets.all(ThemeCommon.dimens.offsetLarge),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ThemeCommon.dimens.offsetLarge)),
        color: Theme.of(context).cardColor,
        child: Padding(
            padding: EdgeInsets.all(ThemeCommon.dimens.offsetMedium),
            child: Column(children: [
              TextField(
                  onChanged: (text) => viewModel.changeUsername(text),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      icon: SvgPicture.asset(ThemeAccount.images.usernameSvg,
                          width: 24, height: 24),
                      hintText: ThemeAccount.strings.usernameText)),
              Divider(
                  height: 1,
                  thickness: 1,
                  indent: ThemeCommon.dimens.offsetMedium,
                  endIndent: ThemeCommon.dimens.offsetMedium,
                  color: Theme.of(context).scaffoldBackgroundColor),
              TextField(
                  onChanged: (text) => viewModel.changePassword(text),
                  onSubmitted: (text) => viewModel.requestLogin(),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: SvgPicture.asset(ThemeAccount.images.passwordSvg,
                          width: 24, height: 24),
                      hintText: ThemeAccount.strings.passwordText))
            ])));
  }

  Widget buildFooter(LoginViewModel viewModel) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: ThemeCommon.dimens.offsetLarge * 2),
        width: double.infinity,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Material(
              child: InkWell(
                  onTap: () => viewModel.navigationRegister(),
                  child: Text(ThemeAccount.strings.gotoRegisterText,
                      style: TextStyle(color: Theme.of(context).focusColor)))),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ThemeCommon.dimens.offsetRadiusMedium))),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => viewModel.viewStates.stateColor)),
              onPressed: () => viewModel.requestLogin(),
              child: Text(ThemeAccount.strings.loginButton,
                  style: const TextStyle(color: Colors.white)))
        ]));
  }
}
