import 'package:like_web/feed_player/feed_player.dart';
import 'package:like_web/web_video_player/web_video_player.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import './landscape_player/landscape_player.dart';

import 'default_player/default_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flick player like_web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(246, 245, 250, 1),
        body: SafeArea(child: like_webs()),
      ),
    );
  }
}

class like_webs extends StatefulWidget {
  const like_webs({Key? key}) : super(key: key);

  @override
  _like_websState createState() => _like_websState();
}

class _like_websState extends State<like_webs> {
  final List<Map<String, dynamic>> samples = [
    {'name': 'Default player', 'widget': DefaultPlayer()},
    {'name': 'Feed player', 'widget': Expanded(child: FeedPlayer())},
    {'name': 'Landscape player', 'widget': LandscapePlayer()},
  ];

  int selectedIndex = 0;

  changeSample(int index) {
    if (samples[index]['widget'] is LandscapePlayer) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LandscapePlayer(),
      ));
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? _buildWebView() : _buildMobileView();
  }

  Widget _buildWebView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(child: WebVideoPlayer()),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Flick video player',
                style: TextStyle(
                  color: Color.fromRGBO(100, 109, 236, 1),
                  fontWeight: FontWeight.bold,
                )),
          ),
        )
      ],
    );
  }

  Widget _buildMobileView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: samples[selectedIndex]['widget'],
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: samples.asMap().keys.map((index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      changeSample(index);
                    },
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          samples.asMap()[index]?['name'],
                          style: TextStyle(
                            color: index == selectedIndex
                                ? Color.fromRGBO(100, 109, 236, 1)
                                : Color.fromRGBO(173, 176, 183, 1),
                            fontWeight:
                                index == selectedIndex ? FontWeight.bold : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList()),
        ),
      ],
    );
  }
}
