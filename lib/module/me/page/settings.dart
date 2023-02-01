import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/provider/dark_mode_provider.dart';
import 'package:playflutter/core/theme/theme_common.dart';
import 'package:playflutter/core/widget/common/profile_item.dart';
import 'package:playflutter/module/me/theme/theme_me.dart';
import 'package:playflutter/module/me/viewmodel/settings_viewmodel.dart';

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
              title: Text(ThemeMe.strings.meItemSettings),
            ),
            body: Column(children: [
              buildDarkModeSystemItem(),
              buildDarkModeNightItem(),
              buildClearCacheItem(viewModel),
              buildLogoutItem(viewModel)
            ])));
  }

  Widget buildDarkModeSystemItem() {
    return Padding(
        padding: EdgeInsets.only(top: ThemeCommon.dimens.offsetMedium),
        child: ProfileItem(
            leftText: ThemeMe.strings.settingsDarkModeSystem,
            switchVisible: true,
            switchChecked: DarkModeProvider.isSystemTheme(context),
            onCheckedChange: (enable) =>
                DarkModeProvider.changeSystem(context, enable)));
  }

  Widget buildDarkModeNightItem() {
    return Padding(
        padding: const EdgeInsets.only(top: 1),
        child: ProfileItem(
            leftText: ThemeMe.strings.settingsDarkModeNight,
            switchVisible: true,
            switchChecked: DarkModeProvider.isDarkTheme(context),
            switchEnable: !DarkModeProvider.isSystemTheme(context),
            onCheckedChange: (enable) =>
                DarkModeProvider.changeDark(context, enable)));
  }

  Widget buildClearCacheItem(SettingsViewModel viewModel) {
    return Padding(
        padding: EdgeInsets.only(top: ThemeCommon.dimens.offsetMedium),
        child: ProfileItem(
            leftText: ThemeMe.strings.settingsClearText,
            rightText: viewModel.viewStates.cacheSize,
            rightSvgPath: ThemeCommon.images.arrowSvg,
            onItemClick: () => viewModel.clearCache()));
  }

  Widget buildLogoutItem(SettingsViewModel viewModel) {
    return Visibility(
        visible: viewModel.accountService.viewStates.isLogin,
        child: Padding(
            padding: EdgeInsets.only(top: ThemeCommon.dimens.offsetMedium),
            child: ProfileItem(
                leftText: ThemeMe.strings.settingsLogout,
                leftSvgPath: ThemeMe.images.logoutSvg,
                rightSvgPath: ThemeCommon.images.arrowSvg,
                onItemClick: () => viewModel.logout())));
  }
}
