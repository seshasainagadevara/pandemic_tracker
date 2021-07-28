import 'package:flutter/material.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/cartIconUpdater.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/market_corousel.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/market_items.dart';

class MarketTab extends StatefulWidget {
  @override
  _MarketTabState createState() => _MarketTabState();
}

class _MarketTabState extends State<MarketTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              CartIcon(),
            ],
            iconTheme: IconThemeData(color: Colors.black87),
            elevation: 0.0,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 110.0,
            flexibleSpace: Container(
              child: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Market",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                MarketCarousel(),
                MarketItems(),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "वसुधैव कुटुम्बकम् - Entire world is a family",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
//            MarketCarousel(),
//            MarketItems(),
        ],
      ),
    );
  }
}
