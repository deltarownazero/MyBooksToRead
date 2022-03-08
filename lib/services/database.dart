import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_books_to_read/models/book_model.dart';
import 'package:my_books_to_read/utils/api_path.dart';

abstract class Database {
  Future<void> createFavourite(Book book);
  Future<void> deleteFavourite(Book book);

  Stream<List<Book>> booksStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  @override
  Stream<List<Book>> booksStream() {
    final path = APIPath.bookFavourites(uid);
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map(
          (snapshot) {
            final data = snapshot.data();
            return Book.fromJson(data);
          },
        ).toList());
  }

  @override
  Future<void> createFavourite(Book book) => _setData(
        path: APIPath.bookFavourite(uid, book.firebaseKey),
        data: book.toJson(),
      );

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  @override
  Future<void> deleteFavourite(Book book) async {
    final path = APIPath.bookFavourite(uid, book.firebaseKey);
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }
}
