import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
//import 'package:phone_verification/loggedInScreen.dart';
import 'package:rentit/Screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/Screens/mainscreen.dart';
import 'package:rentit/Screens/mainpage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegisterScreen extends StatefulWidget {
   RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();                    //Returns the form state for validation
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController userNameTextEditingController = TextEditingController();
  final TextEditingController phoneNumberTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController =  TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =  TextEditingController();
  final TextEditingController otpController =  TextEditingController();


  var isLoading = false;
  var isResend = false;
  var isRegister = true;
  var isOTPScreen = false;
  var verification_code = '';
  String name = '';
  String phone_number = '';
  String password = '';
  String confirm_password = '';
  bool ishiddenPassword1 = true;
  bool ishiddenPassword2= true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    // Clean up the controller when the Widget is disposed
    userNameTextEditingController.dispose();
    phoneNumberTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isOTPScreen ? returnOTPScreen() : registerScreen();
  }

  Widget registerScreen() {

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea( // Safe Area: is used to ensure that the there is sufficient padding to avoid any kinds of intrusion
        child: LayoutBuilder(builder: (context, constraints) /* Layoutbuilder: Child of safearea works similar to media query but it can determine the width and height of any widget it is used to make scrollable screen because
                                                                              singlechildscrollview cannot be used with the expanded widget. */ {
          return SingleChildScrollView( // Singlechildscrollview is used because the textfield gets hidden behind the keypad to avoid that this is used
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.tealAccent.shade100,
                                Colors.tealAccent.shade400,
                                Colors.teal.shade400,
                                Colors.teal.shade800,

                              ]
                          )
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 52.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(fontSize: 44.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.0.sp),),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Text(
                                    "Create a new account",
                                    style: TextStyle(
                                      fontSize: 22.sp, color: Colors.white,),),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            Expanded(
                              // This expanded widget is used to get the backdrop like design in the login page
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.r),
                                          topRight: Radius.circular(25.r),
                                          bottomLeft: Radius.circular(25.r),
                                          bottomRight: Radius.circular(25.r),
                                        ),
                                        boxShadow: [
                                          const BoxShadow(
                                            offset: Offset(10, 10),
                                            color: Colors.black38,
                                            blurRadius: 20,
                                          ),
                                          BoxShadow(
                                            offset: const Offset(-10, -10),
                                            color: Colors.teal.shade300
                                                .withOpacity(0.85),
                                            blurRadius: 20,
                                          ),
                                        ]),
                                    child: Padding( // The expanded widget will have  all the textfield and buttons so they are put in a padding widget to get space
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                SizedBox(
                                                  height: 52.h,
                                                ),
                                                Container( // This container contains the text field, textfield(phonenumber) is put inside the container inorder to design the texfield
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 3.h),
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.w),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius
                                                            .circular(50.r),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color
                                                                .fromRGBO(
                                                                0, 128, 128,
                                                                .3),
                                                            blurRadius: 20,
                                                            offset: Offset(
                                                                0, 10),
                                                          )
                                                        ]
                                                    ),
                                                    child: TextFormField(
                                                      controller: userNameTextEditingController,
                                                      validator: (val) =>
                                                      (val!.length == 0)
                                                          ? 'Enter your name'
                                                          : null,
                                                      onChanged: (val) {
                                                        setState(() =>
                                                        name = val);
                                                      },
                                                      decoration: InputDecoration(
                                                          border: InputBorder
                                                              .none,
                                                          focusedBorder: InputBorder
                                                              .none,
                                                          enabledBorder: InputBorder
                                                              .none,
                                                          disabledBorder: InputBorder
                                                              .none,
                                                          hintText: "Name",
                                                          prefixIcon: const Icon(
                                                              Icons.person,
                                                              color: Colors
                                                                  .teal),
                                                          hintStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight
                                                                .w400,),
                                                          contentPadding: EdgeInsets
                                                              .symmetric(
                                                              horizontal: 16.w,
                                                              vertical: 14.h)
                                                      ),
                                                    )
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                Container( // This container contains the text field, textfield(password) is put inside the container inorder to design the texfield
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 3.h),
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.w),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius
                                                            .circular(50.r),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color
                                                                .fromRGBO(
                                                                0, 128, 128,
                                                                .3),
                                                            blurRadius: 20,
                                                            offset: Offset(
                                                                0, 10),
                                                          )
                                                        ]
                                                    ),
                                                    child: TextFormField(
                                                      controller: phoneNumberTextEditingController,
                                                      validator: (val) =>
                                                      (val!.length > 10 ||
                                                          val!.length < 10)
                                                          ? 'Phone Number should be 10 digits long'
                                                          : null,
                                                      onChanged: (val) {
                                                        setState(() =>
                                                        phone_number = val);
                                                      },
                                                      keyboardType: TextInputType
                                                          .number,
                                                      enableSuggestions: false,
                                                      autocorrect: false,
                                                      decoration: InputDecoration(
                                                        border: InputBorder
                                                            .none,
                                                        focusedBorder: InputBorder
                                                            .none,
                                                        enabledBorder: InputBorder
                                                            .none,
                                                        disabledBorder: InputBorder
                                                            .none,
                                                        hintText: "Phone Number",
                                                        prefixIcon: const Icon(
                                                            Icons.phone,
                                                            color: Colors.teal),
                                                        hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight
                                                              .w400,),
                                                        contentPadding: EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16.w,
                                                            vertical: 14.h),
                                                      ),
                                                    )
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),

                                                Container( // This container contains the text field, textfield(phonenumber) is put inside the container inorder to design the texfield
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 3.h),
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.w),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius
                                                            .circular(50.r),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color
                                                                .fromRGBO(
                                                                0, 128, 128,
                                                                .3),
                                                            blurRadius: 20,
                                                            offset: Offset(
                                                                0, 10),
                                                          )
                                                        ]
                                                    ),
                                                    child: TextFormField(
                                                      validator: (val) =>
                                                      (val!.length < 6 ||
                                                          val!.length > 18)
                                                          ? 'Password should be 6-18 characters long'
                                                          : null,
                                                      onChanged: (val) {
                                                        setState(() =>
                                                        password = val);
                                                      },
                                                      controller: passwordTextEditingController,
                                                      obscureText: ishiddenPassword1,
                                                      decoration: InputDecoration(
                                                          border: InputBorder
                                                              .none,
                                                          focusedBorder: InputBorder
                                                              .none,
                                                          enabledBorder: InputBorder
                                                              .none,
                                                          disabledBorder: InputBorder
                                                              .none,
                                                          hintText: "Password",
                                                          prefixIcon: const Icon(
                                                              Icons.security,
                                                              color: Colors
                                                                  .teal),
                                                          suffixIcon: InkWell(
                                                            onTap: _togglePassword1,
                                                            child: Icon(
                                                              !ishiddenPassword1
                                                                  ? (Icons
                                                                  .visibility)
                                                                  : (Icons
                                                                  .visibility_off),
                                                              //color: Colors.teal
                                                            ),
                                                          ),
                                                          hintStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight
                                                                .w400,),
                                                          contentPadding: EdgeInsets
                                                              .symmetric(
                                                              horizontal: 16.w,
                                                              vertical: 14.h)
                                                      ),
                                                    )
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                Container( // This container contains the text field, textfield(phonenumber) is put inside the container inorder to design the texfield
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 3.h),
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.w),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius
                                                            .circular(50.r),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color
                                                                .fromRGBO(
                                                                0, 128, 128,
                                                                .3),
                                                            blurRadius: 20,
                                                            offset: Offset(
                                                                0, 10),
                                                          )
                                                        ]
                                                    ),
                                                    child: TextFormField(
                                                      //controller: confirmPasswordTextEditingController,
                                                      validator: (val) {
                                                        if (val!.length < 6 ||
                                                            val!.length > 18) {
                                                          return 'Password should be 6-18 characters long';
                                                        }
                                                        if (val !=
                                                            passwordTextEditingController
                                                                .text) {
                                                          return 'Password not matched';
                                                        }

                                                        return null;
                                                      },
                                                      onChanged: (val) {
                                                        setState(() =>
                                                        confirm_password = val);
                                                      },
                                                      obscureText: ishiddenPassword2,
                                                      decoration: InputDecoration(
                                                          border: InputBorder
                                                              .none,
                                                          focusedBorder: InputBorder
                                                              .none,
                                                          enabledBorder: InputBorder
                                                              .none,
                                                          disabledBorder: InputBorder
                                                              .none,
                                                          hintText: " Confirm Password",
                                                          prefixIcon: const Icon(
                                                              Icons.spellcheck,
                                                              color: Colors
                                                                  .teal),
                                                          suffixIcon: InkWell(
                                                            onTap: _togglePassword2,
                                                            child: Icon(
                                                              !ishiddenPassword2
                                                                  ? (Icons
                                                                  .visibility)
                                                                  : (Icons
                                                                  .visibility_off),
                                                              //color: Colors.teal
                                                            ),
                                                          ),
                                                          hintStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight
                                                                .w400,),
                                                          contentPadding: EdgeInsets
                                                              .symmetric(
                                                              horizontal: 16.w,
                                                              vertical: 14.h)
                                                      ),
                                                    )
                                                ),


                                                SizedBox(
                                                  height: 38.h,
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 25.w),
                                                  child: Align(
                                                    alignment: Alignment
                                                        .bottomRight,
                                                    child: SizedBox(
                                                      width: 145.w,
                                                      height: 46.h,
                                                      child: ElevatedButton
                                                          .icon(
                                                        label: const Icon(Icons
                                                            .arrow_forward_ios,
                                                            color: Colors
                                                                .white),
                                                        icon: Text(
                                                          "Sign Up",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 17.sp),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: Colors.teal,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  10.r))),
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .teal,
                                                              width: 2.5.w),
                                                        ),
                                                        //TODO
                                                        onPressed: () async {
                                                        if (!isLoading) {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              // If the form is valid, we want to show a loading Snackbar
                                                              setState(()  {
                                                               /* await _firestore     // This will check if the users phone number exists.
                                                                    .collection('users')
                                                                    .where('cellnumber', isEqualTo:phoneNumberTextEditingController.text.toString())
                                                                    .get()
                                                                    .then((result) {
                                                                  if (result.docs.length > 0) {displaySnackBar("User already signed in");
                                                                  }
                                                                }
                                                                )*///;
                                                                signUp();
                                                                isRegister =
                                                                false;
                                                                isOTPScreen =
                                                                true;
                                                              });

                                                              // Navigator.pushNamed(context, '/otp');
                                                            }

                                                            // Navigator.pushNamed(context, '/otp');

                                                         }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //  ),
                                                SizedBox(
                                                  height: 90.h,
                                                ),
                                              ]

                                          ),
                                        )
                                    )
                                ),

                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                          ])
                  ),


                ),
              ));
        }),
      ),
    );
  }




  Widget returnOTPScreen() {
    return Scaffold(
        key: _scaffoldKey,
      //  appBar: new AppBar(
      //    title: Text('OTP Screen'),
      //  ),
        body: Container(
          //height:500.h,
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
              child: Container(
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
                                      if (_formKeyOTP.currentState!.validate()) {
                                        // If the form is valid, we want to show a loading Snackbar
                                        // If the form is valid, we want to do firebase signup...
                                        setState(() {
                                          isResend = false;
                                          isLoading = true;
                                        });
                                        try {
                                          await _auth
                                              .signInWithCredential(
                                              PhoneAuthProvider.credential(
                                                  verificationId:
                                                  verification_code,
                                                  smsCode: otpController.text
                                                      .toString()))
                                              .then((user) async => {
                                            //sign in was success
                                            if (user != null)
                                              {
                                                //store registration details in firestore database
                                                await _firestore
                                                    .collection('users')
                                                    .doc(
                                                    _auth.currentUser!.uid)
                                                    .set(
                                                    {
                                                      'name': userNameTextEditingController
                                                          .text
                                                          .trim(),
                                                      'cellnumber':phoneNumberTextEditingController
                                                          .text
                                                          .trim(),
                                                      'password': passwordTextEditingController.text.trim(),
                                                      'profile_picture':" "
                                                    },
                                                    SetOptions(
                                                        merge:
                                                        true)).then(
                                                        (value) => {
                                                      //then move to authorised area
                                                      setState(() {
                                                        isLoading =
                                                        false;
                                                        isResend =
                                                        false;
                                                      })
                                                    }),

                                                setState(() {
                                                  isLoading = false;
                                                  isResend = false;
                                                }),
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                    context) =>
                                                        MainPage(),
                                                  ),
                                                      (route) => false,
                                                )
                                              }
                                          })
                                              .catchError((error) =>{
                                            setState(() {
                                              isLoading = false;
                                              isResend = true;
                                            }),
                                          });
                                          setState(() {
                                            isLoading = true;
                                          });
                                        } catch (e) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      }
                                    },
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
                                  child:  ElevatedButton.icon(
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
                                      await signUp();
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
  displaySnackBar(text) {
    final snackBar = SnackBar(content: Text(text));
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  Future signUp() async {
   setState(() {
      isLoading = true;
    });
    debugPrint('test 1');
    var phonenumber = '+91 ' + phoneNumberTextEditingController.text.toString();
    debugPrint(' test 2');
    var verifyPhoneNumber = _auth.verifyPhoneNumber(
      phoneNumber: phonenumber,
      verificationCompleted: (phoneAuthCredential) {
        debugPrint(' test 3');
        //auto code complete (not manually)
       /* _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
          
          if (user != null)
            {
              //store registration details in firestore database
              await _firestore
                  .collection('users')
                  .doc(_auth.currentUser!.uid)
                  .set({
                'name': userNameTextEditingController.text.trim(),
                'cellnumber': phoneNumberTextEditingController.text.trim(),
                'password': passwordTextEditingController.text.trim(),
                'profile_picture': " ",

              }, SetOptions(merge: true))
                  .then((value) => {
                //then move to authorised area
                setState(() {
                  isLoading = false;
                  isRegister = false;
                  isOTPScreen = false;

                  //navigate
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MainPage(),
                    ),
                        (route) => false,
                  );
                })
              })
                  .catchError((onError) => {
                debugPrint(
                    'Error saving user to db.' + onError.toString())
              })
            }
        });*/

        debugPrint('test 4');
      },
      verificationFailed: (FirebaseAuthException error) {
        debugPrint('test 5' + error.message!);
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (verificationId, [forceResendingToken]) {
        debugPrint('test 6');
        setState(() {
          isLoading = false;
          verification_code = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint('test 7');
        setState(() {
          isLoading = false;
          verification_code = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
    debugPrint(' test 7');
    await verifyPhoneNumber;
    debugPrint(' test 8');
  }

  void _togglePassword1() {
    if (ishiddenPassword1 == true) {
      ishiddenPassword1 = false;
    } else {
      ishiddenPassword1 = true;
    }
    setState(() {});
  }
  void _togglePassword2() {
    if (ishiddenPassword2 == true) {
      ishiddenPassword2 = false;
    } else {
      ishiddenPassword2 = true;
    }
    setState(() {});
  }
}

