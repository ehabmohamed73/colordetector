import 'package:colordetector/views/camera_view.dart';
import 'package:flutter/material.dart';

void main() async {
  // Make sure to initialize the camera plugin
  WidgetsFlutterBinding.ensureInitialized();

  // Start the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraView(),
    );
  }
}
