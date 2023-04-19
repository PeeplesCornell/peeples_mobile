import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peeples/pages/friends.dart';
import 'package:peeples/pages/history.dart';
import 'package:peeples/pages/main_page.dart';
import 'package:peeples/pages/points.dart';
import 'package:peeples/pages/questionnaire.dart';
import 'package:peeples/pages/settings.dart';
import 'package:peeples/pages/signin.dart';
import 'package:peeples/pages/test.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Deamo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'SFPro',
      ),
      routes: {
        // '/': (context) => const SignInScreen(),
        // '/': (context) => const HomePage(),
        '/': (context) => const Questionnaire(),
        '/history': (context) => const History(),
        '/friends': (context) => const Friends(),
        // '/friends': (context) => const Questionnaire(),
        '/points': (context) => const Points(),
        '/settings': (context) => const Settings(),
      },
    );
  }
}
