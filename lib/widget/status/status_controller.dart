import 'package:flutter/material.dart';
import 'package:playflutter/widget/status/status.dart';

/// @author jv.lee
/// @date 2020/5/14
/// @description 分页加载状态控制器
class StatusController extends ChangeNotifier {
  PageStatus pageStatus;
  ItemStatus itemStatus;
  bool _isDispose = false;

  StatusController({
    this.pageStatus = PageStatus.loading,
    this.itemStatus = ItemStatus.empty,
  });

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (_isDispose) return;
    super.notifyListeners();
  }

  StatusController pageLoading() {
    pageStatus = PageStatus.loading;
    notifyListeners();
    return this;
  }

  StatusController pageError() {
    pageStatus = PageStatus.error;
    notifyListeners();
    return this;
  }

  StatusController pageEmpty() {
    pageStatus = PageStatus.empty;
    notifyListeners();
    return this;
  }

  StatusController pageComplete() {
    pageStatus = PageStatus.completed;
    notifyListeners();
    return this;
  }

  StatusController itemLoading() {
    itemStatus = ItemStatus.loading;
    notifyListeners();
    return this;
  }

  StatusController itemComplete() {
    itemStatus = ItemStatus.end;
    notifyListeners();
    return this;
  }

  StatusController itemError() {
    itemStatus = ItemStatus.error;
    notifyListeners();
    return this;
  }

  StatusController itemEmpty() {
    itemStatus = ItemStatus.empty;
    notifyListeners();
    return this;
  }
}
