import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playflutter/base/page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/tools/status_tools.dart';
import 'package:playflutter/view/splash/viewmodel/splash_viewmodel.dart';
import 'package:playflutter/widget/common/time_ready_button.dart';

/// @author jv.lee
/// @date 2022/7/29
/// @description app闪屏启动页
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends PageState<SplashPage> {
  @override
  void initState() {
    // hide navigationBar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);
    super.initState();
  }

  @override
  void dispose() {
    // show statusBar and navigationBar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return createViewModel<SplashViewModel>(
        (context) => SplashViewModel(context),
        (context, viewModel) => Scaffold(
                body: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Image.asset(
                    viewModel.findSplashRes(),
                    fit: BoxFit.cover,
                  ),
                ),
                buildSplashAd(viewModel)
              ],
            )));
  }

  Widget buildSplashAd(SplashViewModel viewModel) {
    return Visibility(
        visible: viewModel.splashAdVisible,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              color: Colors.transparent,
              child: Image.asset(
                ThemeImages.splash_ad_png,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    top: StatusTools.getStatusHeight() +
                        ThemeDimens.offset_small,
                    right: ThemeDimens.offset_large),
                child: TimeReadyButton(
                  isStart: viewModel.splashAdVisible,
                  onEnd: () => Navigator.pop(context),
                ),
              ),
            )
          ],
        ));
  }
}
