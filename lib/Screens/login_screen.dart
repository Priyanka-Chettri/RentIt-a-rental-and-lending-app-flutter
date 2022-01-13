
//This is the log in screen of the app

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
//import 'package:rentit/Screens/register_screen.dart';
import 'package:rentit/Screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/Screens/mainpage.dart';

import 'mainscreen.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key ?key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var verification_code = '';


  final TextEditingController numberController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController otpController = new TextEditingController();

  var isLoading = false;
  var isResend = false;
  var isLoginScreen = true;
  var isHomeScreen = false;
  var verificationCode = '';
  var isOtpScreen=false;
  var isRegister = true;
  String phone_number='';
  String password='';
  bool ishiddenPassword= true;

  //Form controllers
  /*@override
  void initState() {
    if (_auth.currentUser != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MainPage(),
        ),
            (route) => false,
      );
    }
    super.initState();
  }*/

 /* @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    numberController.dispose();
    super.dispose();
  }*/


  @override
  Widget build(BuildContext context) {
    return isOtpScreen ? returnOTPScreen() : returnLoginScreen();
  }

  Widget returnLoginScreen() {
    return Scaffold(
        key: _scaffoldKey,
      backgroundColor: Colors.teal,
      body: SafeArea(                                            // Safe Area: is used to ensure that the there is sufficient padding to avoid any kinds of intrusion
        child:LayoutBuilder(builder:(context, constraints)     /* Layoutbuilder: Child of safearea works similar to media query but it can determine the width and height of any widget it is used to make scrollable screen because
                                                                              singlechildscrollview cannot be used with the expanded widget. */
        {
          return  SingleChildScrollView(                     // Singlechildscrollview is used because the textfield gets hidden behind the keypad to avoid that this is used
            child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
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
                              height: 62.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(
                                    "Login ",
                                    style: TextStyle(fontSize: 44.sp, color: Colors.white, fontWeight:FontWeight.w700),),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Text(
                                    "Welcome Back ",
                                    style: TextStyle(fontSize: 20.sp, color: Colors.white,),),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),

                            Container(
                              height: 450.h, // This container widget is used to get the backdrop like design in the login page
                              child: Padding(
                                padding: const EdgeInsets.all(20),

                                child: Container(
                                 // height:450.h,

                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:  BorderRadius.only(
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
                                            color: Colors.teal.shade300.withOpacity(0.85),
                                            blurRadius: 20,
                                          ),
                                        ]),
                                    child: Padding (                                     // The expanded widget will have  all the textfield and buttons so they are put in a padding widget to get space
                                        padding:  EdgeInsets.symmetric(horizontal: 20.w),
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 54.h,
                                                ),
                                                Container(                              // This container contains the text field, textfield(phonenumber) is put inside the container inorder to design the texfield
                                                    padding:  EdgeInsets.symmetric(vertical: 3.h),
                                                    margin:   EdgeInsets.symmetric(horizontal: 8.w),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(50.r),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color.fromRGBO(0, 128, 128, .3),
                                                            blurRadius: 20,
                                                            offset: Offset(0, 10),
                                                          )
                                                        ]
                                                    ),
                                                    child: TextFormField(
                                                      controller: numberController,
                                                      validator: (val)=> (val!.length>10 || val!.length<10)?'Phone Number should be 10 digits long' :null,
                                                      onChanged: (val) {
                                                        setState(() =>
                                                        phone_number = val);
                                                      },
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          focusedBorder: InputBorder.none,
                                                          enabledBorder: InputBorder.none,
                                                          disabledBorder: InputBorder.none,
                                                          hintText: "Phone Number",
                                                          prefixIcon: const Icon(Icons.phone, color: Colors.teal),
                                                          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp,
                                                            fontWeight: FontWeight.w400,),
                                                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h)
                                                      ),
                                                    )
                                                ),
                                                SizedBox(
                                                  height: 18.h,
                                                ),
                                                Container(                                    // This container contains the text field, textfield(password) is put inside the container inorder to design the texfield
                                                    padding: EdgeInsets.symmetric(vertical:3.h),
                                                    margin:  EdgeInsets.symmetric(horizontal: 8.w),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(50.r),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color.fromRGBO(0, 128, 128, .3),
                                                            blurRadius: 20,
                                                            offset: Offset(0, 10),
                                                          )
                                                        ]
                                                    ),
                                                    child: TextFormField(
                                                      controller: passwordController,
                                                      validator: (val)=> (val!.length<6 || val!.length>18 )?'Password should be 6-18 characters long' :null,

                                                      onChanged: (val){
                                                        setState(()=> password=val);
                                                      },
                                                      obscureText: ishiddenPassword,
                                                      enableSuggestions: false,
                                                      autocorrect: false,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        focusedBorder: InputBorder.none,
                                                        enabledBorder: InputBorder.none,
                                                        disabledBorder: InputBorder.none,
                                                        hintText: "Password",
                                                        prefixIcon: const Icon(Icons.security, color: Colors.teal),
                                                        suffixIcon: InkWell(
                                                          onTap: _togglePassword,
                                                          child:  Icon(
                                                            !ishiddenPassword ?(Icons.visibility):(Icons.visibility_off),
                                                            //color: Colors.teal
                                                          ),
                                                        ),
                                                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.sp,
                                                          fontWeight: FontWeight.w400,),
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                                                      ),
                                                    )
                                                ),
                                                SizedBox(
                                                    height: 12.h
                                                ),

                                              //Forgot Password

                                               /* Padding(
                                                  padding:EdgeInsets.symmetric(horizontal: 20.w),
                                                  child: SizedBox(                                           //The forgot password text is put inside a container to provide margin to it and also it provides ontap gesture property
                                                      child: RichText(
                                                        text: TextSpan(
                                                            text:'Forgot Password?',
                                                            style:  TextStyle(color: Colors. teal, fontSize: 13.sp),
                                                            recognizer: TapGestureRecognizer()
                                                            //TODO
                                                              ..onTap= () => print('click')    // For now it is click one can connect the screen the forget password will take
                                                        ),
                                                      )
                                                  ),
                                                ),*/
                                                SizedBox(
                                                  height: 38.h,
                                                ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                                                      child: SizedBox(
                                                        width: 180.w,
                                                        height: 46.h,
                                                        child: ElevatedButton(
                                                          child:  Text(
                                                            "Login",
                                                            style: TextStyle(color: Colors.teal, fontSize: 17.sp),
                                                          ),
                                                          style: ElevatedButton.styleFrom(
                                                           // minimumSize: (100,40.0),
                                                            primary: Colors.white,
                                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                            side:  BorderSide(color: Colors.teal, width:2.5.w),
                                                          ),
                                                          //TODO
                                                          onPressed: ()async{
                                                            if(_formKey.currentState!.validate())
                                                            {
                                                             // print(phone_number);
                                                             // print(password);
                                                              await login();


                                                            }

                                                          },
                                                        ),
                                                      ),
                                                    ),


                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Divider(
                                                        color: Colors.teal.shade50,
                                                        thickness:2.0,

                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:4.w,
                                                    ),
                                                    Text(
                                                      "or",
                                                      style: TextStyle(color: Colors.teal, fontSize: 14.sp),
                                                    ),
                                                    SizedBox(
                                                      width: 4.w,
                                                    ),
                                                    Expanded(
                                                      child: Divider(
                                                        color: Colors.teal.shade50,
                                                        thickness:2.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 25.h,
                                                ),
                                                   Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                                                    child: SizedBox(
                                                      width:250.w,
                                                      height:46.h,
                                                      child: ElevatedButton(
                                                        child:  Text(
                                                          " Login with OTP",
                                                          style: TextStyle(color: Colors.teal,fontSize: 17.sp),
                                                        ),
                                                        style: ElevatedButton.styleFrom(
                                                          primary: Colors.white,
                                                          shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.r))),
                                                          side:  BorderSide(color: Colors.teal,width:2.5.w),

                                                        ),
                                                        //TODO
                                                        onPressed: () async{
                                                          if(phone_number.length==0)
                                                            {
                                                             displaySnackBar("Please enter phone number to receive OTP") ;
                                                            }
                                                          else {
                                                            await LoginwthOtp();
                                                          }



                                                        },
                                                      ),
                                                    ),
                                                  ),

                                              ]

                                          ),
                                        )
                                    )
                                ),
                              ),
                            ),
                          ] ),
                    )
                )
            ),
          );
        }),
      ),
       );
  }




  Future login() async {
/*   setState(() {
      isLoading = true;
    });*/
    var phoneNumber = '+91 ' + numberController.text.trim();
    var password= passwordController.text.trim();

    //first we will check if a user with this cell number exists
    var isValidUser = false;
    var number = numberController.text.trim();

     await _firestore     // This will check if the users phone number exists.
        .collection('users')
        .where('cellnumber', isEqualTo: number)
        .get()
        .then((result) {
      if (result.docs.length > 0) {
        isValidUser = true;
      }
        }
        );

     // if the users phone number exists we need to again check for that phone number if the given password exists, it moves to the main page
    if(isValidUser) {
        //ok, we have a valid user, now lets do otp verification
        var verifyPhoneNumber = _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (phoneAuthCredential) {
            //auto code complete (not manually)
            _auth.signInWithCredential(phoneAuthCredential).then((user) async =>
            {
              if (user != null)
                {
                  //redirect
                  await _firestore
                      .collection('users')
                      .where('cellnumber', isEqualTo: number)
                      .get()
                      .then((result) {
                    if (result.docs.isNotEmpty) {
                      var doc_data = result.docs.single.data();
                      // debugPrint(_auth.currentUser!.uid);
                      if (password == doc_data['password']) {
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          setState(() {
                            isLoading = false;
                            isOtpScreen = false;
                          },);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => MainPage(),
                            ),
                                (route) => false,
                          );
                        });
                      }

                      // if the password doesn't exists a snackbar is displayed
                      else {
                        displaySnackBar("Password is wrong");
                      }
                    }
                  })
                }});
          },

    verificationFailed: (FirebaseAuthException error) {
    displaySnackBar('Validation error, please try again later');
    setState(() {
    isLoading = false;
    });},

    codeSent: (verificationId, [forceResendingToken]) {
    setState(() {
    isLoading = false;
    verificationCode = verificationId;
    isOtpScreen = true;
    });
    },
    codeAutoRetrievalTimeout: (String verificationId) {
    setState(() {
    isLoading = false;
    verificationCode = verificationId;
    });
    },
    timeout: Duration(seconds: 60),
    );
    await verifyPhoneNumber;
    }
      else {
        //non valid user
        setState(() {
          isLoading = false;
        });
        displaySnackBar('Number not found, please sign up first');
      }
    }


 // this method takes  string and displays it in the form of a snackbar
  displaySnackBar(text) {
    final snackBar = SnackBar(content: Text(text));
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  // This returns otp screen
  Widget returnOTPScreen() {
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
                            margin: EdgeInsets.only(top: 40, bottom: 5),
                            child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                                child:  ElevatedButton.icon(
                                  label:Icon(Icons.send,color: Colors.white),
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
    verificationCode,
    smsCode: otpController.text
        .toString()))
        .then((user) async =>
        {
          //sign in was success
          if (user != null)
            {
              //store registration details in firestore database
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
        .catchError((error) => {
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
                                      await LoginwthOtp();
                                    },
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


// This function takes the number and generates the OTP
  Future LoginwthOtp() async {
    setState(() {
      isLoading = true;
    });

    var phoneNumber = '+91 ' + numberController.text.trim();

    //first we will check if a user with this cell number exists
    var isValidUser = false;
    var number = numberController.text.trim();

    await _firestore
        .collection('users')
        .where('cellnumber', isEqualTo: number)
        .get()
        .then((result) {
      if (result.docs.length > 0) {
        isValidUser = true;
      }
    });

    if (isValidUser) {
      //ok, we have a valid user, now lets do ;otp verification
      print("User exists");
      var verifyPhoneNumber = _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          //auto code complete (not manually)
          _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
            if (user != null)
              {
                //redirect
                setState(() {
                  isLoading = false;
                  isOtpScreen = false;
                }),
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MainScreen(),
                  ),
                      (route) => false,
                )
              }
          });
        },
        verificationFailed: (FirebaseAuthException error) {
          displaySnackBar('Validation error, please try again later');
          setState(() {
            isLoading = false;
          });
        },
        codeSent: (verificationId, [forceResendingToken]) {
          setState(() {
            isLoading = false;
            verificationCode = verificationId;
            isOtpScreen= true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            isLoading = false;
            verificationCode = verificationId;
          });
        },
        timeout: Duration(seconds: 60),
      );
      await verifyPhoneNumber;
    } else {
      //non valid user
      setState(() {
        isLoading = false;
      });
      displaySnackBar('Number not found, please sign up first');
    }
  }




void _togglePassword()
  {
    if(ishiddenPassword==true)
    {
      ishiddenPassword=false;
    }else{
      ishiddenPassword=true;
    }

  }
}


