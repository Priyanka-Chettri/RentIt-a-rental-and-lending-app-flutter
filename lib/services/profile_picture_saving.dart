import 'package:rentit/Screens/image_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';



class ProfilePicture {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> uploadProductsToFirestore ({ required String ImageURl })async {
    final User? user = await _auth.currentUser;
    final uid = user!.uid;
    if (user != null) {
     await _firestore
          .collection('users')
          .doc(uid).update({
        'profile_picture': ImageURl,


      }, //SetOptions(merge:true)
      );
      Fluttertoast.showToast(msg: 'Picture Added');


      // Saving profile picture in each products collection of a speciifc user
      var snapshots = FirebaseFirestore.instance.collection("products").doc(
          uid).collection("product_details").snapshots();
      try {
        snapshots.forEach((snapshot) async {
          List<DocumentSnapshot> documents = snapshot.docs;
          for (var document in documents) {
            await document.reference.update({
              'User_Profile_Pic': ImageURl,
            });
          }
        });
      } catch (e) {
        print(e.toString());
      }

      //Save the profile picture of each user in the home collection
      FirebaseFirestore.instance.collection('home').doc(uid).update({

        'User_Profile_Pic': ImageURl,
      });


    }
  }
}
