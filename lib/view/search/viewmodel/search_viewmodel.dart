import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/view/search/model/entity/search_hot.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description 搜索页面viewModel
class SearchViewModel extends ViewModel {
  List<SearchHot> searchHots = SearchHot.getSearchHots();

  @override
  void init() {}

  @override
  void unbindView() {}
}
