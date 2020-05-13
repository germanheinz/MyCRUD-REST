
import 'dart:convert';

ProducModel producModelFromJson(String str) => ProducModel.fromJson(json.decode(str));

String producModelToJson(ProducModel data) => json.encode(data.toJson());

class ProducModel {
    String id;
    String title;
    double value;
    bool stock;
    String photoUrl;

    ProducModel({
        this.id,
        this.title  = '',
        this.value  = 0.0,
        this.stock  = true,
        this.photoUrl,
    });

    factory ProducModel.fromJson(Map<String, dynamic> json) => ProducModel(
        id      : json["id"],
        title   : json["title"],
        value   : json["value"],
        stock   : json["stock"],
        photoUrl: json["photoUrl"],
    );

    Map<String, dynamic> toJson() => {
        // "id"      : id,
        "title"   : title,
        "value"   : value,
        "stock"   : stock,
        "photoUrl": photoUrl,
    };
}
