import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel_state.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/square/viewmodel/create_share_viewmodel.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description 创建分享内容页
class CreateSharePage extends StatefulWidget {
  const CreateSharePage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateShareState();
}

class _CreateShareState
    extends ViewModelState<CreateSharePage, CreateShareViewModel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar:
              AppBar(title: const Text(ThemeStrings.square_create_share_text)),
          body: buildCrateShareContent()),
    );
  }

  Widget buildCrateShareContent() {
    return Padding(
      padding: const EdgeInsets.only(
          left: ThemeDimens.offset_large, right: ThemeDimens.offset_large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: ThemeDimens.offset_medium),
            child: Text(ThemeStrings.square_share_title_text),
          ),
          const TextField(
            decoration:
                InputDecoration(hintText: ThemeStrings.square_share_title_hint),
          ),
          const Padding(
            padding: EdgeInsets.only(top: ThemeDimens.offset_medium),
            child: Text(ThemeStrings.square_share_link_text),
          ),
          const TextField(
            decoration:
                InputDecoration(hintText: ThemeStrings.square_share_link_hint),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              ThemeStrings.square_create_share_description,
              style: TextStyle(
                  letterSpacing: ThemeDimens.offset_small,
                  fontSize: ThemeDimens.font_size_small,
                  color: Theme.of(context).primaryColor),
            ),
          ))
        ],
      ),
    );
  }
}
