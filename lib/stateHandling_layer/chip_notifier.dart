import 'package:flutter/foundation.dart';

class ChipNotifier extends ChangeNotifier {
  static Map<String, bool> dataStore = {};
  ChipNotifier();
  storeChipElement(List<String> labels) {
    labels.forEach((label) => dataStore[label] = true);
    print(dataStore);
    notifyListeners();
  }

  Future addToList(MapEntry<String, bool> choice) async {
    print(choice);
    await Future.delayed(Duration(milliseconds: 300), () {
      dataStore.update(choice.key, (_) => choice.value);
      notifyListeners();
      print(dataStore);
    });
  }
}
