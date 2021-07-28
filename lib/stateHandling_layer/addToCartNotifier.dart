import 'package:flutter/foundation.dart';
import 'package:pandemicncovidtracker/data_control_layer/market_controller.dart';
import 'package:pandemicncovidtracker/data_layer/catalogProduct_data.dart';

class AddToCartNotifier extends ChangeNotifier {
  MarketController _marketController;
  bool isAdded;
  AddToCartNotifier() {
    _marketController = MarketController.getKart();
  }

  updateCartNumber(CatalogProductData _catlogData) {
    isAdded = false;
    notifyListeners();
    _marketController.writeCartItems(_catlogData).then((_) {
      isAdded = true;
      notifyListeners();
    });
  }
}
