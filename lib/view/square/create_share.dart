import 'package:flutter/material.dart';
import 'package:playflutter/base/viewmodel_state.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(ThemeStrings.square_create_share_text),
      ),
      body: Center(
        child: Text("this is createShare",
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
      ),
    );
  }
}
