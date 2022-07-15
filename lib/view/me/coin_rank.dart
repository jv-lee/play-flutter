import 'package:flutter/material.dart';
import 'package:playflutter/base/vm_state.dart';
import 'package:playflutter/view/me/viewmodel/coin_rank_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分排行榜页面
class CoinRankPage extends StatefulWidget {
  const CoinRankPage({super.key});

  @override
  State<StatefulWidget> createState() => _CoinRankPageState();
}

class _CoinRankPageState extends VMState<CoinRankPage, CoinRankViewModel> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Coin Rank Page."));
  }
}
