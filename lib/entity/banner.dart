class BannerData {
  BannerData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });
  late final List<BannerItem> data;
  late final int errorCode;
  late final String errorMsg;
  
  BannerData.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>BannerItem.fromJson(e)).toList();
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['errorCode'] = errorCode;
    _data['errorMsg'] = errorMsg;
    return _data;
  }
}

class BannerItem {
  BannerItem({
    required this.desc,
    required this.id,
    required this.imagePath,
    required this.isVisible,
    required this.order,
    required this.title,
    required this.type,
    required this.url,
  });
  late final String desc;
  late final int id;
  late final String imagePath;
  late final int isVisible;
  late final int order;
  late final String title;
  late final int type;
  late final String url;

  BannerItem.fromJson(Map<String, dynamic> json){
    desc = json['desc'];
    id = json['id'];
    imagePath = json['imagePath'];
    isVisible = json['isVisible'];
    order = json['order'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['desc'] = desc;
    _data['id'] = id;
    _data['imagePath'] = imagePath;
    _data['isVisible'] = isVisible;
    _data['order'] = order;
    _data['title'] = title;
    _data['type'] = type;
    _data['url'] = url;
    return _data;
  }
}