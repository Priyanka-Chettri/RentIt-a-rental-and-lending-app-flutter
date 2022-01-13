
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:rentit/Screens/register_screen.dart';
import 'package:rentit/Screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class returnotpscreen extends StatefulWidget {
  const returnotpscreen({Key? key}) : super(key: key);

  @override
  _returnotpscreenState createState() => _returnotpscreenState();
}

class _returnotpscreenState extends State<returnotpscreen> {
  @override
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController userNameTextEditingController = new TextEditingController();
  final TextEditingController phoneNumberTextEditingController = new TextEditingController();
  final TextEditingController passwordTextEditingController = new TextEditingController();
  final TextEditingController confirmPasswordTextEditingController = new TextEditingController();
  final TextEditingController otpController = new TextEditingController();


  var isLoading = false;
  var isResend = false;
  var isRegister = true;
  var isOTPScreen = false;
  var verification_code = '';
  String name = '';
  String phone_number = '';
  String password = '';
  String confirm_password = '';
  bool ishiddenPassword = true;


  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        //  appBar: new AppBar(
        //    title: Text('OTP Screen'),
        //  ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          decoration: BoxDecoration(
              gradient:LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors:[
                    Colors.tealAccent.shade100,
                    Colors.tealAccent.shade400,
                    Colors.teal.shade400,
                    Colors.teal.shade800,

                  ]
              )
          ),
          child: ListView(children: [
            SizedBox(height: 40.h),
            Text(
              " OTP Verification",
              style: TextStyle(fontSize: 40.sp, color: Colors.white, fontWeight:FontWeight.w700, letterSpacing: 1.0.sp),),
            SizedBox(
              height: 60.h,
            ),
            Form(
              key: _formKeyOTP,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r),
                          bottomLeft: Radius.circular(25.r),
                          bottomRight:  Radius.circular(25.r),
                        ),
                        boxShadow: [
                          const BoxShadow(
                            offset: Offset(10, 10),
                            color: Colors.black38,
                            blurRadius: 20,
                          ),
                          BoxShadow(
                            offset: const Offset(-10, -10),
                            color: Colors.teal.shade300.withOpacity(0.85),
                            blurRadius: 20,
                          ),
                        ]),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      //padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),

                              child: Text(
                                  !isLoading
                                      ? "Enter OTP from SMS"
                                      : "Sending OTP code SMS",
                                  textAlign: TextAlign.center),),),
                          SizedBox(
                              height:20.h
                          ),
                          !isLoading
                              ? Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: TextFormField(
                                  enabled: !isLoading,
                                  controller: otpController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  initialValue: null,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      labelText: 'OTP',
                                      labelStyle: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:BorderSide(color:Colors.grey.shade500, width: 2.0.w),
                                      )),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter OTP';
                                    }
                                  },
                                ),
                              ))
                              : Container(),
                          !isLoading
                              ? Container(
                            margin: const EdgeInsets.only(top: 40, bottom: 5),
                            child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                                child: ElevatedButton.icon(
                                  label:const Icon(Icons.send,color: Colors.white),
                                  onPressed: () async {
                                   // if (_formKeyOTP.currentState!.validate()) {
                                      // If the form is valid, we want to show a loading Snackbar
                                      // If the form is valid, we want to do firebase signup...
                                     /* setState(() {
                                        isResend = false;
                                        isLoading = true;
                                      });*/

                                          if (verification_code==otpController.toString())
                                            {


                                            Navigator.pushNamed(context, '/home');

                                      }
                                          setState(() {
                                            isLoading = false;
                                            isResend = true;
                                          });
                                        setState(() {
                                          isLoading = true;
                                        });
                                      },
                                   // }
                                  //},
                                  /*child: new Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 15.0,

                                      )*/
                                  icon: Text(
                                    "Verify OTP",
                                    style: TextStyle(color: Colors.white, fontSize: 17.sp),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.teal,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.r))),
                                    side:  BorderSide(color: Colors.teal, width:2.5.w),
                                  ),
                                  //
                                  /*child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                            child: Text(
                                              "Submit",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),*/
                                  //  ),
                                )),
                          )
                              : SizedBox(
                            height: 40.h,
                          ),
                          Divider(
                            color: Colors.grey.shade500,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    CircularProgressIndicator(
                                      backgroundColor:
                                      Theme.of(context).primaryColor,
                                    )
                                  ].where((c) => c != null).toList(),
                                )
                              ]),
                          isResend
                              ? Container(
                              margin: EdgeInsets.only(top: 40, bottom: 5),
                              child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: ElevatedButton.icon(
                                    label:Icon(Icons.send,color: Colors.white),
                                    icon: Text(
                                      "Resend OTP",
                                      style: TextStyle(color: Colors.white, fontSize: 17.sp),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.teal,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.r))),
                                      side:  BorderSide(color: Colors.teal, width:2.5.w),
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        isResend = false;
                                        isLoading = true;
                                      });
                                     // await signUp();
                                    },
/*                                    child: new Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 15.0,

                                      ),
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Expanded(
                                            child: Text(
                                              "Resend Code",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),*/
                                  )))
                              : Column()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
