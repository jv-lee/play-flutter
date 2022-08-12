import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';

/// @author jv.lee
/// @date 2022/8/1
/// @description 闪屏页倒计时button按钮
class TimeReadyButton extends StatefulWidget {
  final bool isStart;
  final Function onEnd;

  const TimeReadyButton({Key? key, required this.isStart, required this.onEnd})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimeReadyButtonState();
}

class _TimeReadyButtonState extends State<TimeReadyButton> {
  static Timer? _timer;
  String timeText = "";

  void _clearTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    _clearTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
      _clearTimer();
      var readTime = 5;
      timeText = "${ThemeStrings.splashTimeText}$readTime";
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        readTime--;
        timeText = "${ThemeStrings.splashTimeText}$readTime";
        if (readTime == 0 && _timer?.isActive == true) {
          _timer?.cancel();
          widget.onEnd();
        } else {
          setState(() {});
        }
      });

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _timer?.cancel();
          widget.onEnd();
        },
        child: Container(
          width: 68,
          height: 32,
          decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius:
                  BorderRadius.circular(ThemeDimens.offsetRadiusMedium)),
          child: Center(
            child: Text(
              timeText,
              style: const TextStyle(
                  fontSize: ThemeDimens.fontSizeMedium, color: Colors.white),
            ),
          ),
        ));
  }
}
