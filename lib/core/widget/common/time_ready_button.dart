import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/core/tools/localizations.dart';

/// @author jv.lee
/// @date 2022/8/1
/// @description 闪屏页倒计时button按钮
class TimeReadyButton extends StatefulWidget {
  final Function onEnd;

  const TimeReadyButton({Key? key, required this.onEnd}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimeReadyButtonState();
}

class _TimeReadyButtonState extends State<TimeReadyButton> {
  StreamSubscription? stream;
  final timeLimit = 5;
  int number = 5;

  @override
  void initState() {
    super.initState();
    // 5-1倒计时
    stream = Stream.periodic(const Duration(seconds: 1), (data) => 4 - data)
        .take(timeLimit)
        .listen((number) => updateTiming(number));
  }

  @override
  void dispose() {
    stream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          stream?.cancel();
          widget.onEnd();
        },
        child: Container(
            width: 68,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius:
                    BorderRadius.circular(ThemeDimens.offsetRadiusMedium)),
            child: Text("${"splash_time_text".localized()}$number",
                style: const TextStyle(
                    fontSize: ThemeDimens.fontSizeMedium,
                    color: Colors.white))));
  }

  void updateTiming(int number) {
    if (mounted) {
      if (number == 0) widget.onEnd();
      setState(() => this.number = number);
    }
  }
}
