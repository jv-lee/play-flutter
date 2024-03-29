import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/module/todo/model/entity/todo_type.dart';
import 'package:playflutter/module/todo/page/todo_list.dart';
import 'package:playflutter/module/todo/theme/theme_todo.dart';
import 'package:playflutter/module/todo/viewmodel/todo_viewmodel.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description Todo模块主页面
class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<StatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends BasePageState<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<TodoViewModel>(
        create: (context) => TodoViewModel(context),
        viewBuild: (context, viewModel) => Scaffold(
            appBar: AppBar(
                title: Text(viewModel.viewStates.typeToTitle()),
                actions: [
                  IconButton(
                      onPressed: () => viewModel.showSelectedTodoTypeDialog(),
                      icon: SvgPicture.asset(
                        ThemeTodo.images.replaceSvg,
                        color: Theme.of(context).primaryColorLight,
                      ))
                ]),
            body: PageView.builder(
                itemCount: viewModel.viewStates.todoTabs.length,
                controller: viewModel.viewStates.pageController,
                physics: const NeverScrollableScrollPhysics(),
                //静止PageView滑动
                itemBuilder: (BuildContext context, int index) => TodoListPage(
                      type: viewModel.viewStates.type,
                      status: TodoStatus.values[index],
                      callbackHandler: viewModel.viewStates.callbackHandler,
                    )),
            bottomNavigationBar: BottomNavigationBar(
                items: viewModel.viewStates.todoTabs
                    .map((e) => BottomNavigationBarItem(
                        label: e.label,
                        icon: SvgPicture.asset(e.normalIcon,
                            width: 24,
                            height: 24,
                            color: Theme.of(context).primaryColor),
                        activeIcon: SvgPicture.asset(e.pressIcon,
                            width: 24,
                            height: 24,
                            color: Theme.of(context).focusColor)))
                    .toList(),
                type: BottomNavigationBarType.fixed,
                currentIndex: viewModel.viewStates.tabIndex,
                iconSize: 28.0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: (index) => viewModel.changeTab(index)),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).focusColor,
              child: SvgPicture.asset(ThemeTodo.images.createSvg,
                  width: 24, height: 24),
              onPressed: () => viewModel.navigationCreateTodo(),
            )));
  }
}
