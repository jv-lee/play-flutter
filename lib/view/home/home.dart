import 'package:flutter/material.dart';
import 'package:playflutter/route/route_names.dart';
import 'package:playflutter/view/home/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

/// @author jv.lee
/// @date 2022/4/26
/// @description
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: InkWell(
      child: Text(
        "this is Home",
        style: TextStyle(color: Theme.of(context).primaryColorLight),
      ),
      onTap: () => {
        // Navigator.pushNamed(context, RouteNames.SETTINGS)
        context.read<HomeViewModel>().requestHomeData()
      },
    )));
  }
}
