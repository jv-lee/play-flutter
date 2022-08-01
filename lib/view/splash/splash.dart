import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/view/splash/viewmodel/splash_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/29
/// @description
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelCreator.create<SplashViewModel>(
        (context) => SplashViewModel(context),
        (context, viewModel) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Image.asset(
                viewModel.findSplashRes(),
                fit: BoxFit.cover,
              ),
            ));
  }
}
