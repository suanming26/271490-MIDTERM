import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/productlist.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Productlist()
    );
  }
}
