import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String _name;
  String _mail;
  String _uid;
  String _proPic;
  String _phoneNumber;

  UserData(this._name, this._mail, this._uid, this._proPic, this._phoneNumber);

  factory UserData.fromFUSER(FirebaseUser firebaseUser) {
    return UserData(firebaseUser.displayName, firebaseUser.email,
        firebaseUser.uid, firebaseUser.photoUrl, firebaseUser.phoneNumber);
  }

  String get name => _name;

  String get phoneNumber => _phoneNumber;

  String get proPic => _proPic;

  String get uid => _uid;

  String get mail => _mail;
}
