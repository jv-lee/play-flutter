import 'package:playflutter/model/entity/base/base_data.dart';

/// @author jv.lee
/// @date 2022/8/3
/// @description
class AccountData extends BaseData {
  AccountData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final AccountInfo data;
  late final int errorCode;
  late final String errorMsg;

  AccountData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = AccountInfo.fromJson(json['data']);
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['errorCode'] = errorCode;
    _data['errorMsg'] = errorMsg;
    return _data;
  }

  @override
  int responseCode() => errorCode;

  @override
  String responseMessage() => errorMsg;
}

class UserData {
  UserData({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  late final UserInfo data;
  late final int errorCode;
  late final String errorMsg;

  UserData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = UserInfo.fromJson(json['data']);
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['errorCode'] = errorCode;
    _data['errorMsg'] = errorMsg;
    return _data;
  }
}

class AccountInfo {
  AccountInfo({
    required this.coinInfo,
    required this.collectArticleInfo,
    required this.userInfo,
  });

  late final CoinInfo coinInfo;
  late final CollectArticleInfo collectArticleInfo;
  late final UserInfo userInfo;

  AccountInfo.fromJson(Map<String, dynamic> json) {
    coinInfo = CoinInfo.fromJson(json['coinInfo']);
    collectArticleInfo =
        CollectArticleInfo.fromJson(json['collectArticleInfo']);
    userInfo = UserInfo.fromJson(json['userInfo']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coinInfo'] = coinInfo.toJson();
    _data['collectArticleInfo'] = collectArticleInfo.toJson();
    _data['userInfo'] = userInfo.toJson();
    return _data;
  }
}

class CoinInfo {
  CoinInfo({
    required this.coinCount,
    required this.level,
    required this.nickname,
    required this.rank,
    required this.userId,
    required this.username,
  });

  late final int coinCount;
  late final int level;
  late final String nickname;
  late final String rank;
  late final int userId;
  late final String username;

  CoinInfo.fromJson(Map<String, dynamic> json) {
    coinCount = json['coinCount'];
    level = json['level'];
    nickname = json['nickname'];
    rank = json['rank'];
    userId = json['userId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coinCount'] = coinCount;
    _data['level'] = level;
    _data['nickname'] = nickname;
    _data['rank'] = rank;
    _data['userId'] = userId;
    _data['username'] = username;
    return _data;
  }
}

class CollectArticleInfo {
  CollectArticleInfo({
    required this.count,
  });

  late final int count;

  CollectArticleInfo.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    return _data;
  }
}

class UserInfo {
  UserInfo({
    required this.admin,
    required this.chapterTops,
    required this.coinCount,
    required this.collectIds,
    required this.email,
    required this.icon,
    required this.id,
    required this.nickname,
    required this.password,
    required this.publicName,
    required this.token,
    required this.type,
    required this.username,
  });

  late final bool admin;
  late final List<dynamic> chapterTops;
  late final int coinCount;
  late final List<int> collectIds;
  late final String email;
  late final String icon;
  late final int id;
  late final String nickname;
  late final String password;
  late final String publicName;
  late final String token;
  late final int type;
  late final String username;

  UserInfo.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    chapterTops = List.castFrom<dynamic, dynamic>(json['chapterTops']);
    coinCount = json['coinCount'];
    collectIds = List.castFrom<dynamic, int>(json['collectIds']);
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    publicName = json['publicName'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['admin'] = admin;
    _data['chapterTops'] = chapterTops;
    _data['coinCount'] = coinCount;
    _data['collectIds'] = collectIds;
    _data['email'] = email;
    _data['icon'] = icon;
    _data['id'] = id;
    _data['nickname'] = nickname;
    _data['password'] = password;
    _data['publicName'] = publicName;
    _data['token'] = token;
    _data['type'] = type;
    _data['username'] = username;
    return _data;
  }
}
