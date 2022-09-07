/// @author jv.lee
/// @date 2022/6/24
/// @description 分页数据操作类
abstract class PagingData<T> {
  int getPageNumber();

  int getPageTotalNumber();

  List<T> getDataSource();
}

enum LoadStatus { refresh, loadMore, reload }
