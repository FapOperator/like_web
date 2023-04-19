import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:like_web/catalog.dart';
import 'package:like_web/custom_dialog.dart';
import 'package:like_web/custom_orientation_player/custom_orientation_player.dart';
import 'package:like_web/default_player/default_player.dart';
import 'package:like_web/feed_player/feed_player.dart';
import 'package:like_web/landscape_player/landscape_player.dart';
import 'package:like_web/web_video_player/web_video_player.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:safe_area_insets/safe_area_insets.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'js_ext_stub.dart'
    if (dart.library.html) 'package:safe_area_insets/src/js_ext.dart';

void main() {
  testJsExt();
  if (kIsWeb) setupViewportFit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        // remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'KindaCode.com',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const CatalogScreen(),
      ),
    );
  }
}

// This is the main screen of the application
class HomeScreen extends StatefulWidget {
  final String url;
  const HomeScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      top: false,
      bottom: false,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: WebVideoPlayer(url: widget.url)),
          ],
        ),
      ),
    );
  }
}
