import 'package:bloc/bloc.dart';
import 'package:e_note_khadem/presentation/screens/splash_screen.dart';
import 'package:e_note_khadem/utiles/id.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'business_logic/cubit/bloc_observer.dart';
import 'constants/conestant.dart';
import 'data/firecase/firebase_reposatory.dart';
import 'data/firecase/firecbase_fcm.dart';
import 'data/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseReposatory.initFirebase();

  await FirebaseFCM().initNotifications();
  Bloc.observer = Observer();
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await CacheHelper.init();
  userType = CacheHelper.getData(key: 'userType');
  constUid = CacheHelper.getData(key: 'user');
  teamId = CacheHelper.getData(key: 'teamId');
  constEmail = CacheHelper.getData(key: 'email');
  FirebaseReposatory firebaseReposatory = FirebaseReposatory();
  List<String> firstName = ['marathon', 'manaheg', 'attendance'];
  for (int i = 0; i < firstName.length; i++) {
    String pass = ID.createId();

    String email = '${firstName[i]}@gmail.com';
    firebaseReposatory.signUp(email: email, password: pass).then((value) {
      firebaseReposatory.createUser(
          userId: value.user!.uid,
          email: email,
          password: pass,
          fullName: firstName[i],
          gender: '',
          birthDate: '',
          teamId: '',
          userType: '',
          phone: '');
    });
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}
