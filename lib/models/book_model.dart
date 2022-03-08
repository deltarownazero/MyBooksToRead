import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class Book {
  String key;
  String firebaseKey;
  String type;
  String title;
  List<String> isbn;

  @JsonKey(name: 'author_name')
  List<String> author;

  List<String> publisher;
  List<String> language;

  @JsonKey(name: 'first_publish_year')
  int firstPublishYear;

  Book();

  String getAuthors() {
    var authors = author.toString();
    return authors.substring(1, authors.length - 1);
  }

  String getPublishers() {
    var publishers = publisher.toString();
    return publishers.substring(1, publishers.length - 1);
  }

  String getLanguages() {
    var languages = language.toString();
    return languages.substring(1, languages.length - 1);
  }

  factory Book.fromJson(Map<String, dynamic> json) =>
      _$BookFromJson(json)..firebaseKey = json['key'].replaceAll(RegExp('.*/'), '');
  Map<String, dynamic> toJson() => _$BookToJson(this);
}
