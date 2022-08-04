import 'package:flutter/material.dart';
import 'package:night/night.dart';
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
              body: Center(
                child: GestureDetector(
                  child: Text(
                    "this is Settings",
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                  ),
                  onTap: () => {
                    Night.isDarkTheme().then(
                        (value) => DarkModeProvider.changeDark(context, !value))
                  },
                ),
              ),
            ));
  }
}
