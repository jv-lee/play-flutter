import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/account/viewmodel/login_viewmodel.dart';

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
    return Text(ThemeStrings.accountLoginTitle,
        style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorLight));
  }

  Widget buildInputContent(LoginViewModel viewModel) {
    return Card(
        margin: const EdgeInsets.all(ThemeDimens.offsetLarge),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeDimens.offsetLarge)),
        color: Theme.of(context).cardColor,
        child: Padding(
            padding: const EdgeInsets.all(ThemeDimens.offsetMedium),
            child: Column(children: [
              TextField(
                  onChanged: (text) => viewModel.changeUserName(text),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      icon: SvgPicture.asset(ThemeImages.accountUsernameSvg,
                          width: 24, height: 24),
                      hintText: ThemeStrings.accountUsernameText)),
              Divider(
                  height: 1,
                  thickness: 1,
                  indent: ThemeDimens.offsetMedium,
                  endIndent: ThemeDimens.offsetMedium,
                  color: Theme.of(context).scaffoldBackgroundColor),
              TextField(
                  onChanged: (text) => viewModel.changePassword(text),
                  onSubmitted: (text) => viewModel.requestLogin(),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: SvgPicture.asset(ThemeImages.accountPasswordSvg,
                          width: 24, height: 24),
                      hintText: ThemeStrings.accountPasswordText))
            ])));
  }

  Widget buildFooter(LoginViewModel viewModel) {
    return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: ThemeDimens.offsetLarge * 2),
        width: double.infinity,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Material(
              child: InkWell(
                  onTap: () => viewModel.navigationRegister(),
                  child: Text(ThemeStrings.accountGoToRegisterText,
                      style: TextStyle(color: Theme.of(context).focusColor)))),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ThemeDimens.offsetRadiusMedium))),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => viewModel.viewStates.stateColor)),
              onPressed: () => viewModel.requestLogin(),
              child: const Text(ThemeStrings.accountLoginButton,
                  style: TextStyle(color: Colors.white)))
        ]));
  }

}
