import 'package:flutter/material.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/core/theme/theme_strings.dart';
import 'package:playflutter/module/square/viewmodel/create_share_viewmodel.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 创建分享内容页
class CreateSharePage extends StatefulWidget {
  const CreateSharePage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateShareState();
}

class _CreateShareState extends BasePageState<CreateSharePage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<CreateShareViewModel>(
        create: (context) => CreateShareViewModel(context),
        viewBuild: (context, viewModel) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                    title: const Text(ThemeStrings.squareCreateShareText)),
                body: buildCrateShareContent(viewModel))));
  }

  Widget buildCrateShareContent(CreateShareViewModel viewModel) {
    return Padding(
        padding: const EdgeInsets.only(
            left: ThemeDimens.offsetLarge, right: ThemeDimens.offsetLarge),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
              child: Text(ThemeStrings.squareShareTitleText,
                  style:
                      TextStyle(color: Theme.of(context).primaryColorLight))),
          TextField(
              onChanged: (text) => {viewModel.changeShareTitle(text)},
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  hintText: ThemeStrings.squareShareTitleHint)),
          Padding(
              padding: const EdgeInsets.only(top: ThemeDimens.offsetMedium),
              child: Text(ThemeStrings.squareShareLinkText,
                  style:
                      TextStyle(color: Theme.of(context).primaryColorLight))),
          TextField(
              onChanged: (text) => {viewModel.changeShareLink(text)},
              onSubmitted: (text) => {viewModel.submitShare()},
              textInputAction: TextInputAction.send,
              decoration: const InputDecoration(
                  hintText: ThemeStrings.squareShareLinkHint)),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(ThemeStrings.squareCreateShareDescription,
                      style: TextStyle(
                          letterSpacing: ThemeDimens.offsetSmall,
                          fontSize: ThemeDimens.fontSizeSmall,
                          color: Theme.of(context).primaryColor))))
        ]));
  }
}
