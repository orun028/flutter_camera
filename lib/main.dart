import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CameraController controller;
  bool isInitialized = false;

  Future<void> _initializeController() async {
    if (cameras.isEmpty) return;
    controller = CameraController(cameras[1], ResolutionPreset.high);
    await controller.initialize();
    setState(() {
      isInitialized = controller.value.isInitialized;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: isInitialized ? CameraPreview(controller) : Container(),
        ));
  }
}
