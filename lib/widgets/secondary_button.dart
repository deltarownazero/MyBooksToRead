import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:my_books_to_read/utils/app_colors.dart';
import 'package:my_books_to_read/utils/text_styles.dart';
import 'package:my_books_to_read/utils/ui_dimens.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final Function callback;
  final Color borderColor;

  const SecondaryButton({
    Key key,
    @required this.text,
    this.callback,
    this.borderColor = AppColors.primaryColor,
    this.iconPath,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppUIDimens.buttonHeight,
      child: BouncingWidget(
        onPressed: callback,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppUIDimens.paddingMedium),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
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
                      style: TextStyles.primaryBodyStyle,
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
                    style: TextStyles.primaryBodyStyle.copyWith(color: AppColors.greyishBrown),
                  ),
                ),
        ),
      ),
    );
  }
}
