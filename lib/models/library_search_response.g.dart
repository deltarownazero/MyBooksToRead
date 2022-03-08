// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibrarySearchResponse _$LibrarySearchResponseFromJson(
    Map<String, dynamic> json) {
  return LibrarySearchResponse()
    ..numFound = json['numFound'] as int
    ..docs = (json['docs'] as List)
        ?.map(
            (e) => e == null ? null : Book.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$LibrarySearchResponseToJson(
        LibrarySearchResponse instance) =>
    <String, dynamic>{
      'numFound': instance.numFound,
      'docs': instance.docs,
    };
