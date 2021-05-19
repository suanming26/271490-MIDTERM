import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/newproduct.dart';
import 'package:http/http.dart' as http;

class Productlist extends StatefulWidget {
  @override
  _ProductlistState createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {
  double screenHeight, screenWidth;
  List _productList;
  String _titlecenter = "Loading....";

  @override
  void initState() {
    super.initState();
    _loadingProduct();
  }

  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('MY PRODUCTS'),
        ),
        body: Center(
            child: Container(
                child: Column(
          children: [
            _productList == null
                ? Flexible(child: Center(child: Text(_titlecenter)))
                : Flexible(
                    child: Center(
                        child: Container(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: (screenWidth / screenHeight) / 0.8,
                        children: List.generate(_productList.length, (index) {
                          return Padding(
                              padding: EdgeInsets.all(5),
                              child: Card(
                                  child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://javathree99.com/s271490/myshop/images/products/${_productList[index]['prid']}.png",
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 20, 0, 0),
                                          child: Text(
                                              _productList[index]['prname'],
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 5, 0),
                                        child: Text(
                                          "RM: " +
                                              _productList[index]['prprice'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ]),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 5, 5, 0),
                                          child: Text(
                                            _productList[index]['prtype'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 5, 5, 0),
                                          child: Text(
                                            "Quantity Available: " +
                                                _productList[index]['prqty'],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )));
                        }),
                      ),
                    )),
                  )
          ],
        ))),
        floatingActionButton: Visibility(
            visible: _visible,
            child: FloatingActionButton.extended(
              label: Text('Add', style: TextStyle(fontSize: 20),),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewProduct()));
              },
              icon: Icon(Icons.add),
              backgroundColor:Colors.blueGrey[400],
            )));
  }

  void _loadingProduct() {
    http.post(
        Uri.parse(
            "https://javathree99.com/s271490/myshop/php/loadingproduct.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No data";
        return;
      } else {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        _titlecenter = "Contain Data";
        setState(() {});
        print(_productList);
      }
    });
  }
}
