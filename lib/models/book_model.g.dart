// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book()
    ..key = json['key'] as String
    ..type = json['type'] as String
    ..title = json['title'] as String
    ..isbn = (json['isbn'] as List)?.map((e) => e as String)?.toList()
    ..author = (json['author_name'] as List)?.map((e) => e as String)?.toList()
    ..publisher = (json['publisher'] as List)?.map((e) => e as String)?.toList()
    ..language = (json['language'] as List)?.map((e) => e as String)?.toList()
    ..firstPublishYear = json['first_publish_year'] as int;
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'key': instance.key,
      'type': instance.type,
      'title': instance.title,
      'isbn': instance.isbn,
      'author_name': instance.author,
      'publisher': instance.publisher,
      'language': instance.language,
      'first_publish_year': instance.firstPublishYear,
    };
