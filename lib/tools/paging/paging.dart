import 'package:playflutter/tools/paging/paging_data.dart';
import 'package:playflutter/widget/status/status.dart';
import 'package:playflutter/widget/status/status_controller.dart';

/// @author jv.lee
/// @date 2020/5/14
/// @description 分页加载工具
class Paging<T> {
  List<T> data;
  int initPage;
  int _page = 0;
  Function notify;
  StatusController statusController;

  Paging({
    required this.data,
    required this.initPage,
    required this.notify,
    required this.statusController,
  }) {
    _page = initPage;
  }

  requestData(LoadStatus status,
       Future<PagingData<T>> Function(int)  requestBlock) async {
    if (status == LoadStatus.refresh) {
      _page = initPage;
    } else if (status == LoadStatus.loadMore) {
      ++_page;
    } else {
      // reload直接复用page
    }

    var response =
        await requestBlock(_page).catchError((onError) => submitFailed());

    // 首页数据
    if (_page == initPage) {
      // 首页空数据
      if (response.getDataSource().isEmpty) {
        statusController.pageEmpty();
        notify();
        return;
      }

      // 加载首页数据
      data.clear();
      data.addAll(response.getDataSource());
      statusController.pageComplete();

      // 是否只有一页数据
      if (response.getPageNumber() == response.getPageTotalNumber() ||
          response.getPageTotalNumber() == 1) {
        statusController.itemComplete();
      } else {
        statusController.itemLoading();
      }

      notify();
      return;
    }

    // 加载更多数据
    if (response.getPageNumber() < response.getPageTotalNumber()) {
      data.addAll(response.getDataSource());
      statusController.itemLoading();
      notify();
      return;
    }

    // 加载更多至尾页
    if (response.getPageNumber() == response.getPageTotalNumber()) {
      data.addAll(response.getDataSource());
      statusController.itemComplete();
      notify();
      return;
    }

    notify();
  }

  submitFailed() {
    // 当前列表数据加载成功，分页item不是最后一项，且数据不为空则显示itemError状态
    if (statusController.pageStatus == PageStatus.completed &&
        statusController.itemStatus != ItemStatus.end &&
        data.isNotEmpty) {
      statusController.itemError();
      // 当前列表数据未加载成功，且数据为空
    } else if (statusController.pageStatus != PageStatus.completed && data.isEmpty) {
      statusController.pageError();
    }
    notify();
  }
}

typedef PageLoadFunction<T> = Future<List<T>> Function(int page);
typedef PageResponseFunction<T> = void Function(List<T> data);
