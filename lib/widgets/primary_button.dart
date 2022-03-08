import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:my_books_to_read/utils/app_colors.dart';
import 'package:my_books_to_read/utils/text_styles.dart';
import 'package:my_books_to_read/utils/ui_dimens.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final Function callback;

  const PrimaryButton({Key key, @required this.text, this.callback, this.iconPath})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppUIDimens.buttonHeight,
      child: BouncingWidget(
        onPressed: callback,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppUIDimens.paddingMedium),
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(AppUIDimens.smallBorderRadius)),
          ),
          child: iconPath != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: AppUIDimens.paddingMedium),
                      child: Image.asset(iconPath),
                    ),
                    Text(
                      text,
                      style: TextStyles.primaryBodyStyle.copyWith(color: Colors.white),
                    ),
                    Opacity(
                        opacity: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: AppUIDimens.paddingMedium),
                          child: Image.asset(iconPath),
                        )),
                  ],
                )
              : Center(
                  child: Text(
                    text,
                    style: TextStyles.primaryBodyStyle.copyWith(color: Colors.white),
                  ),
                ),
        ),
      ),
    );
  }
}
