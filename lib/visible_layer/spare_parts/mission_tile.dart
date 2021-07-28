import 'package:flutter/material.dart';
import 'package:pandemicncovidtracker/data_layer/mission_data.dart';
import 'package:pandemicncovidtracker/visible_layer/spare_parts/donation_info_sheet.dart';
import 'package:transparent_image/transparent_image.dart';

class MissionTile extends StatefulWidget {
  final MissionData data;

  const MissionTile({this.data});

  @override
  _MissionTileState createState() => _MissionTileState();
}

class _MissionTileState extends State<MissionTile> {
  MissionData _data;
  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        height: 200.0,
        width: MediaQuery.of(context).size.width,
        //padding: EdgeInsets.all(8.0),
        foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
          colors: <Color>[
            Colors.black54,
            Colors.black54,
            Colors.black54,
            Colors.black54,
            Colors.orangeAccent[700],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: _data.picUrl,
          imageScale: 3.0,
          placeholderScale: 3.0,
          fit: BoxFit.fill,
        ),
      ),
      Container(
        height: 200.0,
        padding: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                    text: _data.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 25.0,
                    )),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () async {
                  await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(20.0),
                          height: MediaQuery.of(context).size.height / 2.0,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                  text: _data.desc,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0,
                                  )),
                            ),
                          ),
                        );
                      });
                },
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      text: "Know more",
                      style: TextStyle(
                        color: Colors.orange[500],
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.underline,
                        fontSize: 14.0,
                      )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.call_made,
                          size: 15.0,
                          color: Colors.green[400],
                        ),
                        Text("Supporters",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w800,
                              fontSize: 12.0,
                            )),
                      ],
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: _data.supporters,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 10.0,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 35.0,
              child: RaisedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                              child: DonationBottomSheet()),
                        );
                      });
                },
                elevation: 5.0,
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage(
                        "images/help.png",
                      ),
                      fit: BoxFit.scaleDown,
                    ),
                    Text(
                      "Support this mission",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.indigo),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
