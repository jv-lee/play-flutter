import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/view/me/viewmodel/me_viewmodel.dart';
import 'package:playflutter/widget/common/header/app_header_container.dart';
import 'package:playflutter/widget/common/profile_item.dart';
import 'package:playflutter/widget/common/transparent_scaffold.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 主页我的tab
class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<StatefulWidget> createState() => _MeState();
}

class _MeState extends BasePageState<MePage>
    with AutomaticKeepAliveClientMixin<MePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildViewModel<MeViewModel>(
        create: (context) => MeViewModel(context),
        viewBuild: (context, viewModel) => TransparentScaffold(
                child: Column(children: [
              buildHeader(viewModel),
              buildLineItemList(viewModel)
            ])));
  }

  Widget buildHeader(MeViewModel viewModel) {
    return AppHeaderContainer(
        onTap: () => viewModel.headerClick(),
        backgroundColor: Theme.of(context).cardColor,
        headerBrush: false,
        child: SizedBox(
            width: double.infinity,
            height: ThemeDimens.meHeaderHeight,
            child: Row(children: [
              Padding(
                  padding: const EdgeInsets.only(
                      left: ThemeDimens.meHeaderPictureMargin),
                  child: Container(
                      width: ThemeDimens.meHeaderPictureSize,
                      height: ThemeDimens.meHeaderPictureSize,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ThemeDimens.meHeaderPictureSize / 2),
                          border: Border.all(
                              width: 2, color: Theme.of(context).focusColor)),
                      child: viewModel.viewStates.headerWidget)),
              Padding(
                  padding: const EdgeInsets.only(
                      left: ThemeDimens.meHeaderContentMargin),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.all(ThemeDimens.offsetSmall),
                            child: Text(viewModel.viewStates.userName,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                    fontSize: ThemeDimens.fontSizeLarge))),
                        Visibility(
                            visible: viewModel.viewStates.isLogin,
                            child: Padding(
                                padding: const EdgeInsets.all(
                                    ThemeDimens.offsetSmall),
                                child: Text(viewModel.viewStates.userDesc,
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize: ThemeDimens.fontSizeSmall))))
                      ]))
            ])));
  }

  Widget buildLineItemList(MeViewModel viewModel) {
    var widgets = viewModel.viewStates.meItems
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
}
