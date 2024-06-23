import "package:flutter/material.dart";
import "package:camera/camera.dart";
//import "package:http/http.dart" as http;


class Sign2Thai extends StatefulWidget {
  const Sign2Thai({
    required this.cameras,
    super.key
  });

  final List<CameraDescription> cameras;

  @override
  State<Sign2Thai> createState() => _Sign2ThaiState();
}

class _Sign2ThaiState extends State<Sign2Thai> {
  late CameraController camController;

  void initCamera() async {
    camController = CameraController(widget.cameras.first, ResolutionPreset.max);
    await camController.initialize().catchError((e) {
      print('Error initializing camera: $e');
      camController.dispose();
      initCamera();
    });
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    super.dispose();
    camController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          camController.value.isInitialized
            ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CameraPreview(camController)
              )
            : const Center(
              child: CircularProgressIndicator()
              ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // TODO: change icon
              children: [
                Icon(Icons.translate, size: 30),
                Icon(Icons.swap_horiz, size: 30),
                Icon(Icons.sign_language, size: 30)
              ],
            ),
          ),
        ],
      ),
    );
  }
}


