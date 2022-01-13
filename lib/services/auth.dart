
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import'package:rentit/services/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentit/Screens/first_page.dart';


class  AuthService{

  final FirebaseAuth _firebaseauth= FirebaseAuth.instance;
  final FirebaseFirestore _firebasefirestore= FirebaseFirestore.instance;
  //get verification_code->null;

  static String verification_code='';

  //creates a user object based on firebase
  Users? _userFromFireBase(User? user)
  {
    if (user!=null) {
      return Users(uid:user.uid);
    } else {
      return null;
    }
  }
  // Listen to authenticate changes
  Stream<Users?>? get user{
    return _firebaseauth.authStateChanges().map(_userFromFireBase) ;
  }

  //Sign Up
  Future signUp(String PhoneNumber, String Name, String Password, BuildContext context ) async
  {
    var phoneNumber='+91'+ PhoneNumber.trim();
    var verifyPhonenumber= _firebaseauth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential){
          _firebaseauth.signInWithCredential(credential).then((user) async=>{
            if(user!=null)
              {
                //logged in

                await _firebasefirestore.collection('users').doc(_firebaseauth.currentUser!.uid)
                    .set(
                    {
                      'Username': Name.trim(),
                      'Phone_Number': PhoneNumber.trim(),
                      'User_Password': Password.trim(),
                    }, SetOptions(merge:true)
                )
              }
          });
        },
        verificationFailed: (FirebaseAuthException error){
          debugPrint('Error Logging in: '+error.message!);
        },
        codeSent: await  (String verificationID, [int ?forceResendingtoken]) {

          showSnackbar(context, 'Verification code sent on the phone number');
          verification_code =verificationID;
        },
        codeAutoRetrievalTimeout: await (String verificationID){
          verification_code= verificationID;
          showSnackbar( context,"Time out");
        }, timeout: Duration(seconds: 60));


// Verfiy Phone Number in Registration Screen
/*
Future <void> verifyphonenumber(String phoneNumber, BuildContext context) async{
    PhoneVerificationCompleted verificationCompleted =await (PhoneAuthCredential credential)async{
      showSnackbar(context, 'Verification Completed');
    };
    PhoneVerificationFailed  verificationFailed=await (FirebaseAuthException exception){
      showSnackbar( context, exception.toString());

    };
    PhoneCodeSent codeSent=await
        (String verificationID,[int ?forceResendingtoken]){
          showSnackbar( context, 'Verification code sent on the phone number');

        };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout= await (String verificationID){
      showSnackbar( context,"Time out");
    };
    try{
      await _firebaseauth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    }catch(e){
      showSnackbar( context, e.toString());

    }
}*/

    await verifyPhonenumber;
  }
  void showSnackbar( BuildContext context, String text)
  {
    final snackBar= SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }





//Signin / login using Phone Number and password

// Sign out

}

