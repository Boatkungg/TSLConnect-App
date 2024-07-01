import "package:flutter/material.dart";
import "package:camera/camera.dart";
import "package:image_picker/image_picker.dart";
import "package:myapp/functions/uploader.dart";

//import "package:http/http.dart" as http;

late List<CameraDescription> cameras;

class Sign2Thai extends StatefulWidget {
  const Sign2Thai(
      {
      // required this.cameras,
      super.key});

  // final List<CameraDescription> cameras;

  @override
  State<Sign2Thai> createState() => _Sign2ThaiState();
}

class _Sign2ThaiState extends State<Sign2Thai> {
  late CameraController camController;
  final ImagePicker picker = ImagePicker();
  // late Future<void> camFuture;
  late String filePath;
  int cameraIndex = 0;
  int cameraCount = 0;
  bool isRecording = false;
  bool isProcessing = false;

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
      // camController.dispose();
      // initCamera(camera);
    });
  }

  // void initCamera(CameraDescription camera) async {
  //   camController =
  //       CameraController(camera, ResolutionPreset.max, enableAudio: false);
  //   camFuture = camController.initialize();
  // }

  void switchCamera() {
    if (cameraIndex < cameraCount - 1) {
      cameraIndex++;
    } else {
      cameraIndex = 0;
    }
    camController.setDescription(cameras[cameraIndex]);
  }

  void recordVideo() async {
    if (isProcessing) {
      return;
    }
    if (!isRecording) {
      await camController.prepareForVideoRecording();
      await camController.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } else {
      final file = await camController.stopVideoRecording();
      filePath = file.path;
      final translation = await getTranslation(filePath);
      displayTranslation(translation);
      print(filePath);
      setState(() {
        isRecording = false;
      });
    }
  }

  void selectVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      filePath = pickedFile.path;
      final translation = await getTranslation(filePath);
      displayTranslation(translation);
    }
  }

  Future<String> getTranslation(String videoPath) async {
    setState(() {
      isProcessing = true;
    });
    const translation = "asasdasdasd";
    // sleep
    await Future.delayed(const Duration(seconds: 2));
    //final translation = await uploadVideo(videoPath);
    setState(() {
      isProcessing = false;
    });
    print(translation);
    return translation;
  }

  void displayTranslation(String translation) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: SelectableText(
                        translation,
                        style: const TextStyle(fontSize: 20),
                        maxLines: 6,
                      ))
                ],
              ));
        });
  }

  @override
  void initState() {
    super.initState();
    cameraCount = cameras.length;
    print(cameraCount);
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
          // FutureBuilder(
          //   future: camFuture,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       return SizedBox(
          //         width: MediaQuery.of(context).size.width,
          //         height: MediaQuery.of(context).size.height,
          //         child: CameraPreview(camController),
          //       );
          //     }else {
          //       return const Center(child: CircularProgressIndicator());
          //     }
          //   },
          // ),
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
                          onPressed: recordVideo,
                          shape: const CircleBorder(),
                          fillColor: Colors.white,
                          padding: const EdgeInsets.all(5),
                          enableFeedback: false,
                          constraints: const BoxConstraints.tightFor(
                            width: 70,
                            height: 70,
                          ),
                          child: !isProcessing
                              ? AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  alignment: Alignment.center,
                                  width: !isRecording ? 60 : 30,
                                  height: !isRecording ? 60 : 30,
                                  decoration: BoxDecoration(
                                    // circle box hack
                                    borderRadius: !isRecording
                                        ? BorderRadius.circular(30)
                                        : BorderRadius.circular(5),
                                    color: Colors.red,
                                  ))
                              : const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.red))),

                      // select video
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(176, 255, 255, 255),
                        ),
                        child: IconButton(
                          onPressed: selectVideo,
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(
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
