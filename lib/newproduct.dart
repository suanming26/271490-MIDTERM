import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:midtermstiw2044myshop/productlist.dart';

class NewProduct extends StatefulWidget {
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  double screenHeight, screenWidth;
  String pathAsset = 'assets/images/photo.png';
  File _image;

  TextEditingController nameC = new TextEditingController();
  TextEditingController typeC = new TextEditingController();
  TextEditingController priceC = new TextEditingController();
  TextEditingController quantityC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('ADD PRODUCT'),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(height: 5),
              GestureDetector(
                onTap: () => {
                  _onPicture(),
                },
                child: Container(
                    height: screenHeight / 2.5,
                    width: screenWidth / 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _image == null
                            ? AssetImage(pathAsset)
                            : FileImage(_image),
                        fit: BoxFit.scaleDown,
                      ),
                    )),
              ),
              Card(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  elevation: 0,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        TextField(
                            controller: nameC,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue[200], width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo[800], width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Product Name',
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            )),
                        SizedBox(height: 10),
                        TextField(
                            controller: typeC,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue[200], width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo[800], width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Type',
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            )),
                        SizedBox(height: 10),
                        TextField(
                            controller: priceC,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue[200], width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo[800], width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Price',
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            )),
                        SizedBox(height: 10),
                        TextField(
                            controller: quantityC,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue[200], width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo[800], width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Quantity',
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            )),
                        SizedBox(height: 20),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minWidth: screenWidth / 2,
                          height: 50,
                          child: Text(
                            'Add',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: _addProduct,
                          color: Colors.blueGrey[400],
                        ),
                      ],
                    ),
                  ))
            ],
          )),
        ),
      ),
    );
  }

  _onPicture() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: new Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Take picture from:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox.fromSize(
                          size: Size(100, 100),
                          child: Material(
                              color: Colors.blueGrey,
                              elevation: 10,
                              child: InkWell(
                                  splashColor: Colors.blue,
                                  onTap: () =>
                                      {Navigator.pop(context), _chooseCamera()},
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.camera),
                                      Text('Camera',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          )),
                                    ],
                                  )))),
                      SizedBox(width: 10),
                      SizedBox.fromSize(
                          size: Size(100, 100),
                          child: Material(
                              color: Colors.blueGrey,
                              elevation: 10,
                              child: InkWell(
                                  splashColor: Colors.blue,
                                  onTap: () => {
                                        Navigator.pop(context),
                                        _chooseGallery()
                                      },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.folder),
                                      Text('Gallery',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          )),
                                    ],
                                  )))),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  Future _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  void _addProduct() {
    String _name = nameC.text.toString();
    String _type = typeC.text.toString();
    String _price = priceC.text.toString();
    String _quantity = quantityC.text.toString();

    if (_name.isEmpty && _type.isEmpty && _price.isEmpty && _quantity.isEmpty) {
      Fluttertoast.showToast(
          msg: "Product Name/Type/Price/Qauntity is empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey[400],
          textColor: Colors.white,
          fontSize: 16);
      return;
    } else if (_name.isEmpty) {
      Fluttertoast.showToast(
          msg: "Product Name is empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey[400],
          textColor: Colors.white,
          fontSize: 16);
      return;
    } else if (_type.isEmpty) {
      Fluttertoast.showToast(
          msg: "Product Type is empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey[400],
          textColor: Colors.white,
          fontSize: 16);
      return;
    } else if (_price.isEmpty) {
      Fluttertoast.showToast(
          msg: "Product Price is empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey[400],
          textColor: Colors.white,
          fontSize: 16);
      return;
    } else if (_quantity.isEmpty) {
      Fluttertoast.showToast(
          msg: "Product Quantity is empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey[400],
          textColor: Colors.white,
          fontSize: 16);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Text("Add New Product?"),
              actions: [
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _newProduct(_name, _type, _price, _quantity);
                    }),
                TextButton(
                    child: Text("CANCEL"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ]);
        });
  }

  void _newProduct(String name, String type, String price, String quantity) {
    String base64Image = base64Encode(_image.readAsBytesSync());

    print(base64Image);
    print(name);
    print(type);
    print(price);
    print(quantity);
    http.post(
        Uri.parse("https://javathree99.com/s271490/myshop/php/add_product.php"),
        body: {
          "name": name,
          "type": type,
          "price": price,
          "quantity": quantity,
          "encoded_string": base64Image,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey[400],
            textColor: Colors.white,
            fontSize: 16);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Productlist()));
      } else {
        Fluttertoast.showToast(
            msg: "Failed.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey[400],
            textColor: Colors.white,
            fontSize: 16);
      }
    });
    return;
  }
}
