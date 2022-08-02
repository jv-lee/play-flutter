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
  Timer? _timer;
  String timeText = "";

  @override
  void initState() {
    super.initState();
    if (widget.isStart) {
      var readTime = 5;
      timeText = "${ThemeStrings.splash_time_text}$readTime";
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        readTime--;
        timeText = "${ThemeStrings.splash_time_text}$readTime";
        if (readTime == 0 && _timer?.isActive == true) {
          _timer?.cancel();
          widget.onEnd();
        } else {
          setState(() {});
        }
      });
    }
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
                  BorderRadius.circular(ThemeDimens.offset_radius_medium)),
          child: Center(
            child: Text(
              timeText,
              style: const TextStyle(
                  fontSize: ThemeDimens.font_size_medium, color: Colors.white),
            ),
          ),
        ));
  }
}
