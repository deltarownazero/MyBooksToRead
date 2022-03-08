import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_books_to_read/utils/text_styles.dart';
import 'package:my_books_to_read/utils/ui_dimens.dart';

class DescriptionRow extends StatelessWidget {
  final String label;
  final String desc;
  const DescriptionRow({Key key, @required this.label, @required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppUIDimens.paddingMedium, right: AppUIDimens.paddingLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyles.primaryBodyStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Expanded(
            child: Text(
              desc,
              style: TextStyles.primaryBodyStyle.copyWith(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
