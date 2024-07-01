import "package:flutter/material.dart";
import "package:video_player/video_player.dart";

class DisplaySign extends StatefulWidget {
  const DisplaySign({
    required this.videoLink,
    super.key
  });

  final String videoLink;

  @override
  _DisplaySignState createState() => _DisplaySignState();
}

class _DisplaySignState extends State<DisplaySign> {
  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.networkUrl(Uri.parse("https://github.com/Boatkungg/TSLConnect-App/raw/main/lib/assets/placeholder.mp4"));

    videoController.addListener(() {
      setState(() {});
    });

    videoController.initialize().then((_) {
      setState(() {});
    });

    videoController.setLooping(true);
    videoController.play();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30, left: 20),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          VideoPlayer(videoController)
        ],
      ),
    );
  }
}