import 'package:flutter/material.dart';
import 'package:playflutter/base/page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/provider/dark_mode_provider.dart';
import 'package:playflutter/view/me/viewmodel/settings_viewmodel.dart';

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
    return createViewModel<SettingsViewModel>(
        create: (context) => SettingsViewModel(context),
        viewBuild: (context, viewModel) => Scaffold(
              appBar: AppBar(
                title: const Text('Plugin example app'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("跟随系统:"),
                        Switch(
                            value: DarkModeProvider.isSystemTheme(context),
                            onChanged: (enable) =>
                                DarkModeProvider.changeSystem(context, enable))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("深色模式:"),
                        Switch(
                            value: DarkModeProvider.isDarkTheme(context),
                            onChanged: (enable) =>
                                DarkModeProvider.changeDark(context, enable))
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
