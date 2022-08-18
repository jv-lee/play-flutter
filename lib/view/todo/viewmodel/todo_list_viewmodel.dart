import 'package:playflutter/base/base_viewmodel.dart';
import 'package:playflutter/tools/log_tools.dart';

/// @author jv.lee
/// @date 2022/8/15
/// @description
class TodoListViewModel extends BaseViewModel {
  TodoListViewModel(super.context);

  @override
  void init() {
    LogTools.log("TodoListViewModel", "init()");
  }

  @override
  void onCleared() {
    LogTools.log("TodoListViewModel", "onCleared()");
  }
}
