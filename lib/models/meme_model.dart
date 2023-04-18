// To parse this JSON data, do
//
//     final memeModel = memeModelFromJson(jsonString);

import 'dart:convert';

MemeModel memeModelFromJson(String str) => MemeModel.fromJson(json.decode(str));

String memeModelToJson(MemeModel data) => json.encode(data.toJson());

class MemeModel {
  MemeModel({
    this.id,
    this.name,
    this.url,
    this.width,
    this.height,
    this.boxCount,
    this.captions,
  });

  String? id;
  String? name;
  String? url;
  int? width;
  int? height;
  int? boxCount;
  int? captions;

  factory MemeModel.fromJson(Map<String, dynamic> json) => MemeModel(
    id: json["id"],
    name: json["name"],
    url: json["url"],
    width: json["width"],
    height: json["height"],
    boxCount: json["box_count"],
    captions: json["captions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "width": width,
    "height": height,
    "box_count": boxCount,
    "captions": captions,
  };
}
