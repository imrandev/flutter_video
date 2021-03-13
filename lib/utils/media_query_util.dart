import 'package:flutter/material.dart';

class MediaQueryUtil {

  static final MediaQueryUtil _instance = MediaQueryUtil._internal();

  factory MediaQueryUtil() {
    return _instance;
  }

  MediaQueryUtil._internal();

  Size getSize(context){
    return MediaQuery.of(context).size;
  }

  double getItemWidth(context, dividedBy){
    return (getSize(context).width) / dividedBy;
  }

  double getItemWHeight(context, dividedBy){
    return (getSize(context).height) / dividedBy;
  }
}