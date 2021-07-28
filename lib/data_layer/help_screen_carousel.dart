import 'package:cloud_firestore/cloud_firestore.dart';

class HelpScreenCarouselData {
  final String imageUrl;

  HelpScreenCarouselData({
    this.imageUrl,
  });

  factory HelpScreenCarouselData.fromSnapShot(
      DocumentSnapshot documentSnapshot) {
    return HelpScreenCarouselData(
      imageUrl: documentSnapshot.data["imageUrl"],
    );
  }
}
