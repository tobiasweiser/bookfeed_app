// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
  title: json['title'] as String,
  author: json['author'] as String,
  coverUrl: json['coverUrl'] as String,
  summary: json['summary'] as String,
  affiliateUrl: json['affiliateUrl'] as String,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
  'title': instance.title,
  'author': instance.author,
  'coverUrl': instance.coverUrl,
  'summary': instance.summary,
  'affiliateUrl': instance.affiliateUrl,
  'tags': instance.tags,
  'createdAt': instance.createdAt.toIso8601String(),
};
