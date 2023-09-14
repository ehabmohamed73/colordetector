import 'package:camera/camera.dart';
import 'package:colordetector/controller/scann_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraView extends StatelessWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: GetBuilder<ScannController>(
        init: ScannController(),
        builder: (controller) {
          return controller.isCameraInitialized.value
              ? Stack(
                  children: [
                    CameraPreview(controller.cameraController),
                    Positioned(
                      top: MediaQuery.of(context).size.height - 50,
                      right: 0,
                      child: Container(
                          padding: EdgeInsets.only(top: 20),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            textAlign: TextAlign.center,
                            "${controller.lable}",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                )
              : const Center(child: Text("Loading Preview..."));
        },
      ),
    ));
  }
}
