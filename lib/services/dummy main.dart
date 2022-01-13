import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/Screens/home_screen.dart';
import 'package:rentit/Screens/register_screen.dart';
import 'package:rentit/services/auth.dart';
//import 'package:rentit/otp_page.dart';
import 'package:rentit/Screens/first_page.dart';
//import 'package:rentit/services/wrapper.dart';
import 'package:provider/provider.dart';
//import 'package:rentit/services/auth.dart';
//import 'package:rentit/services/users.dart';
import 'package:rentit/Screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rentit/Screens/login_screen.dart';
import 'package:rentit/Screens/otp_screen.dart';

void main () async {
  // @dart=2.9
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ScreenUtilInit(
      builder: () =>
          MultiProvider(
            providers: [
              Provider<AuthService>(
                create: (_) => AuthService(),
              ),
            ],
            child: MaterialApp(
              //home:Wrapper(),
              //initialRoute: '/firstscreen',
              routes: {
                '/': (context) => firstscreen(),
                // '/': (context) => Wrapper(),
                '/loginScreen': (context) => LoginScreen(),
                //'/signup': (context) => SignUp(),
                //'/otp': (context) => Otp(),
                '/home': (context) => HomeScreen(),
                '/register':(context)=>RegisterScreen(),
                '/retootp':(context)=>returnotpscreen(),

              },
              debugShowCheckedModeBanner: false,
            ),
          ),

      designSize: const Size(360, 640),
    ),
  );
}



