import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'mainscreen.dart';
import 'chatscreen.dart';
import 'my_products.dart';
import 'profile.dart';

// ignore: use_key_in_widget_constructors
class MainPage extends StatefulWidget {

  MainPage({Key?key}):super(key:key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _keyboardIsVisible(){
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }
  int currentIndex = 0;
  final screens = [
    MainScreen(),
    ChatScreen(),
    AlertScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:screens[currentIndex]),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap:(index) => setState(() => currentIndex = index),
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            showUnselectedLabels: true,
            unselectedItemColor: Colors.black54,
            selectedItemColor: Colors.teal,
            items:const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart),
                label: 'My Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Me',
              ),
            ]
        ),
        color:Colors.teal,
      ),
    );
  }
}
