import 'package:flutter/material.dart';

class Appwidget{
  static TextStyle textStyle(double size, {FontWeight fontweight= FontWeight.normal}){
    return TextStyle(fontSize: size, color: Colors.black, fontWeight: fontweight);
  }
}