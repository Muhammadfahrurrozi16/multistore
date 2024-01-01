import 'dart:convert';

class BannerResponModel {
    final List<Banners> data;

    BannerResponModel({
        required this.data,
    });

    factory BannerResponModel.fromJson(String str) => BannerResponModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BannerResponModel.fromMap(Map<String, dynamic> json) => BannerResponModel(
        data: List<Banners>.from(json["data"].map((x) => Banners.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Banners {
    final int id;
    final String name;
    final String bannerUrl;
    final int isEnable;
    final DateTime createdAt;
    final DateTime updatedAt;

    Banners({
        required this.id,
        required this.name,
        required this.bannerUrl,
        required this.isEnable,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Banners.fromJson(String str) => Banners.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Banners.fromMap(Map<String, dynamic> json) => Banners(
        id: json["id"],
        name: json["name"],
        bannerUrl: json["banner_url"],
        isEnable: json["is_enable"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "banner_url": bannerUrl,
        "is_enable": isEnable,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
