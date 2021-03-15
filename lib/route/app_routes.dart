import 'package:flutter/material.dart';
import 'package:flutter_video/ui/camera/video_cam_player.dart';
import 'package:flutter_video/ui/camera/video_cam_view.dart';
import 'package:flutter_video/ui/home.dart';
import 'package:flutter_video/ui/player/video_player_view.dart';
import 'package:flutter_video/utils/constant.dart';
import 'package:flutter_video/utils/path_arguments.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePath.home:
        {
          return MaterialPageRoute(
            builder: (_) => Home(),
          );
        }
      case RoutePath.player:
        {
          final PathArguments args = routeSettings.arguments;
          return MaterialPageRoute(
            builder: (_) => VideoPlayerView(args.video),
          );
        }
      case RoutePath.videoRecord:
        {
          return MaterialPageRoute(
            builder: (_) => VideoCamView(),
          );
        }
      case RoutePath.playVideo:
        {
          final PathArguments args = routeSettings.arguments;
          return MaterialPageRoute(
            builder: (_) => VideoCamPlayer(args.video),
          );
        }
      default:
        {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text("No route defined for ${routeSettings.name}"),
              ),
            ),
          );
        }
    }
  }
}