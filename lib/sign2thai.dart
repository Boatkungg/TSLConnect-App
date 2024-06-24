import "package:flutter/material.dart";
import "package:camera/camera.dart";
import "package:flutter/widgets.dart";
import "package:myapp/main.dart";
//import "package:http/http.dart" as http;

class Sign2Thai extends StatefulWidget {
  const Sign2Thai({required this.cameras, super.key});

  final List<CameraDescription> cameras;

  @override
  State<Sign2Thai> createState() => _Sign2ThaiState();
}

class _Sign2ThaiState extends State<Sign2Thai> {
  late CameraController camController;

  void initCamera() async {
    camController =
        CameraController(widget.cameras.first, ResolutionPreset.max);
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
                  child: CameraPreview(camController))
              : const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    // TODO: change icon
                    children: [
                      // change camera
                      const Icon(Icons.cameraswitch, size: 30),

                      // record
                      RawMaterialButton(
                        onPressed: null,
                        shape: const CircleBorder(),
                        fillColor: Colors.white,
                        constraints: const BoxConstraints.tightFor(
                          width: 60,
                          height: 60,
                        ),
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                              // border: Border(
                              //   top: BorderSide(width: 2, color: Colors.white),
                              //   right:
                              //       BorderSide(width: 2, color: Colors.white),
                              //   bottom:
                              //       BorderSide(width: 2, color: Colors.white),
                              //   left: BorderSide(width: 2, color: Colors.white),
                              // )
                            ),
                        ),
                      ),

                      // select video
                      const Icon(Icons.sign_language, size: 30)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
