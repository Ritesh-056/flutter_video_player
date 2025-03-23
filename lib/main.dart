import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_video_player/core/res/app_dimen.dart';
import 'package:flutter_video_player/core/res/app_string.dart';
import 'package:flutter_video_player/presentation/screens/video_player_screen.dart';
import 'data/blocs/video_player/video_player_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppStarterScreen());
}

class AppStarterScreen extends StatelessWidget {
  const AppStarterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStr.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => VideoPlayerBloc(),
        child: Padding(
          padding: const EdgeInsets.all(AppDim.md),
          child: const VideoPlayerScreen(),
        ),
      ),
    );
  }
}
