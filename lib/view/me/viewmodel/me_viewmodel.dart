import 'package:playflutter/base/viewmodel.dart';
import 'package:playflutter/view/me/model/entity/me_item.dart';

/// @author jv.lee
/// @date 2022/7/15
/// @description
class MeViewModel extends ViewModel {

  List<MeItem> meItems = MeItem.getMeItems();

  MeViewModel(super.context);

  @override
  void init() {}

  @override
  void unInit() {}
}
