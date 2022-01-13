import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AlertScreen extends StatefulWidget{


  @override
  _AlertScreenState createState() => _AlertScreenState();
}
final FirebaseAuth _auth =  FirebaseAuth.instance;
final User? user=_auth.currentUser;
var user_id = user!.uid;


class _AlertScreenState extends State<AlertScreen>{

  /*static void init() async{
    final FirebaseAuth _auth =  FirebaseAuth.instance;
    final User? user=_auth.currentUser;
    user_id = user!.uid;
  }
*/
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade500,
          title: const Text(
            'My Products',
            style:TextStyle(
              fontSize: 19,
            ),
          ),
        ),
        body: StreamBuilder (

            stream: FirebaseFirestore.instance.collection('products').doc(user_id).collection("product_details").orderBy('created_At', descending: true).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
            {
              if(!snapshot.hasData)
              {
                return const Center(
                  child: Text(
                    'No data',
                  ),
                );
              }
              if(snapshot.connectionState==ConnectionState.waiting)
                {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              return ListView(
                children: getItem(snapshot),
              );
            }
        )
    );
  }

  getItem(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return snapshot.data!.docs.map((d) => Padding(
      padding: EdgeInsets.only(left:10.w,right:10.w,top:5.h,bottom:6.h),
      child: Card (
        elevation:9,
        shadowColor: Colors.teal,
        child: Container(
          margin: EdgeInsets.only(left:5.w,right:5.w,top:5.h,bottom:7.h),
          decoration:BoxDecoration(
            color:Colors.teal.shade100,
            /* borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),*/
          ),

          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: Container(
                  height: 120.h,
                  width: 200.h,
                  /*                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),*/
                  child: Image.network(d['Product_Image'].toString(),),

                ),
              ),
              Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Padding(
                          padding: EdgeInsets.only(left:20.w,top:0.h),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:SizedBox(
                              width: 80.w,
                              child:Text(
                                d['Product_Name'],
                                maxLines: 2,overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color:Colors.grey[700],
                                  fontWeight: FontWeight.w700,
                                ),
                              ),),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:20.w,top:1.5.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (d['Product_Amount']).toString()+" ₹ Mo",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color:Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                  Flexible(
                      flex:1,
                      child:Container(
                        color:Colors.white,
                      )
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    )).toList();
  }
}