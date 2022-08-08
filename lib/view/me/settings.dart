import 'package:flutter/material.dart';
import 'package:playflutter/base/page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/provider/dark_mode_provider.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/me/viewmodel/settings_viewmodel.dart';
import 'package:playflutter/widget/common/profile_item.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 设置页面
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends PageState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<SettingsViewModel>(
        create: (context) => SettingsViewModel(context),
        viewBuild: (context, viewModel) => Scaffold(
              appBar: AppBar(
                title: const Text(ThemeStrings.me_item_settings),
              ),
              body: Column(
                children: [
                  buildDarkModeSystemItem(),
                  buildDarkModeNightItem(),
                  buildClearCacheItem(viewModel),
                  buildLogoutItem(viewModel)
                ],
              ),
            ));
  }

  Widget buildDarkModeSystemItem() {
    return Padding(
      padding: const EdgeInsets.only(top: ThemeDimens.offset_medium),
      child: ProfileItem(
        leftText: ThemeStrings.settings_dark_mode_system,
        switchVisible: true,
        switchChecked: DarkModeProvider.isSystemTheme(context),
        onCheckedChange: (enable) =>
            DarkModeProvider.changeSystem(context, enable),
      ),
    );
  }

  Widget buildDarkModeNightItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: ProfileItem(
        leftText: ThemeStrings.settings_dark_mode_night,
        switchVisible: true,
        switchChecked: DarkModeProvider.isDarkTheme(context),
        switchEnable: !DarkModeProvider.isSystemTheme(context),
        onCheckedChange: (enable) =>
            DarkModeProvider.changeDark(context, enable),
      ),
    );
  }

  Widget buildClearCacheItem(SettingsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: ThemeDimens.offset_medium),
      child: ProfileItem(
        leftText: ThemeStrings.settings_clear_text,
        rightText: viewModel.viewStates.cacheSize,
        rightSvgPath: ThemeImages.common_arrow_svg,
        onItemClick: () => viewModel.clearCache(),
      ),
    );
  }

  Widget buildLogoutItem(SettingsViewModel viewModel) {
    return Visibility(
        visible: viewModel.accountService.viewStates.isLogin,
        child: Padding(
          padding: const EdgeInsets.only(top: ThemeDimens.offset_medium),
          child: ProfileItem(
            leftText: ThemeStrings.settings_logout,
            leftSvgPath: ThemeImages.me_logout_svg,
            rightSvgPath: ThemeImages.common_arrow_svg,
            onItemClick: () => viewModel.logout(),
          ),
        ));
  }
}
