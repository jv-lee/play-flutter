import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/module/account/theme/theme_images_account.dart';
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
    return Text("account_register_title".localized(),
        style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorLight));
  }

  Widget buildInputContent(RegisterViewModel viewModel) {
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
                      icon: SvgPicture.asset(ThemeImagesAccount.usernameSvg,
                          width: 24, height: 24),
                      hintText: "account_username_text".localized())),
              buildSpacer(),
              TextField(
                  onChanged: (text) => viewModel.changePassword(text),
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: SvgPicture.asset(ThemeImagesAccount.passwordSvg,
                          width: 24, height: 24),
                      hintText: "account_password_text".localized())),
              buildSpacer(),
              TextField(
                  onChanged: (text) => viewModel.changeRePassword(text),
                  onSubmitted: (text) => viewModel.requestRegister(),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: SvgPicture.asset(ThemeImagesAccount.passwordSvg,
                          width: 24, height: 24),
                      hintText: "account_repassword_text".localized()))
            ])));
  }

  Widget buildFooter(RegisterViewModel viewModel) {
    return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.symmetric(horizontal: ThemeDimens.offsetLarge * 2),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Material(
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text("account_goto_login_text".localized(),
                      style: TextStyle(color: Theme.of(context).focusColor)))),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ThemeDimens.offsetRadiusMedium))),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => viewModel.viewStates.stateColor)),
              onPressed: () => viewModel.requestRegister(),
              child: Text("account_register_button".localized(),
                  style: const TextStyle(color: Colors.white)))
        ]));
  }

  Widget buildSpacer() {
    return Divider(
        height: 1,
        thickness: 1,
        indent: ThemeDimens.offsetMedium,
        endIndent: ThemeDimens.offsetMedium,
        color: Theme.of(context).scaffoldBackgroundColor);
  }
}
