import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AttendancePageController extends GetxController {
  final classID = 'harvIIIcseb';

  RxBool ready = false.obs;
  RxBool error = false.obs;
  RxMap classData = {}.obs;
  RxBool cameraOpened = false.obs;
  RxBool previewImage = false.obs;
  late RxString capturedImagePath = ''.obs;

  late CameraController cameraController;

  @override
  void onInit() {
    super.onInit();
    initCameras();
    getClass();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    cameraController.dispose();
  }

  Future<void> getClass() async {
    final result =
        await http.get(Uri.parse('http://10.0.2.2:5000/classRoom/${classID}'));

    if (result.statusCode == 404) {
      print('cannot get class');
      error.value = true;
      return;
    }

    classData.value = jsonDecode(result.body);
  }

  void initCameras() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    print(cameras);

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras[0];

    cameraController =
        CameraController(firstCamera, ResolutionPreset.ultraHigh);

    await cameraController.initialize();
    ready.value = true;
  }

  Future<void> uploadImage() async {
    final request = http.MultipartRequest('POST',
        Uri.parse('http://10.0.2.2:5000/classRoom/$classID/addAttendance'));

    request.files.add(await http.MultipartFile.fromPath(
        'picture', capturedImagePath.value));

    final response = await request.send();
  }
}
