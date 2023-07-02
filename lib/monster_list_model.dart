// To parse this JSON data, do
//
//     final monsterList = monsterListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MonsterList monsterListFromJson(String str) => MonsterList.fromJson(json.decode(str));

String monsterListToJson(MonsterList data) => json.encode(data.toJson());

class MonsterList {
  int count;
  List<Result> results;

  MonsterList({
    required this.count,
    required this.results,
  });

  factory MonsterList.fromJson(Map<String, dynamic> json) => MonsterList(
    count: json["count"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };

  static empty() {
    return MonsterList(count: 0, results: []);
  }
}

class Result {
  String index;
  String name;
  String url;

  Result({
    required this.index,
    required this.name,
    required this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    index: json["index"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "name": name,
    "url": url,
  };
}
