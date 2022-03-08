class APIPath {
  static String bookFavourite(String uid, String bookID) => '/users/$uid/favourites/$bookID';
  static String bookFavourites(String uid) => '/users/$uid/favourites';

  static String baseLibraryUrl = 'http://openlibrary.org/';
  static String searchParameter = 'search.json?';
  static String booksApi = 'api/books?';
  static String bibkeysParameter = 'bibkeys=ISBN:';
  static String jscmdParameter = '&jscmd=details';
  static String formatParameter = '&format=json';
}
