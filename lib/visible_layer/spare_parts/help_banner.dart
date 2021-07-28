import 'package:flutter/material.dart';
import 'package:pandemicncovidtracker/data_layer/help_screen_info_data.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/internet_connected.dart';
import 'package:provider/provider.dart';

class HelpBanner extends StatefulWidget {
  @override
  _HelpBannerState createState() => _HelpBannerState();
}

class _HelpBannerState extends State<HelpBanner> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HelpScreenInfoData>(
      builder: (context, data, _) {
        if (data != null)
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _capsule(label: "Missions", value: data.missions),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _capsule(label: "Raised", value: data.raised),
                    _capsule(label: "Helped", value: data.served),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                _capsule(label: "Supporters", value: data.supporters),
              ],
            ),
          );
        return Container(
          child: InternetConnectedWidget(),
        );
      },
    );
  }

  Widget _capsule({String label, String value}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
                text: value,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0)),
          ),
        )
      ],
    );
  }
}
