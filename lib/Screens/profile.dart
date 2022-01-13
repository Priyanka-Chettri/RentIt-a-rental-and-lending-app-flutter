import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/Screens/first_page.dart';
import 'package:rentit/Screens/login_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rentit/services/products_saving.dart';
import 'package:rentit/services/profile_picture_saving.dart';





class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var userName = '';
ProfilePicture profile= ProfilePicture();
final User? user = _auth.currentUser;




class _ProfileScreenState extends State<ProfileScreen> {
  @override


  XFile? _profileImage;
  bool display=false;

  final List<String> Accounts_features = [
    'Profile Details',
    ' Settings'
  ];
  final List<String> Mini_details = [
    'Change your password and phone number',
    'Manage notification and app settings'
  ];
  final _iconTypes = <IconData>[
    Icons.note,
    Icons.settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
                         child: Stack(
                            children: [

                              Positioned(
                                  top: 0.h,
                                  right: 0.w,
                                  left: 0.w,
                                  child: Container(
                                      height: 120.h,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/images/accounts.jpg"),
                                            fit: BoxFit.fill,
                                          )
                                      ),
                                      child: Container(
                                        color: Colors.teal.shade400.withOpacity(.85),

                                      )
                                  )),

                             Positioned(
                               top: 16.h,
                               left: 5.h,
                               child: Container(
                                 margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                                 child:  CircleAvatar(
                                   radius:81,
                                   backgroundColor: Colors.tealAccent,
                                  // child: GestureDetector(
                                   //  onTap: _selectImage2,
                                     child: FutureBuilder(
                                         future: FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
                                       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot>snapshot) {
                                         if(snapshot.hasData) {
                                           //Object? data= snapshot.data;
                                           Map<String, dynamic> data= snapshot.data!.data() as Map<String, dynamic>;
                                           return CircleAvatar(
                                               backgroundColor: Colors.grey,
                                               radius: 78,
                                               backgroundImage
                                               : data['profile_picture']==null? displayImage(): NetworkImage( data['profile_picture']),
                                           );
                                         }
                                         else {
                                           return CircularProgressIndicator();
                                         }
                                       }
                                     ),
                                  // ),
                                 ),

                               ),
                             ),
                              Positioned(
                                  top:130.h,
                                  left:100.h,
                                  child: RawMaterialButton(
                                    elevation: 10,
                                    fillColor: Colors.teal.shade200,
                                    child:Icon(Icons.add_a_photo),
                                    padding: EdgeInsets.all(15.0),
                                    shape: CircleBorder(),
                                    onPressed: () {
                                      debugPrint("Pressed Camera button");
                                      _selectImage2();


                                    }

                                  ),),



                              Positioned(
                                top: 220.h,
                                // child: //Padding(
                                //padding: const EdgeInsets.symmetric(vertical: 200),
                                child: Container(
                                    height: 170.h,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 40,
                                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.3),
                                            blurRadius: 15.r,

                                          )
                                        ]
                                    ),
                                    child: ListView.builder(
                                        itemCount: Accounts_features.length,
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          return Container(
                                              margin: EdgeInsets.all(8.0.sp),
                                              child: SizedBox(
                                                height: 70.h,
                                                child: Card(
                                                    child: Column(
                                                        children: [
                                                          ListTile(
                                                            leading: Icon(
                                                                _iconTypes[index],color:Colors.teal,),
                                                            title: Text(
                                                                Accounts_features[index],style: const TextStyle( fontWeight: FontWeight.bold,)),
                                                            subtitle: Text(
                                                                Mini_details[index]),
                                                            trailing: const Icon(
                                                                Icons
                                                                    .arrow_forward_ios),
                                                          )
                                                        ]
                                                    )

                                                ),
                                              )
                                          );
                                        }

                                    )

                                ),
                              ),

                              Positioned(
                                top:450.h,
                                left:80.w,
                                child: SizedBox(
                                  height:43.h,
                                  width:200.w,
                                  child: ElevatedButton(
                                    child:  Text(
                                      "Log out",
                                      style: TextStyle(color: Colors.teal, fontSize: 19.sp),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      // minimumSize: (100,40.0),
                                      primary: Colors.white,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      side:  BorderSide(color: Colors.teal, width:2.5.w),
                                    ), onPressed: () {
                                         signOut();
                                  },
                              ),
                                )
                              ),
                            ],
                          ),
                      //  ],
                     // ),
                    ),
                  );

    }

  void _selectImage2()async {
    XFile? tempImage = await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 180, maxWidth: 1000);

    setState(() {
      _profileImage=tempImage;
    });
    validateAndUpload();
  }

  void validateAndUpload() async{

      if(_profileImage!=null)
      {
         String imageUrl;
         final FirebaseStorage storage= FirebaseStorage.instance;
          final String pictureName= "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          UploadTask task= storage.ref().child(pictureName).putFile(File(_profileImage!.path));
          var url= await(await task).ref.getDownloadURL();
          imageUrl=url.toString();
          debugPrint(imageUrl);
          profile.uploadProductsToFirestore(
            ImageURl: imageUrl,);
      }

    }

  ImageProvider displayImage() {

      return Image.file(File(_profileImage!.path), fit:BoxFit.fill,).image;



  }


  Future signOut ()
    async {
      await _auth.signOut().then((value)=>Navigator.pushReplacement(context,  MaterialPageRoute(builder: (BuildContext context) => firstscreen())));
    }




  }



