import 'package:flutter/material.dart';
class Constants{

  static Size getSize(BuildContext context){
    var size = MediaQuery.of(context).size;
    return size;
  }

}