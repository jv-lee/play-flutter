import 'package:flutter/material.dart';
import 'package:playflutter/base/page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/view/me/viewmodel/me_viewmodel.dart';
import 'package:playflutter/widget/common/header/app_header_container.dart';
import 'package:playflutter/widget/common/profile_item.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页我的tab
class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<StatefulWidget> createState() => _MeState();
}

class _MeState extends PageState<MePage>
    with AutomaticKeepAliveClientMixin<MePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return createViewModel<MeViewModel>(
        (context) => MeViewModel(context),
        (context, viewModel) => Column(
              children: [buildHeader(viewModel), buildLineItemList(viewModel)],
            ));
  }

  Widget buildHeader(MeViewModel viewModel) {
    return AppHeaderContainer(
        onTap: () => viewModel.headerClick(),
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
                    child: viewModel.viewStates.headerWidget),
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
                        viewModel.viewStates.userName,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: ThemeDimens.font_size_large),
                      ),
                    ),
                    Visibility(
                        visible: viewModel.viewStates.isLogin,
                        child: Padding(
                          padding:
                              const EdgeInsets.all(ThemeDimens.offset_small),
                          child: Text(viewModel.viewStates.userDesc,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                  fontSize: ThemeDimens.font_size_small)),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget buildLineItemList(MeViewModel viewModel) {
    var widgets = viewModel.meItems
        .map((e) => Padding(
              padding: const EdgeInsets.only(top: 1),
              child: ProfileItem(
                leftSvgPath: e.iconSvgPath,
                leftText: e.name,
                rightSvgPath: e.arrowSvgPath,
                onItemClick: () => viewModel.itemClick(e.route),
              ),
            ))
        .toList();

    return Column(children: widgets);
  }

  Widget buildProfileItem() {
    return Container();
  }
}
