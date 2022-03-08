import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_books_to_read/providers/library_provider.dart';
import 'package:my_books_to_read/services/database.dart';
import 'package:provider/provider.dart';

import 'package:my_books_to_read/models/book_model.dart';
import 'package:my_books_to_read/widgets/book_detailed_widget.dart';
import 'package:my_books_to_read/utils/app_colors.dart';
import 'package:my_books_to_read/utils/string_resources.dart';
import 'package:my_books_to_read/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:my_books_to_read/utils/ui_dimens.dart';

import 'description_row.dart';

class BookPreview extends StatefulWidget {
  final Book book;
  final bool isFromFavouritesScreen;
  const BookPreview({
    Key key,
    @required this.book,
    this.isFromFavouritesScreen = false,
  }) : super(key: key);

  @override
  State<BookPreview> createState() => _BookPreviewState();
}

class _BookPreviewState extends State<BookPreview> {
  bool isFavourite = false;

  double get descriptionWidth =>
      MediaQuery.of(context).size.width - 2 * AppUIDimens.paddingMedium - AppUIDimens.imagePreviewSize;

  @override
  void initState() {
    super.initState();
    checkIfFavourite();
  }

  void checkIfFavourite() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final bookFromFavouriteList = context
          .read<LibraryProvider>()
          .favourites
          .firstWhere((favourite) => favourite.title == widget.book.title, orElse: () => null);
      setState(() {
        isFavourite = bookFromFavouriteList != null;
      });
      context.read<LibraryProvider>().setRefreshFavourites(false);
    });
  }

  Future<void> _createOrDeleteFavourite(Book book) async {
    try {
      if (isFavourite) {
        await context.read<Database>().deleteFavourite(book);
      } else {
        await context.read<Database>().createFavourite(book);
      }
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<LibraryProvider>().refreshFavourites) {
      checkIfFavourite();
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppUIDimens.smallBorderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 9,
            offset: const Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: showBookDetailed,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppUIDimens.smallBorderRadius),
                  bottomLeft: Radius.circular(AppUIDimens.smallBorderRadius),
                ),
              ),
              height: AppUIDimens.imagePreviewSize,
              width: AppUIDimens.imagePreviewSize,
              child: const Center(
                  child: Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
              )),
            ),
          ),
          SizedBox(
            width: descriptionWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: showBookDetailed,
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppUIDimens.paddingMedium),
                    child: Text(
                      widget.book.title,
                      style:
                          TextStyles.appBarStyle.copyWith(fontSize: 16, color: AppColors.primaryColor),
                      //textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                      right: AppUIDimens.paddingSmall,
                      child: GestureDetector(
                        onTap: () {
                          _createOrDeleteFavourite(widget.book);
                          if (!widget.isFromFavouritesScreen) {
                            setState(() {
                              isFavourite = !isFavourite;
                            });
                          }
                        },
                        child: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: showBookDetailed,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: AppUIDimens.paddingSmall),
                            child: DescriptionRow(
                                label: StringResources.author, desc: widget.book.getAuthors()),
                          ),
                          DescriptionRow(
                              label: StringResources.firstPublishYear,
                              desc: widget.book.firstPublishYear.toString()),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  showBookDetailed() {
    showCupertinoModalBottomSheet(
      enableDrag: false,
      context: context,
      builder: (context) => BookDetailedWidget(
        book: widget.book,
      ),
    );
  }
}
