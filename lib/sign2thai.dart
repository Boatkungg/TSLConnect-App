import "package:flutter/material.dart";
import "package:camera/camera.dart";
//import "package:http/http.dart" as http;

late List<CameraDescription> cameras;

class Sign2Thai extends StatefulWidget {
  const Sign2Thai({
    // required this.cameras, 
    super.key
    });

  // final List<CameraDescription> cameras;

  @override
  State<Sign2Thai> createState() => _Sign2ThaiState();
}

class _Sign2ThaiState extends State<Sign2Thai> {
  int cameraIndex = 0;
  int cameraCount = 0;
  late CameraController camController;

  void initCamera(CameraDescription camera) async {
    camController =
        CameraController(camera, ResolutionPreset.max, enableAudio: false);
    await camController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print('Error initializing camera: $e');
      camController.dispose();
      initCamera(camera);
    });
  }

  void switchCamera() {
    if (cameraIndex < cameraCount - 1) {
      cameraIndex++;
    } else {
      cameraIndex = 0;
    }
    camController.setDescription(cameras[cameraIndex]);
  }

  @override
  void initState() {
    super.initState();
    cameraCount = cameras.length;
    initCamera(cameras[cameraIndex]);
  }

  @override
  void dispose() {
    super.dispose();
    camController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                    children: [
                      // change camera
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(176, 255, 255, 255),
                        ),
                        child: IconButton(
                          onPressed: switchCamera,
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(
                            Icons.cameraswitch,
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                      ),

                      // record
                      RawMaterialButton(
                        onPressed: null,
                        shape: const CircleBorder(),
                        fillColor: Colors.white,
                        constraints: const BoxConstraints.tightFor(
                          width: 70,
                          height: 70,
                        ),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      ),

                      // select video
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(176, 255, 255, 255),
                        ),
                        child: const IconButton(
                          onPressed: null,
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.add_photo_alternate,
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                      ),
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
