import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FitnessNewsModel {
  final String title;
  final String url;
  final String source;
  FitnessNewsModel({
    required this.title,
    required this.url,
    required this.source,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'url': url,
      'source': source,
    };
  }

  factory FitnessNewsModel.fromJson(Map<String, dynamic> json) {
    return FitnessNewsModel(
      title: json['title'] as String,
      url: json['url'] as String,
      source: json['source'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'FitnessModel(title: $title, url: $url, source: $source, )';
  }
}
