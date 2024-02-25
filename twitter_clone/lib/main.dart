import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/firebase_options.dart';
import 'package:twitter_clone/pages/create.dart';
import 'package:twitter_clone/pages/home.dart';
import 'package:twitter_clone/pages/settings.dart';
import 'package:twitter_clone/pages/sign_in.dart';
import 'package:twitter_clone/pages/sign_up.dart';
import 'package:twitter_clone/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      routes: {
        '/signin': (context) => const SignIn(),
        '/home': (context) => const Home(),
        '/settings': (context) => const Settings(),
        '/create': (context) => const CreateTweet(),
        '/signup': (context) => const SignUp(),
      },
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ref.read(userProvider.notifier).login(snapshot.data!.email!);
              return const Home();
            }
            return const SignIn();
          }),
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 247, 255, 255),
          titleTextStyle: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          centerTitle: true,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 247, 255, 255),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color.fromARGB(255, 247, 255, 255),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
