import 'package:bloc/bloc.dart';
import 'package:e_note_khadem/constants/colors.dart';
import 'package:e_note_khadem/presentation/screens/splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upgrader/upgrader.dart';

import 'business_logic/cubit/bloc_observer.dart';
import 'constants/conestant.dart';
import 'data/firecase/firebase_reposatory.dart';
import 'data/firecase/firecbase_fcm.dart';
import 'data/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseReposatory.initFirebase();
// Only call clearSavedSettings() during testing to reset internal values.
  await Upgrader.clearSavedSettings(); // REMOVE this for release builds

  await FirebaseFCM().initNotifications();
  Bloc.observer = Observer();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await CacheHelper.init();

  userType = CacheHelper.getData(key: 'userType');
  constUid = CacheHelper.getData(key: 'user');
  teamId = CacheHelper.getData(key: 'teamId');
  constEmail = CacheHelper.getData(key: 'email');
  payId = CacheHelper.getData(key: 'payId');
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.playIntegrity,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );

  // FirebaseFirestore firebase = FirebaseFirestore.instance;
  // QuerySnapshot<Map<String, dynamic>> admin;
  // String id = 'V6I0QXTBWTICVOVNRPZ1';

  // firebase.collection('users').get().then((value) {
  //   for (int i = 0; i < value.docs.length; i++) {
  //     String user = value.docs[i].id;
  //     firebase
  //         .collection('users')
  //         .doc(user)
  //         .update({'payId': id}).then((value) {
  //       print('$i DONE $user');
  //     }).catchError((error) {
  //       print('$i ERROR $user :$error');
  //     });
  //   }
  // });

//////////////////////////////////////// move data
//   firebase.collection('users').get().then((value) {
//     for (int i = 0; i < value.docs.length; i++) {
//       String user = value.docs[i].id;
//       // String tId = value.docs[i].data()['teamId'];
//       firebase
//           .collection('admin')
//           .doc(id)
//           .collection('users')
//           .doc(user)
//           .set(value.docs[i].data())
//           .then((value) {
//         print('$i DONE $user');
//       }).catchError((error) {
//         print('$i ERROR $user :$error');
//       });
//       firebase
//           .collection('users')
//           .doc(user)
//           .collection('kraat')
//           .get()
//           .then((value) {
//         for (int j = 0; j < value.docs.length; j++) {
//           String ID = value.docs[j].id;
//           firebase
//               .collection('admin')
//               .doc(id)
//               .collection('users')
//               .doc(user)
//               .collection('kraat')
//               .doc(ID)
//               .set(value.docs[j].data())
//               .then((value) {
//             print('$j DONE kraat $user');
//           }).catchError((error) {
//             print('$j ERROR kraat $user :$error');
//           });
//         }
//       });
//       firebase
//           .collection('users')
//           .doc(user)
//           .collection('marathon')
//           .get()
//           .then((value) {
//         for (int j = 0; j < value.docs.length; j++) {
//           String ID = value.docs[j].id;
//           firebase
//               .collection('admin')
//               .doc(id)
//               .collection('users')
//               .doc(user)
//               .collection('marathon')
//               .doc(ID)
//               .set(value.docs[j].data())
//               .then((value) {
//             print('$j DONE marathon $user');
//           }).catchError((error) {
//             print('$j ERROR marathon $user :$error');
//           });
//         }
//       });
//       firebase
//           .collection('users')
//           .doc(user)
//           .collection('attend')
//           .get()
//           .then((value) {
//         for (int j = 0; j < value.docs.length; j++) {
//           String ID = value.docs[j].id;
//           firebase
//               .collection('admin')
//               .doc(id)
//               .collection('users')
//               .doc(user)
//               .collection('attend')
//               .doc(ID)
//               .set(value.docs[j].data())
//               .then((value) {
//             print('$j DONE attend $user');
//           }).catchError((error) {
//             print('$j ERROR attend $user :$error');
//           });
//         }
//       });
//     }
//   });
// ///////////////////////
//   firebase.collection('marathon').get().then((value) {
//     for (int i = 0; i < value.docs.length; i++) {
//       String ID = value.docs[i].id;
//       firebase
//           .collection('admin')
//           .doc(id)
//           .collection('marathon')
//           .doc(ID)
//           .set(value.docs[i].data())
//           .then((value) {
//         print('********* $i');
//       });
//     }
//   });
//   FirebaseReposatory firebaseReposatory = FirebaseReposatory();
//   List<String> firstName = ['marathon', 'manaheg', 'attendance'];
//   for (int i = 0; i < firstName.length; i++) {
//     String pass = 'stHG2@25';
//
//     String email = '${firstName[i]}@gmail.com';
//     firebaseReposatory.signUp(email: email, password: pass).then((value) {
//       firebaseReposatory.createUser(
//           userId: value.user!.uid,
//           email: email,
//           password: pass,
//           fullName: firstName[i],
//           gender: '',
//           birthDate: '',
//           teamId: '',
//           userType: '',
//           phone: '');
//     });
//   }
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
          primarySwatch: ConstColors.getMaterialColor(ConstColors.primaryColor),
          useMaterial3: false),
      home: UpgradeAlert(
        canDismissDialog: false,
        child: const SplashScreen(),
      ),
    );
  }
}
