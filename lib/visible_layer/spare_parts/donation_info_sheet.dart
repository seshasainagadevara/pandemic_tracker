import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonationBottomSheet extends StatefulWidget {
  @override
  _DonationBottomSheetState createState() => _DonationBottomSheetState();
}

class _DonationBottomSheetState extends State<DonationBottomSheet> {
  TextEditingController _name, _mobile, _country, _email, _city;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _name = TextEditingController();
    _city = TextEditingController();
    _country = TextEditingController();
    _email = TextEditingController();
    _mobile = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(colors: [
                    Colors.deepPurple,
                    Colors.purpleAccent,
                    Colors.purpleAccent,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset.fromDirection(-180, 1),
                      blurRadius: 5.0,
                      spreadRadius: 0.1,
                    )
                  ]),
              child: Text(
                "Thank you for supporting us",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Please fill these details",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          textField(context, _name, TextInputType.text, "Name"),
          textField(context, _mobile, TextInputType.phone, "Mobile"),
          textField(context, _city, TextInputType.text, "City"),
          textField(context, _country, TextInputType.text, "Country"),
          textField(context, _email, TextInputType.emailAddress, "Email"),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: RaisedButton(
              onPressed: () {
                final form = _formKey.currentState;
                if (form.validate()) {}
              },
              child: Text("Proceed"),
              textColor: Colors.white,
              color: Colors.deepPurple,
              elevation: 8.0,
              highlightElevation: 2.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget textField(
    BuildContext context,
    TextEditingController controller,
    dynamic inputType,
    String name,
  ) {
    return Container(
        height: 50.0,
        //padding: EdgeInsets.symmetric(horizontal: 15.0, ),
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Theme(
          data: ThemeData(primaryColor: Colors.deepPurple[700]),
          child: TextFormField(
            cursorColor: Colors.deepPurple[300],
            keyboardType: inputType,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
            controller: controller,
            validator: (String entry) {
              return entry.isEmpty ? "Enter $name" : null;
            },
            decoration: InputDecoration(
              labelText: "$name",
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 10.0),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ));
  }
}
