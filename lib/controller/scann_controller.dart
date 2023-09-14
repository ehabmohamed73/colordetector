import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  // late CameraImage cameraImage;
  var cameraCount = 0;
  var lable = "none";

  var isCameraInitialized = false.obs;

  initiTflite() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        isAsset: true,
        numThreads: 1,
        useGpuDelegate: false);
  }

  initialCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.max,
      );
      await cameraController
          .initialize()
          .then((value) => cameraController.startImageStream((image) {
                cameraCount++;
                if (cameraCount % 10 == 0) {
                  cameraCount = 0;
                  detecteColor(image);
                }
                update();
              }));
      isCameraInitialized(true);
      update();
    } else {
      print("permission denied");
    }
  }

  detecteColor(CameraImage image) async {
    var detector = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((e) => e.bytes).toList(),
      asynch: true,
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 1,
      rotation: 90,
      threshold: 0.4,
    );
    if (detector != null) {
      print(detector);
      lable = detector.first["label"].toString();

      update();
    }
  }

  @override
  void onInit() {
    initialCamera();
    initiTflite();
    super.onInit();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
