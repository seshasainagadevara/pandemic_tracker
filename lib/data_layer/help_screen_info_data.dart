import 'package:cloud_firestore/cloud_firestore.dart';

class HelpScreenInfoData {
  final String _title;
  final String _missions;
  final String _raised;
  final String _supporters;
  final String _served;
  final String _donationPic;

  HelpScreenInfoData(this._title, this._missions, this._raised,
      this._supporters, this._served, this._donationPic);

  factory HelpScreenInfoData.fromSnapShot(DocumentSnapshot documentSnapshot) {
    return HelpScreenInfoData(
        documentSnapshot.data["title"],
        documentSnapshot.data["Missions"],
        documentSnapshot.data["Raised"],
        documentSnapshot.data["Supporters"],
        documentSnapshot.data["Served"],
        documentSnapshot.data["offlineDonation"]);
  }

  String get title => _title;

  String get missions => _missions;

  String get served => _served;

  String get supporters => _supporters;

  String get raised => _raised;

  String get donationPic => _donationPic;
}
