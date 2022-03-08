import 'package:my_books_to_read/screens/books_list_page.dart';
import 'package:my_books_to_read/screens/sign_in_page.dart';
import 'package:my_books_to_read/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_books_to_read/services/database.dart';
import 'package:my_books_to_read/utils/string_resources.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  final AuthBase auth;

  const LandingPage({Key key, @required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            if (user == null) {
              return SignInPage(
                auth: auth,
              );
            } else {
              return Provider<Database>(
                  create: (_) => FirestoreDatabase(uid: user.uid),
                  builder: (context, _) {
                    return BooksListPage(
                      title: StringResources.appTitle,
                      auth: auth,
                    );
                  });
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
