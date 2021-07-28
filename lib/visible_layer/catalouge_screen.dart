import 'package:flutter/material.dart';
import 'package:pandemicncovidtracker/data_control_layer/catalog_controller.dart';
import 'package:pandemicncovidtracker/data_control_layer/internet_connection_checker.dart';
import 'package:pandemicncovidtracker/data_layer/catalogProduct_data.dart';
import 'package:pandemicncovidtracker/data_layer/connection_status_data.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/cartIconUpdater.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/internet_connected.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/internet_disconnected.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/productItemTile.dart';
import 'package:provider/provider.dart';

class ProductCatalogScreen extends StatefulWidget {
  final String product;
  ProductCatalogScreen({this.product});

  @override
  _ProductCatalogScreenState createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  CatalogController _catalogController;
  InternetChecker _internetChecker;

  @override
  void initState() {
    _internetChecker = InternetChecker();
    _catalogController = CatalogController(widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.black87,
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              alignment: Alignment.center,
              fit: BoxFit.cover,
              image: AssetImage(
                "images/back.jpg",
              ),
            ),
            color: Colors.black,
          ),
        ),
//        title: Text(
//          widget.product,
//        ),
        actions: <Widget>[
          CartIcon(),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: StreamProvider<List<CatalogProductData>>(
        create: (context) => _catalogController.catalogStream,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.all(8.0),
              child: Consumer<List<CatalogProductData>>(
                  builder: (context, data, _) {
                if (data == null)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                return GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  children: data
                      .where((item) => item.availability == true)
                      .map((item) => ProductItemGridTile(item))
                      .toList(),
                );
              }),
            ),
            StreamBuilder<InternetConnection>(
                stream: _internetChecker.stream,
                initialData: InternetConnectionSuccess(),
                builder: (context, snapshot) {
                  if (snapshot.data is InternetConnectionSuccess)
                    return InternetConnectedWidget();

                  if (snapshot.error is InternetConnectionError)
                    return InternetDisconnected();
                }),
          ],
        ),
      ),
    );
  }
}
