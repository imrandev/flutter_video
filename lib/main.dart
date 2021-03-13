import 'package:flutter/material.dart';
import 'package:flutter_video/route/app_routes.dart';
import 'package:flutter_video/utils/constant.dart';

void main() {
  runApp(VideoApp());
}

class VideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Video',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: RoutePath.home,
      debugShowCheckedModeBanner: false,
    );
  }
}
