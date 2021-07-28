import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InternetDisconnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black54,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Container(
            height: (MediaQuery.of(context).size.height / 2.0) - 100.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black, spreadRadius: 0.1, blurRadius: 2.0)
              ],
              // border: Border.all(color: Colors.red, width: 5.0),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage("images/no_wifi.png")),
                Text(
                  "No internet connection !",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
