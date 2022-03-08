import 'package:my_books_to_read/providers/library_provider.dart';
import 'package:my_books_to_read/screens/landing_page.dart';
import 'package:my_books_to_read/services/auth.dart';
import 'package:my_books_to_read/utils/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      ChangeNotifierProvider(
        create: (BuildContext context) => LibraryProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crochet App',
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
