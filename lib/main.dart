import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:projectb/config/app_theme.dart';
import 'package:projectb/services/auth_service.dart';
import 'package:projectb/shared/localization/locale_configs.dart';
import 'package:projectb/views/test_view.dart';
import 'package:projectb/views/user_view.dart';
import 'package:projectb/widgets/auth_widget.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['i18n/'];
    return MaterialApp(
      routes: {
        '/auth': (context) => const AuthCheck(),
        '/user': (context) => const UserView(),
        '/test': (context) => const TestView(),
      },
      theme: ThemeData(
          scaffoldBackgroundColor: bgColor,
          fontFamily: "Poppins",
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: whiteColor),
          )),
      locale: const Locale("en"),
      supportedLocales: supLang,
      localizationsDelegates: locDel,
      home: const Scaffold(
        backgroundColor: primaryColor,
        body: AuthCheck(),
      ),
    );
  }
}
