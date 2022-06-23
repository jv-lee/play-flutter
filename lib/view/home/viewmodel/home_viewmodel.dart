import 'package:flutter/foundation.dart';
import 'package:playflutter/entity/banner.dart';
import 'package:playflutter/entity/content.dart';
import 'package:playflutter/tools/log_tools.dart';
import 'package:playflutter/view/home/model/home_model.dart';

class HomeViewModel extends ChangeNotifier {
  final _model = HomeModel();

  void requestHomeData() async {
    LogTools.log("requestHomeData");

    BannerData banner = await _model.getBannerDataAsync();
    ContentData content = await _model.getContentDataAsync(1);

    LogTools.log(banner.toJson());
    LogTools.log(content.toJson());
  }
}
