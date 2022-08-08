import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              body: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTitle(),
                    buildInputContent(viewModel),
                    buildFooter(viewModel)
                  ],
                ),
              ),
            )));
  }

  Widget buildTitle() {
    return Text(
      ThemeStrings.account_login_title,
      style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColorLight),
    );
  }

  Widget buildInputContent(LoginViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(ThemeDimens.offset_large),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeDimens.offset_large)),
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(ThemeDimens.offset_medium),
            child: Column(
              children: [
                TextField(
                    onChanged: (text) => viewModel.changeUserName(text),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        icon: SvgPicture.asset(ThemeImages.account_username_svg,
                            width: 24, height: 24),
                        hintText: ThemeStrings.account_username_text)),
                buildSpacer(),
                TextField(
                    onChanged: (text) => viewModel.changePassword(text),
                    onSubmitted: (text) => viewModel.requestLogin(),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: SvgPicture.asset(ThemeImages.account_password_svg,
                            width: 24, height: 24),
                        hintText: ThemeStrings.account_password_text))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFooter(LoginViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: ThemeDimens.offset_large * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
                child: InkWell(
                    onTap: () => viewModel.navigationRegister(),
                    child: Text(ThemeStrings.account_go_to_register_text,
                        style:
                            TextStyle(color: Theme.of(context).focusColor)))),
            ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ThemeDimens.offset_radius_medium))),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => viewModel.viewStates.stateColor)),
                onPressed: () => viewModel.requestLogin(),
                child: const Text(
                  ThemeStrings.account_login_button,
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildSpacer() {
    return Padding(
      padding: const EdgeInsets.only(
          left: ThemeDimens.offset_medium, right: ThemeDimens.offset_medium),
      child: Container(
          width: double.infinity,
          height: 1,
          color: Theme.of(context).scaffoldBackgroundColor),
    );
  }
}
