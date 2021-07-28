import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pandemicncovidtracker/data_layer/location_data.dart';
import 'package:pandemicncovidtracker/events/login_events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseUserController {
  FirebaseAuth _firebaseAuth;
  GoogleSignIn _googleSignIn;
  Firestore _firestore;
  SharedPreferences _sharedPreferences;

  FirebaseUserController.forLogIn()
      : _firebaseAuth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn();

  FirebaseUserController.loginCheck() {
    _firebaseAuth = FirebaseAuth.instance;
  }
  FirebaseUserController() {
    _firestore = Firestore.instance;
  }

  Future<LoginEvents> signInWithGoogle() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      return _firebaseAuth
          .signInWithCredential(await _googleSignIn.signIn().then(
              (googleUser) => googleUser.authentication
                  .then((googleAuth) => GoogleAuthProvider.getCredential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      ))))
          .then((value) => _sharedPreferences.setStringList("creds", [
                value.user.displayName,
                value.user.email,
                value.user.photoUrl,
                value.user.uid
              ]).then((value) => _sharedPreferences.reload()))
          .then((value) => LoggedIn())
          .catchError((error) => ErrorLogin());
    } catch (e) {
      return ErrorLogin();
    }
  }

//  Future<void> signInWithCredentials(String email, String password) {
//    return _firebaseAuth.signInWithEmailAndPassword(
//      email: email,
//      password: password,
//    );
//  }

//  Future<void> signUp({String email, String password}) async {
//    return await _firebaseAuth.createUserWithEmailAndPassword(
//      email: email,
//      password: password,
//    );
//  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<LoginEvents> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    if (currentUser != null)
      return LoggedIn();
    else
      return NotLoggedIn();
  }

  Future<FirebaseUser> getUser() async {
    return (await _firebaseAuth.currentUser());
  }

  Future getUserDetails() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getStringList("creds");
  }

  Future<void> writeUserDate(UserLocationData userLocationData) async {
    CollectionReference _cf = _firestore.collection("users");
    DocumentReference _dr = _cf.document(userLocationData.uid);
    await _firestore.runTransaction((transaction) async {
      await transaction.set(_dr, userLocationData.getUserDataMap());
    }).catchError((e) {
      print("error ${e.toString()}");
    });
  }
}
