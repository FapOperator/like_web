import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:like_web/custom_dialog.dart';
import 'package:like_web/utils/mock_data.dart';
import 'package:like_web/web_video_player/web_video_player.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

void main() => runApp(const MyApp());

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
        home: const HomeScreen(),
      ),
    );
  }
}

// This is the main screen of the application
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CountdownController _controller = CountdownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Player')),
      body: Column(
        children: [
          Expanded(child: WebVideoPlayer()),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: ElevatedButton(
                    onPressed: () {
                      _controller.start();
                    },
                    child: Text('Демо уведомление')),
              ),
              Countdown(
                controller: _controller,
                seconds: 5,
                build: (_, double time) => Text(
                  ' Уведомление будет показано через ${time.toString()} сек.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                interval: Duration(milliseconds: 100),
                onFinished: () {
                  showSimpleNotification(
                      CustomDialogBox(
                        title: "Демо уведомление",
                        descriptions:
                            "Привет. Я демо уведомление которое всплывает по центру экрана устройства",
                        text: "Спасибо",
                      ),
                      duration: Duration(seconds: 4),
                      background: Colors.transparent
                      // Text("this is a message from simple notification"),
                      );
                  _controller.restart();
                  _controller.pause();
                  // _showModal(context);
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return CustomDialogBox(
                  //         title: "Демо уведомление",
                  //         descriptions:
                  //             "Привет. Я демо уведомление которое всплывает по центру экрана устройства",
                  //         text: "Спасибо",
                  //       );
                  //     });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
