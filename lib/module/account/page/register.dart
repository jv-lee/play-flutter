import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/module/account/theme/theme_account.dart';
import 'package:playflutter/module/account/viewmodel/register_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 注册页面
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends BasePageState<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<RegisterViewModel>(
        create: (context) => RegisterViewModel(context),
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
    return Text(ThemeAccount.strings.registerTitle,
        style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorLight));
  }

  Widget buildInputContent(RegisterViewModel viewModel) {
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
                  onChanged: (text) => viewModel.changeUserName(text),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      icon: SvgPicture.asset(ThemeAccount.images.usernameSvg,
                          width: 24, height: 24),
                      hintText: ThemeAccount.strings.usernameText)),
              buildSpacer(),
              TextField(
                  onChanged: (text) => viewModel.changePassword(text),
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: SvgPicture.asset(ThemeAccount.images.passwordSvg,
                          width: 24, height: 24),
                      hintText: ThemeAccount.strings.passwordText)),
              buildSpacer(),
              TextField(
                  onChanged: (text) => viewModel.changeRePassword(text),
                  onSubmitted: (text) => viewModel.requestRegister(),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: SvgPicture.asset(ThemeAccount.images.passwordSvg,
                          width: 24, height: 24),
                      hintText: ThemeAccount.strings.rePasswordText))
            ])));
  }

  Widget buildFooter(RegisterViewModel viewModel) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: ThemeCommon.dimens.offsetLarge * 2),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Material(
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(ThemeAccount.strings.gotoLoginText,
                      style: TextStyle(color: Theme.of(context).focusColor)))),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ThemeCommon.dimens.offsetRadiusMedium))),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => viewModel.viewStates.stateColor)),
              onPressed: () => viewModel.requestRegister(),
              child: Text(ThemeAccount.strings.registerButton,
                  style: const TextStyle(color: Colors.white)))
        ]));
  }

  Widget buildSpacer() {
    return Divider(
        height: 1,
        thickness: 1,
        indent: ThemeCommon.dimens.offsetMedium,
        endIndent: ThemeCommon.dimens.offsetMedium,
        color: Theme.of(context).scaffoldBackgroundColor);
  }
}
