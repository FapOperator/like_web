import 'package:like_web/utils/mock_data.dart';
import 'package:like_web/web_video_player/web_video_control.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

import 'data_manager.dart';

class WebVideoPlayer extends StatefulWidget {
  final String url;
  WebVideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  _WebVideoPlayerState createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<WebVideoPlayer> {
  late FlickManager flickManager;
  late DataManager? dataManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url),
    );
    List<String> urls = (mockData["items"] as List)
        .map<String>((item) => item["trailer_url"])
        .toList();

    dataManager = DataManager(flickManager: flickManager, urls: urls);
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickManager.flickControlManager?.autoPause();
        } else if (visibility.visibleFraction == 1) {
          flickManager.flickControlManager?.autoResume();
          flickManager.flickVideoManager!.isVideoEnded;
        }
      },
      child: Stack(
        children: [
          Container(
            child: FlickVideoPlayer(
              flickManager: flickManager,
              flickVideoWithControls: FlickVideoWithControls(
                controls: WebVideoControl(
                  dataManager: dataManager!,
                  iconSize: 30,
                  fontSize: 14,
                  progressBarSettings: FlickProgressBarSettings(
                    height: 5,
                    handleRadius: 5.5,
                  ),
                ),
                videoFit: BoxFit.contain,
                // aspectRatioWhenLoading: 4 / 3,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 0,
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Назад'),
                )),
          ),
        ],
      ),
    );
  }
}
