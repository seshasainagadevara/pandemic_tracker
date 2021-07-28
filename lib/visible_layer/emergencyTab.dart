import 'package:flutter/material.dart';
import 'package:pandemicncovidtracker/data_control_layer/help_controller.dart';
import 'package:pandemicncovidtracker/data_layer/help_screen_carousel.dart';
import 'package:pandemicncovidtracker/data_layer/help_screen_info_data.dart';
import 'package:pandemicncovidtracker/data_layer/mission_data.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/carousel_show.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/help_banner.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/internet_connected.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/mission_tile.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class EmergencyTab extends StatefulWidget {
  @override
  _EmergencyTabState createState() => _EmergencyTabState();
}

class _EmergencyTabState extends State<EmergencyTab> {
  HelpController _helpController;

  @override
  void initState() {
    _helpController = HelpController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<HelpScreenInfoData>(
          create: (context) => _helpController.helpBannerStream,
        ),
        StreamProvider<List<HelpScreenCarouselData>>(
            create: (context) => _helpController.helpCarouselStream),
        StreamProvider<List<MissionData>>(
          create: (BuildContext context) => _helpController.missionStream,
        ),
      ],
      child: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black87,
              expandedHeight: 250.0,
              brightness: Brightness.dark,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      text: "Let's help them !",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800,
                      )),
                ),
                background: HelpBanner(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                _headings(
                  textSpan: TextSpan(
                    text: "Become a warrior !",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w800,
                        fontSize: 30.0),
                  ),
                ),
                _headings(
                  textSpan: TextSpan(
                    text:
                        "\"Support people, Care animals. Support us to help needy.\"",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w800,
                        fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 200.0,
                    child: Consumer<List<HelpScreenCarouselData>>(
                      builder: (context, data, _) {
                        if (data == null)
                          return Container(
                            color: Colors.white70,
                          );
                        return CarouselShow(data, onTap: null);
                      },
                    ),
                  ),
                ),
                _headings(
                  textSpan: TextSpan(
                    text: "Missions",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Stack(children: [
                    Container(
                      margin: EdgeInsets.only(left: 135.0),
                      padding: EdgeInsets.all(15.0),
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                text:
                                    "\"Donate food/clothes/anything, we'll collect and serve them to needy\"",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            height: 20.0,
                            child: FlatButton(
                              color: Colors.green[600],
                              textColor: Colors.white,
                              onPressed: () {},
                              child: Text(
                                "Donate now",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Consumer<HelpScreenInfoData>(
                        builder: (BuildContext context,
                            HelpScreenInfoData value, _) {
                          if (value == null) return InternetConnectedWidget();
                          return FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: value.donationPic,
                            height: 100,
                            width: 150,
                            fit: BoxFit.scaleDown,
                          );
                        },
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Consumer<List<MissionData>>(
                    builder:
                        (BuildContext context, List<MissionData> value, _) {
                      if (value == null)
                        return Center(child: CircularProgressIndicator());
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:
                              value.map((e) => MissionTile(data: e)).toList());
                    },
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headings({TextSpan textSpan}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: RichText(textAlign: TextAlign.left, text: textSpan),
      ),
    );
  }
}
