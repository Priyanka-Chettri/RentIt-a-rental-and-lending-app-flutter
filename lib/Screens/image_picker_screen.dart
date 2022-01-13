// This screen will help pick image

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rentit/services/products_saving.dart';


void main()=> runApp(const MaterialApp(
  home: PickImage(),
  debugShowCheckedModeBanner: false,
)
);
class PickImage extends StatefulWidget {
  const PickImage({Key? key}) : super(key: key);


  @override
  _PickImageState createState() => _PickImageState();
}


class _PickImageState extends State<PickImage> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> categories=['Electronics', 'Books', 'Services'];
  TextEditingController  ProductNameController = TextEditingController();
  TextEditingController AmountController=TextEditingController();
  Products product= Products();


  String _currentCategory='Books';
  bool isLoading=false;
  var productName;
  var Amount;
  XFile? _ImageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
        },
          child: const Icon(
              Icons.cancel_outlined,
              size: 30),
        ),
        title: const Text(
          'Add Product',
          style:TextStyle(
            fontSize: 19,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: isLoading ? CircularProgressIndicator(): Column(
              children: [
                Container(
                  height: 230,
                  child: Stack(
                    children:[
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: 140,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/leaf.jpg"),
                                fit: BoxFit.fill,
                              )
                          ),
                          child: Container(
                            color: Colors.teal.shade400.withOpacity(.85),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 35.0,
                        left: 80.0,
                        child: Center(
                          child: ElevatedButton(
                              onPressed: () {
                                _selectImage(ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 180, maxWidth: 1000));
                              },
                              child: displayImage(),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                side: BorderSide(
                                  color: Colors.grey.withOpacity(0.8),
                                  width:2.0,
                                ),
                              )
                          ),
                        ),),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: TextFormField(
                      controller: ProductNameController,
                      decoration: const InputDecoration(
                        hintText: 'Product Name',
                      ),
                      validator: (val){
                        if(val!.isEmpty) {
                          return 'Please enter the product name';
                        } else if(val.length>20) {
                          return 'Product name can\'t have more than 20 letters ';
                        }
                      },
                      onChanged: (val){
                        setState(()=> productName=val);
                },
                  ),
                ),
                SizedBox( height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButtonFormField(
                    value:_currentCategory,
                    items: categories.map((category){
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),

                    onChanged: (String? val){
                      setState((){
                        _currentCategory= val!;
                        debugPrint('$_currentCategory');
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Select Category',
                    ),


                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                      controller: AmountController,
                      decoration: const InputDecoration(
                        hintText: 'Price of Product ',
                      ),
                      validator: (val){
                        if(val!.isEmpty) return 'Please enter the product price';
                        else if(val.length>5) return 'Product price can\'t be 5 digits';
                      },
                      onChanged: (val){
                setState(()=> Amount=val);
                },
                  ),
                ),
                const SizedBox(height: 45),
                SizedBox(
                  height:48,
                  width:160,
                  child: ElevatedButton(
                    child:  const Text(
                      "ADD",
                      style: TextStyle(color: Colors.teal, fontSize: 19),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      side:  BorderSide(color: Colors.teal, width:3),
                    ),
                    //TODO: Add image and description into database and validate
                    onPressed: () {
                       validateAndUpload();
                  },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    //  )

    // )
    // );
  }

  void _selectImage(Future<XFile?> pickImage)async {
    XFile? tempImage = await pickImage;
    setState(() {
      _ImageFile=tempImage;
    });

  }

  Widget? displayImage() {
    if(_ImageFile==null)
    {
      return const Padding(
        padding: EdgeInsets.fromLTRB(80.0,70.0, 80.0, 70.0),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    }
    else {
      return Image.file(File(_ImageFile!.path), fit:BoxFit.fill,);

    }

  }

  void validateAndUpload() async{
    if(_formKey.currentState!.validate()){
      setState(() {
        isLoading=true;
      });
      if(_ImageFile!=null)
        {
          if(productName.isNotEmpty || Amount.isNotEmpty)
            {
               String imageUrl;
               final FirebaseStorage storage= await FirebaseStorage.instance;
               final String pictureName= "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
               UploadTask task= storage.ref().child(pictureName).putFile(File(_ImageFile!.path));
               /*task.then((res){
                 imageUrl= res.ref.getDownloadURL() as String;
               });*/
              var url= await(await task).ref.getDownloadURL();
              imageUrl=url.toString();
              debugPrint(imageUrl);
              product.uploadProductsToFirestore(
                  ProductName: productName,
                  ProductCategory: _currentCategory,
                  ProductAmount: double.parse(Amount),
                  ImageURl: imageUrl,);
              _formKey.currentState!.reset();
              setState(() {
                isLoading=false;
              });
               Fluttertoast.showToast(msg:'Product Added');
            }
          else{
            setState(() {
              isLoading=false;
            });
            Fluttertoast.showToast(msg:'Enter the empty fields');
          }
        }
      else{
        setState(() {
          isLoading=false;
        });
        Fluttertoast.showToast(msg:' the image must be provided');
      }
    }
  }



}

