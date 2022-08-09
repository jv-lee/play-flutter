import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/me/viewmodel/coin_rank_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分排行榜页面
class CoinRankPage extends StatefulWidget {
  const CoinRankPage({super.key});

  @override
  State<StatefulWidget> createState() => _CoinRankPageState();
}

class _CoinRankPageState extends BasePageState<CoinRankPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<CoinRankViewModel>(
        create: (context) => CoinRankViewModel(context),
        viewBuild: (context, viewModel) => Scaffold(
              appBar: AppBar(
                title: const Text(ThemeStrings.coinRankTitle),
              ),
              body: const Center(child: Text("Coin Rank Page.")),
            ));
  }
}
