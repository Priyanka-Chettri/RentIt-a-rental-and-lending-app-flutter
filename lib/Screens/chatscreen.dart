import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:avatar_view/avatar_view.dart';


class ChatScreen extends StatefulWidget{
  ChatScreen({Key?key}):super(key:key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{
  final List<User> users=[
    const User(name:"Ritviz",lastMessage: "Is the product still available?",time: "12:00",image:'assets/images/ritviz.jpg'),
    const User(name:"Vicky",lastMessage: "Hows the condition of the product",time: "16:01",image:'assets/images/vicky.jpg'),
    const User(name:"Mickey",lastMessage: "Clubhouse",time: "05:32",image:'assets/images/mickey.png'),
    const User(name:"Zayn",lastMessage: "Trampoline",time: "14:01",image:'assets/images/zayn.jpeg'),
    const User(name:"Charlie",lastMessage: "Attention",time: "09:16",image:'assets/images/charlie.jpg'),
    const User(name:"Carry",lastMessage: "Cancel",time: "19:28",image:'assets/images/carry.jpg'),
    const User(name:"B.B",lastMessage: "Dhindora",time: "15:41",image:'assets/images/BB.jpg'),
    const User(name:"Sul",lastMessage: "Hello kid",time: "12:16",image:'assets/images/sul.jpg'),
    const User(name:"Tom",lastMessage: "3D in 2D",time: "02:08",image:'assets/images/tom.jpg'),
    const User(name:"Jeetu",lastMessage: "21 Days",time: "10:30",image:'assets/images/jeetu.jpg'),
  ];
  bool _visibility = true;
  int index = 0;
  Text header =Text("Chat",style:TextStyle(fontFamily: 'Roboto',fontSize:50.sp,color:Colors.black54),);
  TextField search = TextField(
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      filled: true,
      fillColor: Colors.white,
      hintText: "Search",
    ),
  );
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _visibility?header:search,
        backgroundColor: Colors.white,
        elevation:0,
        toolbarHeight: 60.h,
        actions: [
          Visibility(
            visible: _visibility,
            child:IconButton(
              color:Colors.black38,
              icon:Icon(Icons.search,size: 29.sp),
              onPressed: (){
                setState(() {
                  _visibility = !_visibility;
                });
              },
            ),),
          Visibility(
            visible: !_visibility,
            child:IconButton(
              color:Colors.black38,
              icon:Icon(Icons.arrow_back_outlined,size: 29.sp),
              onPressed: (){
                setState(() {
                  _visibility = !_visibility;
                });
              },
            ),),
        ],
        bottom: PreferredSize(
          child:Container(
            color: Colors.teal,
            height: 20.h,
          ),
          preferredSize: Size.fromHeight(20.h),
        ),
      ),
      body:Container(
        color:Colors.white,
        child: Expanded(
          child: ListView.builder(
            itemBuilder: (context,index){
              final user = users[index];
              return GestureDetector(
                onTap:(){
                  print(user.name+" tapped");
                },
                child:Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width:.1.w,
                      color:Colors.grey,
                    ),

                  ),
                  height: 70.h,
                  child:Center(
                    child: ListTile(
                      leading: AvatarView(
                        radius: 25.r,
                        borderColor: Colors.yellow,
                        isOnlyText: false,
                        text: Text(user.name, style: TextStyle(color: Colors.white, fontSize: 50),),
                        avatarType: AvatarType.CIRCLE,
                        backgroundColor: Colors.red,
                        imagePath: user.image,
                        placeHolder: Container(
                          child: Icon(Icons.person, size: 50,),
                        ),
                        errorWidget: Container(
                          child: Icon(Icons.error, size: 50,),
                        ),
                      ),
                      title: Text(user.name,style: TextStyle(fontSize: 20.sp,),),
                      subtitle: Text(user.lastMessage,style: TextStyle(fontSize: 12.sp,),),
                      trailing: Text(user.time,style: TextStyle(fontSize: 10.h,),),

                    ),
                  ),),
              );
            },
            itemCount: users.length,
          ),
        ),
      ),
    );
  }
}
class User{
  final String name;
  final String lastMessage;
  final String time;
  final String image;
  const User({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.image,
  });
}