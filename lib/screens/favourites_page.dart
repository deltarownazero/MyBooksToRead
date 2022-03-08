import 'package:flutter/material.dart';
import 'package:my_books_to_read/providers/library_provider.dart';
import 'package:my_books_to_read/utils/ui_dimens.dart';
import 'package:my_books_to_read/widgets/book_preview.dart';
import 'package:provider/provider.dart';

import 'package:my_books_to_read/utils/string_resources.dart';
import 'package:my_books_to_read/utils/text_styles.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    final libraryProvider = context.watch<LibraryProvider>();
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            StringResources.appTitle,
            style: TextStyles.appBarStyle,
          ),
        ),
        body: libraryProvider.favourites != null
            ? Column(
                children: [
                  libraryProvider.favourites.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: AppUIDimens.paddingLarge),
                          child: Center(
                            child: Text(
                              StringResources.yourFavListIsEmpty,
                              style: TextStyles.primaryBodyStyle,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: libraryProvider.favourites.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(AppUIDimens.paddingSmall),
                              child: BookPreview(
                                book: libraryProvider.favourites[index],
                                isFromFavouritesScreen: true,
                              ),
                            );
                          },
                        ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    context.read<LibraryProvider>().setRefreshFavourites(true);
    return true;
  }
}
