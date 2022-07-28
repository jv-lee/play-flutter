import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分排行榜页面
class CoinRankPage extends StatefulWidget {
  const CoinRankPage({super.key});

  @override
  State<StatefulWidget> createState() => _CoinRankPageState();
}

class _CoinRankPageState extends State<CoinRankPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Coin Rank Page."));
  }
}
