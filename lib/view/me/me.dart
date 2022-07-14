import 'package:flutter/material.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_images.dart';
import 'package:playflutter/widget/common/app_header_container.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页我的tab
class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<StatefulWidget> createState() => _MeState();
}

class _MeState extends State<MePage>
    with AutomaticKeepAliveClientMixin<MePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [buildHeader(), buildLineItemList()],
    );
  }

  Widget buildHeader() {
    return AppHeaderContainer(
        onTap: () => {},
        backgroundColor: Theme.of(context).cardColor,
        headerBrush: false,
        child: SizedBox(
          width: double.infinity,
          height: ThemeDimens.me_header_height,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: ThemeDimens.me_header_picture_margin),
                child: Container(
                    width: ThemeDimens.me_header_picture_size,
                    height: ThemeDimens.me_header_picture_size,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            ThemeDimens.me_header_picture_size / 2),
                        border: Border.all(
                            width: 2, color: Theme.of(context).focusColor)),
                    child: Image.asset(ThemeImages.launcher_round_png)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: ThemeDimens.me_header_content_margin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(ThemeDimens.offset_small),
                      child: Text(
                        "username",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: ThemeDimens.font_size_large),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(ThemeDimens.offset_small),
                      child: Text("rank",
                          style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize: ThemeDimens.font_size_small)),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget buildLineItemList() {
    return Column(
      children: [],
    );
  }

  Widget buildProfileItem() {
    return Container();
  }
}
