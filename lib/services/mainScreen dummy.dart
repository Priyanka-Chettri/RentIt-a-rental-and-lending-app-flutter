import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/Screens/Categories/services.dart';
import 'package:rentit/Screens/image_picker_screen.dart';
//import 'package:states_and_ut_india/states_and_ut_india.dart';
import 'package:rentit/Screens/Categories/books.dart';
import 'package:rentit/Screens/Categories/electronics.dart';

import 'package:rentit/Screens/Categories/electronics.dart';
//import 'package:rentit/Screens/Categories/services.dart';


class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var productList = <Product>[
    Product(name:'Camera',category:'Appliance',price:0,image:Image.asset('assets/images/camera.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'C++',category:'Book',price:0,image:Image.asset('assets/images/cpp.png'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'TV',category:'Appliance',price:0,image:Image.asset('assets/images/tv.png'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'DJ',category:"Service",price:0,image:Image.asset('assets/images/dj.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Heater',category:'Appliance',price:0,image:Image.asset('assets/images/heater.jpeg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Singer',category:'Service',price:0,image:Image.asset('assets/images/singer.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Computer Networks',category:'Book',price:0,image:Image.asset('assets/images/network.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Wired',category:'Book',price:0,image:Image.asset('assets/images/wired.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Dancer',category:'Service',price:0,image:Image.asset('assets/images/dancer.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Printer',category:'Appliance',price:0,image:Image.asset('assets/images/printer.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
  ];


  //var statesList= INStates.getAllStateNamesList();
  String _currentState='Assam';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(),
            sliver: SliverAppBar(
              toolbarHeight: 120.h,
              elevation: 10.h,
              flexibleSpace: Container(
                decoration:const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors:[
                      Color(0xFF4DB6AC),
                      Color(0xFF009688),
                      Color(0xFF00796B),
                    ],
                  ),
                ),
                child:Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, left: 15.h, right: 15.h),
                      child: TextField(
                        onTap: (){
                          showSearch(
                            context:context,
                            delegate:CustomSearchDelegate(),
                          );
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.r)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Search",
                        ),
                      ),
                    ),
                    SizedBox(
                      height:10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.h,),
                          child: IconButton(
                            icon: Icon(Icons.place),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text("$_currentState"),
                        ),

                      ],
                    ),

                  ],
                ),),
              floating: true,
            ),
          ),
          SliverPadding(
            padding:EdgeInsets.only(bottom:20.h),
            sliver: SliverToBoxAdapter(
              //TODO:Add the category area
              child: Container(
                child: Column(
                  children: [
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, left: 10.h, right: 180.h,bottom: 20.h),
                        child: Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ]),
                    Padding(
                      padding: EdgeInsets.all(3.h),
                      child: Container(
                        height: 90.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: GestureDetector(
                                onTap:(){
                                  print("Appliances is tapped");
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ElectronicCategory()));
                                },
                                child: Container(
                                  child: Column(children: [
                                    Container(
                                      width: 68.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.grey)
                                      ),
                                      child: Image.asset('assets/images/appliance.png'),
                                    ),
                                    Text("Appliances"),
                                  ]),
                                ),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: GestureDetector(
                                onTap:(){
                                  print("Books is tapped");
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BooksCategory()));

                                },
                                child:Container(
                                  child: Column(children: [
                                    Container(
                                      width: 68.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.grey)
                                      ),
                                      child: Image.asset('assets/images/books.png',scale:4.w),
                                    ),
                                    Text("Books"),
                                  ]),
                                ),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: GestureDetector(
                                onTap:(){
                                  print("Services is tapped");

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ServicesCategory()));
                                },
                                child:Container(
                                  child: Column(children: [
                                    Container(
                                      width: 68.w,
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.grey)
                                      ),
                                      child: Image.asset('assets/images/service.png',scale:7.5.h),
                                    ),
                                    Text("Services"),
                                  ]),
                                ),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding:EdgeInsets.only(bottom:0.h),
            sliver: SliverToBoxAdapter(
              child: Divider(
                color: Colors.grey,
                thickness:0.1.h,
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left:8.w,right:8.w,top:0.h,bottom:8.h),
                  child:GestureDetector(
                    onTap:(){
                      print(productList[index].name+" tapped");
                    },
                    child:Card (
                      elevation:3,
                      shadowColor: Colors.teal,
                      child: Container(
                        margin: EdgeInsets.only(left:5.w,right:5.w,top:5.h,bottom:5.h),
                        decoration:BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r),
                            bottomLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                          ),
                        ),

                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(2.w),
                              child: Container(
                                height: 80.h,
                                width: 200.h,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)
                                ),
                                child: productList[index].image,

                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Padding(
                                        padding: EdgeInsets.only(left:1.w,top:2.h),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child:SizedBox(
                                            width: 80.w,
                                            child:Text(
                                              productList[index].name,
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
                                        padding: EdgeInsets.only(left:2.w,top:1.5.w),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            (productList[index].price).toString()+"₹ Mo",
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
                                Padding(
                                  padding:EdgeInsets.only(top:1.h),
                                  child:IconButton(
                                    iconSize:25.sp,
                                    color: Colors.teal,
                                    icon: Icon(Icons.chat_outlined),
                                    onPressed:(){},
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),),
                );
              },
              childCount: productList.length,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.endFloat,
      floatingActionButton:Container(
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(90.r),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors:[
              Color(0xFF4DB6AC),
              Color(0xFF009688),
              Color(0xFF00796B),
            ],
          ),
        ),
        child:FloatingActionButton(
          elevation:0,
          child: Icon(Icons.add),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PickImage()));

          },
        ),),
    );
  }

/*Widget createDropDownList() {
    return DropdownButtonFormField(
        value:_currentState,
        items: statesList.map((state){
      return DropdownMenuItem<String>(
        value: state,
        child: Text("state"),
      );
    }).toList(),

    onChanged: (String? val){
    setState((){
    _currentState= val!;
    debugPrint('$_currentState');
    });
    },
    decoration: const InputDecoration(
    labelText: 'Select Category',
    ),
    );
  }*/
}
class Product{
  final String name;
  final String category;
  final int price;
  final String lender;
  final Image image;
  final Icon lenderImg;
  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.lender,
    required this.lenderImg,
  });
}
class CustomSearchDelegate extends SearchDelegate {
  List<Product> searchList = [
    Product(name:'Camera',category:'Appliance',price:0,image:Image.asset('assets/images/camera.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'C++',category:'Book',price:0,image:Image.asset('assets/images/cpp.png'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'TV',category:'Appliance',price:0,image:Image.asset('assets/images/tv.png'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'DJ',category:"Service",price:0,image:Image.asset('assets/images/dj.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Heater',category:'Appliance',price:0,image:Image.asset('assets/images/heater.jpeg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Singer',category:'Service',price:0,image:Image.asset('assets/images/singer.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Computer Networks',category:'Book',price:0,image:Image.asset('assets/images/network.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Wired',category:'Book',price:0,image:Image.asset('assets/images/wired.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Dancer',category:'Service',price:0,image:Image.asset('assets/images/dancer.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
    Product(name:'Printer',category:'Appliance',price:0,image:Image.asset('assets/images/printer.jpg'),lender:'Lender',lenderImg:Icon(Icons.person),),
  ];

  @override
  List<Widget> buildActions(BuildContext context){
    return[
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed:(){
            query = '';
          }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context){
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed:(){
        close(context,null);
      },
    );
  }
  @override
  Widget buildResults(BuildContext context){
    List<Product> matchQuery = [];
    for(var search in searchList){
      if(((search.name).toLowerCase()).contains(query.toLowerCase()) || ((search.category).toLowerCase()).contains(query.toLowerCase())){
        matchQuery.add(search);
      }
    }
    return GridView.builder(
      itemCount: matchQuery.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      physics: BouncingScrollPhysics(),
      itemBuilder:(BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(left:8.w,right:8.w,top:8.h,bottom:8.h),
          child:GestureDetector(
            onTap:(){
              print(matchQuery[index].name+" tapped");
            },
            child:Card (
              elevation:3,
              shadowColor: Colors.teal,
              child: Container(
                margin: EdgeInsets.only(left:5.w,right:5.w,top:5.h,bottom:5.h),
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),

                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Container(
                        height: 80.h,
                        width: 200.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)
                        ),
                        child: matchQuery[index].image,

                      ),
                    ),
                    Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Padding(
                                padding: EdgeInsets.only(left:1.w,top:2.h),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:SizedBox(
                                    width: 80.w,
                                    child:Text(
                                      matchQuery[index].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                                padding: EdgeInsets.only(left:2.w,top:1.5.w),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (matchQuery[index].price).toString()+"₹ Mo",
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
                        Padding(
                          padding:EdgeInsets.only(top:1.h),
                          child:IconButton(
                            iconSize:25.sp,
                            color: Colors.teal,
                            icon: Icon(Icons.chat_outlined),
                            onPressed:(){},
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context){
    List<Product> matchQuery = [];
    for(var search in searchList){
      if(((search.name).toLowerCase()).contains(query.toLowerCase()) || ((search.category).toLowerCase()).contains(query.toLowerCase())){
        matchQuery.add(search);
      }
    }
    return GridView.builder(
      itemCount: matchQuery.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      physics: BouncingScrollPhysics(),
      itemBuilder:(BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(left:8.w,right:8.w,top:8.h,bottom:8.h),
          child:GestureDetector(
            onTap:(){
              print(matchQuery[index].name+" tapped");
            },
            child:Card (
              elevation:3,
              shadowColor: Colors.teal,
              child: Container(
                margin: EdgeInsets.only(left:5.w,right:5.w,top:5.h,bottom:5.h),
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),

                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Container(
                        height: 85.h,
                        width: 200.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)
                        ),
                        child: matchQuery[index].image,

                      ),
                    ),
                    Row(
                      children: [
                        Column(
                            children:[
                              Padding(
                                padding: EdgeInsets.only(left:2.w,top:2.w),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    matchQuery[index].name,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color:Colors.grey[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:2.w,top:1.5.w),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    matchQuery[index].category,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color:Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:2.w,top:1.5.w),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    (matchQuery[index].price).toString()+"₹ Mo",
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
                        SizedBox(width:10.w),
                      ],
                    ),

                  ],
                ),
              ),
            ),),
        );
      },
    );
  }
}