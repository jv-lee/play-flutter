import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:playflutter/core/base/base_page_state.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';
import 'package:playflutter/core/theme/theme_images.dart';
import 'package:playflutter/core/tools/localizations.dart';
import 'package:playflutter/module/todo/model/entity/todo_type.dart';
import 'package:playflutter/module/todo/viewmodel/create_todo_viewmodel.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description 创建/编辑 笔记页面
class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends BasePageState<CreateTodoPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<CreateTodoViewModel>(
        create: (context) => CreateTodoViewModel(context),
        viewBuild: (context, viewModel) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            // 全页面点击隐藏软键盘
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                appBar: AppBar(title: Text(viewModel.viewStates.appbarTitle)),
                body: buildContent(viewModel))));
  }

  Widget buildContent(CreateTodoViewModel viewModel) {
    return Stack(
        children: [buildInputContent(viewModel), buildFooterButton(viewModel)]);
  }

  Widget buildInputContent(CreateTodoViewModel viewModel) {
    return Column(children: [
      buildInputContainer(Row(
        children: [
          Text("todo_create_title_label".localized(),
              style: TextStyle(color: Theme.of(context).primaryColorLight)),
          Expanded(
              child: TextField(
                  controller: viewModel.viewStates.titleController,
                  onChanged: (text) => viewModel.changeTitle(text),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "todo_create_title_hint".localized())))
        ],
      )),
      buildInputContainer(
          Row(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: ThemeDimens.offsetLarge),
                  child: Text("todo_create_content_label".localized(),
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight))),
              Expanded(
                  child: TextField(
                      controller: viewModel.viewStates.contentController,
                      onChanged: (text) => viewModel.changeContent(text),
                      textInputAction: TextInputAction.next,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "todo_create_content_hint".localized())))
            ],
          ),
          height: 138,
          alignment: Alignment.topLeft),
      buildInputContainer(Row(children: [
        Text("todo_create_level_label".localized(),
            style: TextStyle(color: Theme.of(context).primaryColorLight)),
        SizedBox(
            width: 80,
            child: Row(children: [
              Radio<int>(
                  value: TodoPriority.LOW.index,
                  activeColor: Theme.of(context).focusColor,
                  groupValue: viewModel.viewStates.priority,
                  onChanged: (int? value) => viewModel.changePriority(value!)),
              Text("todo_create_level_low".localized(),
                  style: TextStyle(color: Theme.of(context).primaryColor))
            ])),
        SizedBox(
            width: 80,
            child: Row(children: [
              Radio<int>(
                  value: TodoPriority.HIGH.index,
                  activeColor: Theme.of(context).focusColor,
                  groupValue: viewModel.viewStates.priority,
                  onChanged: (int? value) => viewModel.changePriority(value!)),
              Text("todo_create_level_high".localized(),
                  style: TextStyle(color: Theme.of(context).primaryColor))
            ]))
      ])),
      SizedBox(
          width: double.infinity,
          child: Material(
              child: InkWell(
                  onTap: () => viewModel.changeDate(),
                  child: buildInputContainer(Row(
                    children: [
                      Text("todo_create_date_label".localized(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight)),
                      Expanded(
                          child: Text(viewModel.viewStates.date,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight))),
                      SvgPicture.asset(ThemeImages.commonArrowSvg,
                          width: 24,
                          height: 24,
                          color: Theme.of(context).primaryColorLight)
                    ],
                  )))))
    ]);
  }

  Widget buildInputContainer(Widget child,
      {double height = 56, AlignmentGeometry? alignment}) {
    return Container(
        width: double.infinity,
        height: height,
        alignment: alignment,
        padding:
            const EdgeInsets.symmetric(horizontal: ThemeDimens.offsetLarge),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(width: 1, color: Theme.of(context).hoverColor))),
        child: child);
  }

  Widget buildFooterButton(CreateTodoViewModel viewModel) {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.all(ThemeDimens.offsetLarge),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(ThemeDimens.offsetRadiusLarge)),
          minWidth: double.infinity,
          color: Theme.of(context).focusColor,
          splashColor: Theme.of(context).focusColor,
          onPressed: () => viewModel.onSubmit(),
          child: Text("todo_create_save".localized(),
              style: const TextStyle(color: Colors.white)),
        ));
  }
}
