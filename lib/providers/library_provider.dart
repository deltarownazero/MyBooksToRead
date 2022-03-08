import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_books_to_read/models/book_model.dart';
import 'package:my_books_to_read/models/library_search_response.dart';
import 'package:my_books_to_read/utils/api_path.dart';
import 'package:my_books_to_read/utils/string_resources.dart';
import 'package:http/http.dart';

class LibraryProvider extends ChangeNotifier {
  String _chosenSearch = StringResources.title;
  bool _isSearching = false;
  LibrarySearchResponse _librarySearchResponse;
  List<Book> _favourites;
  bool _refreshFavourites = false;

  bool get refreshFavourites => _refreshFavourites;
  List<Book> get favourites => _favourites;
  LibrarySearchResponse get currentSearchResponse => _librarySearchResponse;
  bool get isSearching => _isSearching;
  String get chosenSearch => _chosenSearch;
  String get searchParameter =>
      _chosenSearch == StringResources.any ? 'q=' : _chosenSearch.toLowerCase() + '=';

  void clear() {
    _favourites = null;
    _librarySearchResponse = null;
    _chosenSearch = StringResources.title;
  }

  void setRefreshFavourites(bool value) {
    _refreshFavourites = value;
    notifyListeners();
  }

  void setFavourites(List<Book> favourites) {
    _favourites = favourites;
    notifyListeners();
  }

  void setChosenSearch(String value) {
    _chosenSearch = value;
    notifyListeners();
  }

  Future<LibrarySearchResponse> searchBook(String title) async {
    _isSearching = true;
    notifyListeners();
    final uri = Uri.parse(APIPath.baseLibraryUrl + APIPath.searchParameter + searchParameter + title);
    final response = await get(uri);
    _isSearching = false;
    notifyListeners();
    if (response != null && response.statusCode == 200) {
      _librarySearchResponse = LibrarySearchResponse.fromJson(jsonDecode(response.body));
      return LibrarySearchResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<String> getBookPreviewUrl(String isbn) async {
    final uri = Uri.parse(APIPath.baseLibraryUrl +
        APIPath.booksApi +
        APIPath.bibkeysParameter +
        isbn +
        APIPath.jscmdParameter +
        APIPath.formatParameter);
    final response = await get(uri);
    if (response != null) {
      final body = jsonDecode(response.body);
      final String imageUrl = body['ISBN:$isbn']['thumbnail_url'];
      if (imageUrl != null) {
        return imageUrl.replaceAll('S.jpg', 'M.jpg');
      }
    }
    return null;
  }
}
