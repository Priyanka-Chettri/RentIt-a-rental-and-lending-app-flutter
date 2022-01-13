import 'package:firebase_storage/firebase_storage.dart';
import 'package:rentit/Screens/image_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Products {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String ref = 'products';
  String ref2='product_details';
  String? phone;

 Future < void> uploadProductsToFirestore  (
      {required String ProductName, required String ProductCategory, required double ProductAmount, required String ImageURl }) async{
      final User? user = await _auth.currentUser;
      final user_id = user!.uid;
    if (user != null) {
      await _firestore
          .collection(ref)
          .doc(user.uid).collection(ref2)
          .add({
        'Product_Name': ProductName,
        'Product_Category': ProductCategory,
        'Product_Amount': ProductAmount,
        'Product_Image': ImageURl,
        'created_At': FieldValue.serverTimestamp(),
        'User_Profile_Pic':" ",


      },);

      _firestore.collection('home').doc().set({
        'Product_Name':ProductName,
        'Product_Category': ProductCategory,
        'Product_Amount': ProductAmount,
        'Product_Image':ImageURl,
        'created_AT': FieldValue.serverTimestamp(),
        'User_Profile_Pic':" ",
      });

    }
   if(ProductCategory.toLowerCase()=='books')
      {

          /*_firestore
              .collection('books')
              //.doc(user_id).collection('Books_for_same_uid')
              .add({
            'Product_Name': ProductName,
            'Product_Category': ProductCategory,
            'Product_Amount': ProductAmount,
            'Product_Image': ImageURl,
            'created_At': FieldValue.serverTimestamp(),
            'User_Profile_Pic':" ",

*/

        _firestore.collection('books').add({
          'Product_Name':ProductName,
          'Product_Category': ProductCategory,
          'Product_Amount': ProductAmount,
          'Product_Image':ImageURl,
          'created_AT': FieldValue.serverTimestamp(),
          'User_Profile_Pic':" ",
        });



      }

      else if(ProductCategory.toLowerCase()=='services')
      {

          /*_firestore
              .collection('services')
              //.doc(user_id).collection('Services_for_same_uid')
              .add({
            'Product_Name': ProductName,
            'Product_Category': ProductCategory,
            'Product_Amount': ProductAmount,
            'Product_Image': ImageURl,
            'created_At': FieldValue.serverTimestamp(),
            'User_Profile_Pic':" ",


          },);
*/

        _firestore.collection('services').add({
          'Product_Name':ProductName,
          'Product_Category': ProductCategory,
          'Product_Amount': ProductAmount,
          'Product_Image':ImageURl,
          'created_AT': FieldValue.serverTimestamp(),
          'User_Profile_Pic':" ",
        });

      }

      if(ProductCategory.toLowerCase()=='electronics')
      {

          /*_firestore
              .collection('electronics')
              //.doc(user_id).collection('Electronics_for_same_uid')
              .add({
            'Product_Name': ProductName,
            'Product_Category': ProductCategory,
            'Product_Amount': ProductAmount,
            'Product_Image': ImageURl,
            'created_At': FieldValue.serverTimestamp(),
            'User_Profile_Pic':" ",
          },);
*/
        _firestore.collection('electronics').add({
          'Product_Name':ProductName,
          'Product_Category': ProductCategory,
          'Product_Amount': ProductAmount,
          'Product_Image':ImageURl,
          'created_AT': FieldValue.serverTimestamp(),
          'User_Profile_Pic':" ",
        });

      }






  }
}