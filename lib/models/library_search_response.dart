import 'package:json_annotation/json_annotation.dart';

import 'book_model.dart';

part 'library_search_response.g.dart';

@JsonSerializable()
class LibrarySearchResponse {
  int numFound;
  List<Book> docs;

  LibrarySearchResponse();

  factory LibrarySearchResponse.fromJson(Map<String, dynamic> json) =>
      _$LibrarySearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LibrarySearchResponseToJson(this);
}
