import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pandemicncovidtracker/data_layer/help_screen_carousel.dart';
import 'package:pandemicncovidtracker/data_layer/help_screen_info_data.dart';
import 'package:pandemicncovidtracker/data_layer/mission_data.dart';

class HelpController {
  Firestore _firestore;
  Stream<HelpScreenInfoData> _helpBannerStream;
  Stream<List<HelpScreenCarouselData>> _helpCarouselStream;
  Stream<List<MissionData>> _missionStream;

  HelpController() {
    _firestore = Firestore.instance;
    _getBanner();
    _getHelpCarousel();
    _getMissionsData();
  }

  _getBanner() {
    _helpBannerStream = _firestore
        .collection("services")
        .document("donate")
        .snapshots()
        .transform(StreamTransformer.fromHandlers(
            handleData: (data, sink) =>
                sink.add(HelpScreenInfoData.fromSnapShot(data)),
            handleDone: (sink) => sink.close(),
            handleError: (data, err, sink) => sink.close()));
  }

  _getHelpCarousel() {
    _helpCarouselStream = _firestore
        .collection("services/donate/news")
        .snapshots()
        .map((event) => event.documents)
        .transform(StreamTransformer.fromHandlers(
            handleData: (data, sink) => sink.add(data
                .map((e) => HelpScreenCarouselData.fromSnapShot(e))
                .toList()),
            handleDone: (sink) => sink.close(),
            handleError: (data, err, sink) => sink.close()));
  }

  _getMissionsData() {
    _missionStream = _firestore
        .collection("services/donate/missions")
        .snapshots()
        .map((event) => event.documents)
        .transform(StreamTransformer.fromHandlers(
            handleData: (data, sink) =>
                sink.add(data.map((e) => MissionData.fromSnapShot(e)).toList()),
            handleDone: (sink) => sink.close(),
            handleError: (data, err, sink) => sink.close()));
  }

  Stream<HelpScreenInfoData> get helpBannerStream => _helpBannerStream;
  Stream<List<MissionData>> get missionStream => _missionStream;

  Stream<List<HelpScreenCarouselData>> get helpCarouselStream =>
      _helpCarouselStream;
}
