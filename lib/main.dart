// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'Controller/sign_in_provider.dart';
import 'Model/const.dart';
import 'View/home_page.dart';
import 'View/sign_in/sign_in_number.dart';
import 'View/sign_in/sign_in_social.dart';
import 'View/sign_in/sms_check_page.dart';
import 'View/sign_in/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late var user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges();
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HiChat App',
      theme: ThemeData(splashColor: kprimaryColor),
      initialRoute: (FirebaseAuth.instance.currentUser != null)
          ? '/homePage'
          : '/welcomePage',
      routes: {
        '/welcomePage': (context) => const WelcomePage(),
        '/signInSocial': (context) => ChangeNotifierProvider(
            create: (context) => SignInProvider(), child: const SignInSocial()),
        '/signInNumber': (context) => ChangeNotifierProvider(
            create: ((context) => SignInProvider()), child: SignInNumber()),
        '/smsCheck': (context) => ChangeNotifierProvider(
            create: (context) => SignInProvider(), child: SmsChechPage()),
        '/homePage': (context) => HomePage(),
      },
    );
  }
}
