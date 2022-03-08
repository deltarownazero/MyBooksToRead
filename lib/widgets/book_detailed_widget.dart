import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_books_to_read/providers/library_provider.dart';
import 'package:provider/provider.dart';

import 'package:my_books_to_read/models/book_model.dart';
import 'package:my_books_to_read/utils/app_colors.dart';
import 'package:my_books_to_read/utils/string_resources.dart';
import 'package:my_books_to_read/utils/text_styles.dart';
import 'package:my_books_to_read/utils/ui_dimens.dart';

class BookDetailedWidget extends StatefulWidget {
  final Book book;
  const BookDetailedWidget({Key key, @required this.book}) : super(key: key);

  @override
  State<BookDetailedWidget> createState() => _BookDetailedWidgetState();
}

class _BookDetailedWidgetState extends State<BookDetailedWidget> {
  String previewUrl;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - AppUIDimens.paddingMedium,
      child: SingleChildScrollView(
        child: Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppUIDimens.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.primaryColor,
                        size: AppUIDimens.iconLargeSize,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    widget.book.title,
                    style: TextStyles.crochetAppStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: AppUIDimens.paddingSmall, top: AppUIDimens.paddingMedium),
                    child: Container(
                      width: (MediaQuery.of(context).size.width - AppUIDimens.paddingMedium) * 15 / 21,
                      height: MediaQuery.of(context).size.width - AppUIDimens.paddingMedium,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(AppUIDimens.borderRadius),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppUIDimens.borderRadius,
                        ),
                        child: AspectRatio(
                          aspectRatio: 148 / 210,
                          child: previewUrl == null
                              ? const Icon(
                                  Icons.menu_book_rounded,
                                  color: Colors.white,
                                )
                              : CachedNetworkImage(
                                  imageUrl: previewUrl,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                _descriptionWidget(
                  StringResources.author,
                  widget.book.getAuthors(),
                ),
                _descriptionWidget(
                  StringResources.firstPublishYear,
                  widget.book.firstPublishYear.toString(),
                ),
                _descriptionWidget(
                  StringResources.languages,
                  widget.book.getLanguages(),
                ),
                _descriptionWidget(
                  StringResources.publisher,
                  widget.book.getPublishers(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _descriptionWidget(String label, String desc) {
    return Padding(
      padding: const EdgeInsets.only(top: AppUIDimens.paddingSmall),
      child: RichText(
        text: TextSpan(
          style: TextStyles.primaryBodyStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
          children: [
            TextSpan(
              text: '$label: ',
            ),
            TextSpan(
              text: desc,
              style: TextStyles.primaryBodyStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  void getImage() async {
    if (widget.book.isbn != null && widget.book.isbn.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        final newPreviewUrl =
            await context.read<LibraryProvider>().getBookPreviewUrl(widget.book.isbn.last);
        setState(() {
          previewUrl = newPreviewUrl;
        });
      });
    }
  }
}
