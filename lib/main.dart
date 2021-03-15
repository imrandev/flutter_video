import 'package:flutter/material.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:flutter_video/blocs/video_bloc.dart';
import 'package:flutter_video/route/app_routes.dart';
import 'package:flutter_video/utils/constant.dart';

void main() {
  runApp(VideoApp());
}

class VideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'Flutter Video',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: RoutePath.home,
        debugShowCheckedModeBanner: false,
      ),
      bloc: VideoBloc(),
    );
  }
}
