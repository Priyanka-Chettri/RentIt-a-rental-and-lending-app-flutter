
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../color.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:rentit/Screens/login_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override

  final List<String> Accounts_features=['My Products','Profile Details',' Settings' ];
  final List<String> Mini_details=['Check your uploaded products', 'Change your password and phone number','Manage notifacation and app settings' ];
  final _iconTypes=<IconData>[ Icons.add_shopping_cart, Icons.note, Icons.settings];
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children:[
            Positioned(
                 top:0,
                 right: 0,
                 left:0,
                 child: Container(
                   height:150,
                   decoration: const BoxDecoration(
                     image: DecorationImage(
                       image: AssetImage("assets/images/accounts.jpg"),
                       fit: BoxFit.fill,
                     )
                   ),
                   child:Container(
                     color: Colors.teal.shade400.withOpacity(.85),

                   )
                 )),

            Positioned(
              top:90,
              left:20,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("images/accounts/jpg"),
                backgroundColor: Colors.green.shade100,


              )
            ),

            Positioned(
              top:250,
             // child: //Padding(
                //padding: const EdgeInsets.symmetric(vertical: 200),
                child: Container(
                    height: 270,
                    width: MediaQuery.of(context).size.width-40,
                    margin: EdgeInsets.symmetric(horizontal:20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius:15,

                        )
                      ]
                    ),
                      child: ListView.builder(
                        itemCount: Accounts_features.length,
                        itemBuilder: (BuildContext context, int index)
                        {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            child:SizedBox(
                              height:80,
                              child: Card(
                                child: Column(
                                  children:[
                                    ListTile(
                                      leading:Icon(_iconTypes[index], color:Colors.teal,),
                                      title:Text(Accounts_features[index], style: const TextStyle( fontWeight: FontWeight.bold)),
                                      subtitle: Text(Mini_details[index]),
                                      trailing: Icon(Icons.arrow_forward_ios),
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
          //  ),


          ]

            )

        ),

      );

    }
}