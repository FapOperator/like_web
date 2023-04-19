import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:like_web/custom_dialog.dart';
import 'package:like_web/main.dart';
import 'package:like_web/utils/mock_data.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CountdownController _controller = CountdownController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Каталог видео'),
      ),
      body: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: ElevatedButton(
                    onPressed: () {
                      _controller.start();
                    },
                    child: Text('Демо уведомление')),
              ),
              SizedBox(
                height: 10,
              ),
              Countdown(
                controller: _controller,
                seconds: 20,
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
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: mockData["items"].length,
              itemBuilder: ((context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: const Color(0xFF000000))),
                  margin: EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    style: ListTileStyle.drawer,
                    title: Text(mockData["items"][index]["title"]),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => HomeScreen(
                            url: mockData["items"][index]["trailer_url"],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
