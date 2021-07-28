import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pandemicncovidtracker/data_control_layer/market_controller.dart';
import 'package:pandemicncovidtracker/data_layer/market_corousel_data.dart';
import 'package:pandemicncovidtracker/visible_layer/catalouge_screen.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/carousel_show.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/error_diag.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/internet_connected.dart';
import 'package:provider/provider.dart';

class MarketCarousel extends StatefulWidget {
  @override
  _MarketCarouselState createState() => _MarketCarouselState();
}

class _MarketCarouselState extends State<MarketCarousel> {
  MarketController _controller;

  @override
  void initState() {
    _controller = MarketController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<MarketCorouselDataEvent>>(
      create: (BuildContext context) => _controller.mCorouselStream,
      catchError: (ctx, event) => event,
      child: Container(
        height: 200.0,
        width: MediaQuery.of(context).size.width,
        child: Consumer<List<MarketCorouselDataEvent>>(
          builder: (context, data, _) {
            if (data is List<MarketCorouselDataError>) return ErrorDiag();

            if (data is List<MarketCorouselData>) {
              return CarouselShow(
                data,
                onTap: (index) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ProductCatalogScreen(product: data[index].type)));
                },
              );
            }
            return InternetConnectedWidget();
          },
        ),
      ),
    );
  }
}
