import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_books_to_read/models/book_model.dart';
import 'package:provider/provider.dart';

import 'package:my_books_to_read/screens/favourites_page.dart';
import 'package:my_books_to_read/services/database.dart';

import 'package:my_books_to_read/providers/library_provider.dart';
import 'package:my_books_to_read/services/auth.dart';
import 'package:my_books_to_read/utils/text_styles.dart';
import 'package:my_books_to_read/utils/ui_dimens.dart';
import 'package:my_books_to_read/widgets/book_preview.dart';
import 'package:my_books_to_read/widgets/search_widget.dart';

class BooksListPage extends StatefulWidget {
  const BooksListPage({Key key, @required this.title, @required this.auth}) : super(key: key);
  final String title;
  final AuthBase auth;

  @override
  _BooksListPageState createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {
  @override
  void initState() {
    super.initState();
    loadFromFirebase();
  }

  void loadFromFirebase() async {
    final database = context.read<Database>();
    final Stream<List<Book>> books = database.booksStream();

    books.listen((snapshot) {
      if (mounted) {
        context.read<LibraryProvider>().setFavourites(snapshot);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyles.appBarStyle,
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                _signOut(context);
              })
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppUIDimens.paddingMedium),
            child: SearchWidget(),
          ),
          if (context.watch<LibraryProvider>().isSearching)
            const Center(child: CircularProgressIndicator())
          else
            const BookList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Provider<Database>(
                create: (context) => FirestoreDatabase(uid: widget.auth.currentUser.uid),
                builder: (context, _) => const FavouritesPage(),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.favorite_border_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      context.read<LibraryProvider>().clear();
      await widget.auth.signOut();
    } catch (e) {
      log(e);
    }
  }
}

class BookList extends StatefulWidget {
  const BookList({Key key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    final libraryProvider = context.watch<LibraryProvider>();
    return libraryProvider.currentSearchResponse != null
        ? Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: libraryProvider.currentSearchResponse.docs.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(AppUIDimens.paddingSmall),
                  child: BookPreview(
                    book: libraryProvider.currentSearchResponse.docs[index],
                  ),
                );
              },
            ),
          )
        : Container();
  }
}
