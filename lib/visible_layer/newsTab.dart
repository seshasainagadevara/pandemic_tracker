import 'package:flutter/material.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/side_app_drawer.dart';

class NewsTab extends StatefulWidget {
  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text("Trends"),
        ),
        endDrawer: SideAppDrawer(),
      ),
    );
    ;
  }
}
