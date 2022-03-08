import 'package:flutter/material.dart';
import 'package:my_books_to_read/providers/library_provider.dart';
import 'package:provider/provider.dart';

import 'package:my_books_to_read/utils/app_colors.dart';
import 'package:my_books_to_read/utils/string_resources.dart';
import 'package:my_books_to_read/utils/text_styles.dart';
import 'package:my_books_to_read/utils/ui_dimens.dart';
import 'package:my_books_to_read/widgets/primary_button.dart';
import 'package:my_books_to_read/widgets/secondary_button.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final searchController = TextEditingController();
  bool showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(
            bottom: AppUIDimens.paddingSmall,
          ),
          child: Text(
            StringResources.searchBy,
            style: TextStyles.primaryBodyStyle,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            getSearchByButton(StringResources.title),
            getSearchByButton(StringResources.author),
            getSearchByButton(StringResources.any),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: AppUIDimens.paddingMedium),
          decoration: BoxDecoration(
            color: AppColors.backgroundLightGrey,
            borderRadius: BorderRadius.circular(AppUIDimens.borderRadius),
            border: Border.all(color: AppColors.lightGrey),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: AppUIDimens.paddingMedium),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - AppUIDimens.paddingSuperLarge,
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: StringResources.searchHint,
                    ),
                    onSubmitted: (value) async {
                      await context.read<LibraryProvider>().searchBook(value);
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<LibraryProvider>().searchBook(searchController.value.text);
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: const Icon(
                  Icons.search,
                  size: AppUIDimens.iconSize,
                  color: AppColors.greyishBrown,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget getSearchByButton(String title) {
    if (context.watch<LibraryProvider>().chosenSearch == title) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppUIDimens.paddingSmall,
          ),
          child: PrimaryButton(
            text: title,
            callback: () {
              context.read<LibraryProvider>().setChosenSearch(StringResources.any);
            },
          ),
        ),
      );
    } else {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppUIDimens.paddingSmall,
          ),
          child: SecondaryButton(
            text: title,
            callback: () {
              //short sleep because of the bouncing animation
              Future.delayed(AppUIDimens.bouncingAnimationDuration, () {
                context.read<LibraryProvider>().setChosenSearch(title);
              });
            },
          ),
        ),
      );
    }
  }
}
