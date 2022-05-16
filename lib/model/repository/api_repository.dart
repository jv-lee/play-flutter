import 'package:dio/dio.dart';
import 'package:playflutter/http/http_manager.dart';

/// @author jv.lee
/// @date 2020/5/18
/// @description 网络数据提供
class ApiRepository {
  ApiRepository._internal();

  static final ApiRepository _instance = ApiRepository._internal();

  static ApiRepository getInstance() {
    return _instance;
  }

  final dio = HttpManager.getInstance().dio;

  // Future<BannerEntity> getBannerAsync() async {
  //   var response = await _dio.get("banners");
  //   if (response.statusCode == 200) {
  //     BannerEntity bannerEntity = BannerEntity.fromJson(response.data);
  //     if (bannerEntity.status == 100) {
  //       return bannerEntity;
  //     }
  //   }
  //   throw Exception("response status error");
  // }

  // Future<CategoryEntity> getCategoriesAsync() async {
  //   var response = await _dio.get("categories/Article");
  //   if (response.statusCode == 200) {
  //     var categoryEntity = CategoryEntity.fromJson(response.data);
  //     if (categoryEntity.status == 100) {
  //       return categoryEntity;
  //     }
  //   }
  //   throw Exception("response status error");
  // }

  // Future<ContentEntity> getContentDataAsync(category, type, page, count) async {
  //   var response = await _dio
  //       .get("data/category/$category/type/$type/page/$page/count/$count");
  //   if (response.statusCode == 200) {
  //     var contentEntity = ContentEntity.fromJson(response.data);
  //     if (contentEntity.status == 100) {
  //       return contentEntity;
  //     }
  //   }
  //   return null;
  // }

  // Future<HotEntity> getHotDataAsync(hotType, category, count) async {
  //   var response =
  //       await _dio.get("hot/$hotType/category/$category/count/$count");
  //   if (response.statusCode == 200) {
  //     var hotEntity = HotEntity.fromJson(response.data);
  //     return hotEntity.status == 100 ? hotEntity : null;
  //   }
  //   return null;
  // }

  // Future<ContentEntity> getSearchDataAsync(search, category, type, page, count) async {
  //   var response = await _dio.get(
  //       "search/$search/category/$category/type/$type/page/$page/count/$count");
  //   if (response.statusCode == 200) {
  //     var contentEntity = ContentEntity.fromJson(response.data);
  //     return contentEntity.status == 100 ? contentEntity : null;
  //   }
  //   return null;
  // }
}
