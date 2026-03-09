import 'dart:convert';

JokeModel jokeModelFromJson(String str) => JokeModel.fromJson(json.decode(str));

class JokeModel {
  final String iconUrl;
  final String id;
  final String url;
  final String value;

  JokeModel({
    required this.iconUrl,
    required this.id,
    required this.url,
    required this.value,
  });

  factory JokeModel.fromJson(Map<String, dynamic> json) => JokeModel(
        iconUrl: json["icon_url"],
        id: json["id"],
        url: json["url"],
        value: json["value"],
      );
}