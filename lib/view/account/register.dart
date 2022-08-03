import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playflutter/base/page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/account/viewmodel/register_viewmodel.dart';

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
    return createViewModel<RegisterViewModel>(
        (context) => RegisterViewModel(context),
        (context, viewModel) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            // 全页面点击隐藏软键盘
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              body: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [buildTitle(), buildInputContent(), buildFooter()],
                ),
              ),
            )));
  }

  Widget buildTitle() {
    return Text(
      ThemeStrings.account_register_title,
      style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColorLight),
    );
  }

  Widget buildInputContent() {
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
                    onSubmitted: (text) => {},
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        icon: SvgPicture.asset(ThemeImages.account_username_svg,
                            width: 24, height: 24),
                        hintText: ThemeStrings.account_username_text)),
                buildSpacer(),
                TextField(
                    onSubmitted: (text) => {},
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        icon: SvgPicture.asset(ThemeImages.account_password_svg,
                            width: 24, height: 24),
                        hintText: ThemeStrings.account_password_text)),
                buildSpacer(),
                TextField(
                    onSubmitted: (text) => {},
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        icon: SvgPicture.asset(ThemeImages.account_password_svg,
                            width: 24, height: 24),
                        hintText: ThemeStrings.account_re_password_text)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFooter() {
    Color buttonColor;
    if (true) {
      buttonColor = Theme.of(context).focusColor;
    } else {
      buttonColor = Colors.grey;
    }
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
                    onTap: () => Navigator.pop(context),
                    child: Text(ThemeStrings.account_go_to_login_text,
                        style:
                            TextStyle(color: Theme.of(context).focusColor)))),
            ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ThemeDimens.offset_radius_medium))),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => buttonColor)),
                onPressed: () {},
                child: const Text(
                  ThemeStrings.account_register_button,
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
