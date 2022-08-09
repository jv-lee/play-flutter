import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
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

class _SettingsState extends BasePageState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<SettingsViewModel>(
        create: (context) => SettingsViewModel(context),
        viewBuild: (context, viewModel) => Scaffold(
              appBar: AppBar(
                title: const Text(ThemeStrings.meItemSettings),
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
      padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
      child: ProfileItem(
        leftText: ThemeStrings.settingsDarkModeSystem,
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
        leftText: ThemeStrings.settingsDarkModeNight,
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
      padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
      child: ProfileItem(
        leftText: ThemeStrings.settingsClearText,
        rightText: viewModel.viewStates.cacheSize,
        rightSvgPath: ThemeImages.commonArrowSvg,
        onItemClick: () => viewModel.clearCache(),
      ),
    );
  }

  Widget buildLogoutItem(SettingsViewModel viewModel) {
    return Visibility(
        visible: viewModel.accountService.viewStates.isLogin,
        child: Padding(
          padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
          child: ProfileItem(
            leftText: ThemeStrings.settingsLogout,
            leftSvgPath: ThemeImages.meLogoutSvg,
            rightSvgPath: ThemeImages.commonArrowSvg,
            onItemClick: () => viewModel.logout(),
          ),
        ));
  }
}
