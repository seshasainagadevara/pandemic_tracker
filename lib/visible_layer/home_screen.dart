import 'package:flutter/material.dart';
import 'package:pandemicncovidtracker/data_control_layer/internet_connection_checker.dart';
import 'package:pandemicncovidtracker/data_control_layer/market_controller.dart';
import 'package:pandemicncovidtracker/data_layer/connection_status_data.dart';
import 'package:pandemicncovidtracker/visible_layer/emergencyTab.dart';
import 'package:pandemicncovidtracker/visible_layer/market_tab.dart';
import 'package:pandemicncovidtracker/visible_layer/newsTab.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/internet_connected.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/internet_disconnected.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/side_app_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static double _size = 14.0;
  static double _textSize = 10.0;
  InternetChecker _internetChecker;
  WidgetsBinding _binding;
  MarketController _marketController;

  @override
  void initState() {
    _internetChecker = InternetChecker();
    _marketController = MarketController.updateCart();
    Future.delayed(
        Duration(milliseconds: 800), () => _marketController.updateCart());
    _binding = WidgetsBinding.instance
      ..addObserver(LifeCycleEventHandler(
          detachedCall: () async => _marketController.updateCart()));
    super.initState();
  }

  final List _myTabs = [
    // [Icon(Icons.track_changes, size: _size), "Tracker"],
    [Icon(Icons.shopping_basket, size: _size), "Market"],
    [Icon(Icons.accessible, size: _size), "Help"],
    [Icon(Icons.trending_up, size: _size), "Trends"],
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          // floatingActionButton: _callFloatingDiaolg(),
          backgroundColor: Colors.white,
          drawer: SideAppDrawer(),
          bottomNavigationBar: Container(
            height: 55.0,
            padding: EdgeInsets.only(bottom: 10.0),
            child: TabBar(
                labelColor: Colors.red[600],
                indicatorWeight: 0.1,
                labelStyle: TextStyle(fontSize: _textSize),
                unselectedLabelStyle: TextStyle(fontSize: _textSize),
                unselectedLabelColor: Colors.black54,
                tabs: _myTabs
                    .map((icon) => Tab(
                          icon: icon[0],
                          text: icon[1],
                        ))
                    .toList()),
          ),
          body: Stack(
            children: <Widget>[
              TabBarView(physics: NeverScrollableScrollPhysics(), children: [
                MarketTab(),
                EmergencyTab(),
                NewsTab(),
              ]),
              _callFloatingDiaolg(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _callFloatingDiaolg() {
    return StreamBuilder<InternetConnection>(
        stream: _internetChecker.stream,
        initialData: InternetConnectionSuccess(),
        builder: (context, snapshot) {
          if (snapshot.data is InternetConnectionSuccess)
            return InternetConnectedWidget();

          if (snapshot.error is InternetConnectionError)
            return InternetDisconnected();
        });
  }
}

class LifeCycleEventHandler extends WidgetsBindingObserver {
  final Function detachedCall;

  LifeCycleEventHandler({this.detachedCall});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await detachedCall();
        debugPrint("resumed");
        // TODO: Handle this case.
        break;
      case AppLifecycleState.inactive:
        debugPrint("inactive");
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.detached:
        await detachedCall();
        // TODO: Handle this case.
        break;
    }
  }
}
