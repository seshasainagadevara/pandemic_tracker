import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CarouselShow extends StatefulWidget {
  final dynamic _corouselData;
  Function onTap;

  CarouselShow(this._corouselData, {this.onTap});

  @override
  _CarouselShowState createState() => _CarouselShowState();
}

class _CarouselShowState extends State<CarouselShow> {
//  int _a, _r, _g, _b;
  List<dynamic> _data;
  Function _onTap;

//  generate() => 87 + math.Random().nextInt(255 - 87) + 1;
//  _getRColor() {
//    _a = generate();
//    _r = generate();
//    _b = generate();
//    _g = generate();
//  }

  @override
  void initState() {
    _data = widget._corouselData;
    _onTap = widget.onTap;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Carousel(
      dotSize: 0.0,
      animationDuration: const Duration(milliseconds: 900),
      animationCurve: Curves.linearToEaseOut,
      indicatorBgPadding: 0.0,
      onImageTap: _onTap,
      dotBgColor: Colors.black38,
      images: _data.map((cData) {
//        _getRColor();
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
//              color: Color.fromARGB(_a, _r, _g, _b),
              color: Colors.white70,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15.0,
                ),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: cData.imageUrl,
                  imageScale: 3.0,
                  placeholderScale: 3.0,
                  height: 165.0,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
