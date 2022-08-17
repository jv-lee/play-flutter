import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
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

class _SplashState extends BasePageState<SplashPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<SplashViewModel>(
        create: (context) => SplashViewModel(context, tickerProvider: this),
        viewBuild: (context, viewModel) => Scaffold(
                body: Stack(children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Image.asset(
                    viewModel.viewStates.getThemeModeBg(),
                    fit: BoxFit.fill,
                  )),
              buildSplashAd(viewModel)
            ])));
  }

  Widget buildSplashAd(SplashViewModel viewModel) {
    return Visibility(
        visible: viewModel.animationController.isAnimating,
        child: FadeTransition(
            opacity: viewModel.animation,
            child: Stack(children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  color: Colors.transparent,
                  child: Image.asset(
                    ThemeImages.splashAdPng,
                    fit: BoxFit.cover,
                  )),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: StatusTools.getStatusHeight() +
                              ThemeDimens.offsetSmall,
                          right: ThemeDimens.offsetLarge),
                      child:
                          TimeReadyButton(onEnd: () => Navigator.pop(context))))
            ])));
  }
}
