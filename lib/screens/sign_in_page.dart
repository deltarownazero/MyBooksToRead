import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:my_books_to_read/services/auth.dart';
import 'package:my_books_to_read/utils/app_colors.dart';
import 'package:my_books_to_read/utils/string_resources.dart';
import 'package:my_books_to_read/utils/text_styles.dart';
import 'package:my_books_to_read/utils/ui_dimens.dart';
import 'package:my_books_to_read/widgets/primary_button.dart';
import 'package:my_books_to_read/widgets/secondary_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringResources.signIn,
          style: TextStyles.appBarStyle,
        ),
      ),
      backgroundColor: AppColors.backgroundLightGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              StringResources.welcome,
              style: TextStyles.crochetAppStyle,
            ),
          ),
          SizedBox(
            height: appLogoMargin,
          ),
          Padding(
            padding: const EdgeInsets.all(AppUIDimens.paddingSmall),
            child: SecondaryButton(
              iconPath: 'images/google-logo.png',
              text: StringResources.signInWithGoogle,
              callback: _signInWithGoogle,
            ),
          ),
//todo add later
/*          Padding(
            padding: const EdgeInsets.all(AppUIDimens.paddingSmall),
            child: SecondaryButton(
              iconPath: 'images/facebook-logo.png',
              text: StringResources.signInWithFacebook,
              callback: _signInWithFacebook,
            ),
          ),*/
/*          Padding(
            padding: const EdgeInsets.all(AppUIDimens.paddingSmall),
            child: SecondaryButton(
              text: StringResources.signInWithEmail,
              callback: _signInWithEmail,
            ),
          ),*/
          const Text(
            StringResources.or,
            textAlign: TextAlign.center,
            style: TextStyles.primaryBodyStyle,
          ),
          Padding(
            padding: const EdgeInsets.all(AppUIDimens.paddingSmall),
            child: PrimaryButton(
              text: StringResources.goAnonymous,
              callback: _goAnonymous,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      await widget.auth.signInWithGoogle();
    } catch (e) {
      log(e.toString());
    }
  }

/*  void _signInWithFacebook() {
    //TODO
  }*/

/*  void _signInWithEmail() {
    //TODO
  }*/

  Future<void> _goAnonymous() async {
    try {
      await widget.auth.signInAnonymously();
    } catch (e) {
      log(e.toString());
    }
  }

  double get appLogoMargin => MediaQuery.of(context).size.height / 7;
}
