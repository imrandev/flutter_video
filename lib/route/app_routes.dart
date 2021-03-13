import 'package:flutter/material.dart';
import 'package:flutter_video/blocs/provider/bloc_provider.dart';
import 'package:flutter_video/blocs/video_bloc.dart';
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
            builder: (_) => BlocProvider(child: Home(), bloc: VideoBloc()),
          );
        }
      case RoutePath.player:
        {
          final PathArguments args = routeSettings.arguments;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(child: VideoPlayerView(args.video), bloc: VideoBloc()),
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