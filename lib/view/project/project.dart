import 'package:flutter/material.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 项目tab列表
class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProjectState();
}

class _ProjectState extends State<ProjectPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("this is Project",
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
      ),
    );
  }
}
