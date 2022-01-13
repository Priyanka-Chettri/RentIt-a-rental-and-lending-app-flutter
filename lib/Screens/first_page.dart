
// This is the first screen of the app with just login and signup button.

import 'package:flutter/material.dart';
import '../color.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:rentit/Screens/login_screen.dart';

void main() {
  runApp( MaterialApp(
    home: firstscreen(),
    debugShowCheckedModeBanner: false,
  ));
}
class firstscreen extends StatefulWidget {
  @override
  _firstscreenstate createState() => _firstscreenstate();
} //firstscreen

class _firstscreenstate extends State<firstscreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.themeColor,
                ),
                child: const Center(
                  child: Text(
                    "RentIt", //The Title
                    style: TextStyle(
                      fontFamily: 'AlfaSlabOne',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 60.0,
                    ), //Text style
                  ), //Text
                ), //Center
                height: (queryData.size.height / 2),
              ), //Conatiner
            ), //ClipPath
            const SizedBox(
              height: 50.0,
            ), //SizeBox
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Rent & Lend\nat your ease.",
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: AppColor.themeColor,
                    fontSize: 20.0,
                  ), //Text style
                ), //Text
              ), //Padding
            ), //Align
            const SizedBox(
              height: 50.0,
            ), //SizedBox
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 100, left: 20, right: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: AppColor.themeColor))),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      fixedSize: MaterialStateProperty.all<Size>(
                          Size((queryData.size.width) / 2 - 40, 50)),
                    ), //ButtonStyle
                    onPressed: () {
                      //TODO: Put navigation here
                      Navigator.pushNamed(context, '/loginScreen');
                     // print("Pressed!");
                    }, //OnPressed
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: AppColor.themeColor,
                        fontSize: 25.0,
                      ), //Text style
                    ), //Text
                  ), //ElevatedButton
                ), //Padding
                const SizedBox(
                  width: 20,
                ), //SizedBox
                Padding(
                  padding: EdgeInsets.only(top: 100, right: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: AppColor.themeColor))),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(AppColor.themeColor),
                      fixedSize: MaterialStateProperty.all<Size>(
                          Size((queryData.size.width / 2) - 40, 50)),
                    ), //ButtonStyle
                    onPressed: () {
                      //TODO: PUT navigation here
                      Navigator.pushNamed(context, '/register');

                      // print("SignUp Pressed!");
                    }, //onPressed
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Colors.white,
                        fontSize: 25.0,
                      ), //Text style
                    ), //Text
                  ), //ElevatedButton
                ), //Padding
              ],
            ), //Row
          ],
        ), //column
      ), //safeArea
    ); //Scaffold
  }
}

//The Clipper that clips the shape of the constructor
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 50);

    var oneStart = Offset(50, size.height);
    var oneEnd = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(oneStart.dx, oneStart.dy, oneEnd.dx, oneEnd.dy);

    path.lineTo(size.width / 2, size.height);
    var twoStart = Offset(size.width - 50, size.height);
    var twoEnd = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(twoStart.dx, twoStart.dy, twoEnd.dx, twoEnd.dy);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
