import 'package:flutter/material.dart';
import 'package:playflutter/base/vm_state.dart';
import 'package:playflutter/view/me/viewmodel/coin_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 积分页面
class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<StatefulWidget> createState() => _CoinPageState();
}

class _CoinPageState extends VMState<CoinPage, CoinViewModel> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Coin Page."));
  }
}
