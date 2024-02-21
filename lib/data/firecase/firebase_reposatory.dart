import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_note_khadem/data/models/marathon_model.dart';
import 'package:e_note_khadem/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

import '../../constants/conestant.dart';
import 'firebase_options.dart';

class FirebaseReposatory {
  static FirebaseFirestore firebase = FirebaseFirestore.instance;

  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> createUser({
    required String userId,
    required String fullName,
    required String email,
    required String password,
    required String gender,
    required String birthDate,
    required String teamId,
    required String userType,
    required String phone,
    required String payId,
  }) async {
    UserModel userModel = UserModel(fullName, email, userId, phone, password,
        gender, birthDate, teamId, userType, payId);
    return firebase.collection('khadem').doc(userId).set(userModel.toMap());
  }

  Future<void> createMarathon({
    required String id,
    required String title,
    required String content,
    required String modifiedTime,
  }) async {
    MarathonModel marathonModel =
        MarathonModel(id, title, content, modifiedTime);
    return firebase
        .collection('admin')
        .doc(payId)
        .collection('marathon')
        .doc(id)
        .set(marathonModel.toMap());
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    return FirebaseAuth.instance.signOut();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(
      {required String userId}) {
    return firebase.collection('users').doc(userId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getKhademData(
      {required String userId}) {
    return firebase.collection('khadem').doc(userId).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserAttendData(
      {required String userId}) {
    return firebase.collection('users').doc(userId).collection('attend').get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserAttendDayData(
      {required String userId, required String date}) {
    return firebase
        .collection('users')
        .doc(userId)
        .collection('attend')
        .doc(date)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserKraatData(
      {required String userId}) {
    return firebase.collection('users').doc(userId).collection('kraat').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserMarathonAnswerData(
      {required String? userId}) {
    return firebase
        .collection('users')
        .doc(userId)
        .collection('marathon')
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getMarathonData() {
    return firebase.collection('admin').doc(payId).collection('marathon').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getTeamUsers() {
    return firebase
        .collection('users')
        .where("teamId", isEqualTo: teamId)
        // .where('email', isNotEqualTo: constEmail)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAdminUsers() {
    return firebase.collection('users').where("payId", isEqualTo: payId).get();
  }

  Future<void> createUserAttend({
    required String? userId,
  }) async {
    return firebase
        .collection('users')
        .doc(userId)
        .collection('attend')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .set({
      'lecture 1': '',
      'lecture 2': '',
    });
  }

  Future<void> updateUserMarathonAnswer({
    required String comment,
    required String marathonId,
    required String userId,
  }) async {
    return firebase
        .collection('users')
        .doc(userId)
        .collection('marathon')
        .doc(marathonId)
        .update({
      'comment': comment,
    });
  }

  Future<void> updateUserAttend({
    required String? userId,
    required String lectureNum,
  }) async {
    return firebase
        .collection('users')
        .doc(userId)
        .collection('attend')
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .update({
      'lecture $lectureNum': DateFormat('hh : mma').format(DateTime.now())
    });
  }

  (
    Future<QuerySnapshot<Map<String, dynamic>>>,
    Future<QuerySnapshot<Map<String, dynamic>>>,
    Future<QuerySnapshot<Map<String, dynamic>>>
  ) makeReport({required String? userId}) {
    return (
      firebase.collection('users').doc(userId).collection('attend').get(),
      firebase.collection('users').doc(userId).collection('kraat').get(),
      firebase.collection('users').doc(userId).collection('marathon').get()
    );
  }
}
