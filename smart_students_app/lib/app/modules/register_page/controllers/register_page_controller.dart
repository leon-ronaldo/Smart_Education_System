import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:smart_students_app/main.dart';

class RegisterPageController extends GetxController {
  Rx<PageController> pageController = PageController().obs;
  RxInt currentPage = 0.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final studentIDController = TextEditingController();
  final ageController = TextEditingController()..text = '16';
  final bDayController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final classRoomController = TextEditingController();

  RxBool success = false.obs;

  RxBool ready = false.obs;
  RxString firstfilePath = "".obs;
  RxString secondfilePath = "".obs;

  RxString selectedClassCode = "".obs;

  late CameraController cameraController;

  RxList classRooms = [].obs;
  RxList classRoomsThatAppear = [].obs;

  @override
  void onInit() {
    super.onInit();
    pageController.value.addListener(() {
      currentPage.value = (pageController.value.page ?? 0.0).toInt();
    });
    getClassRooms();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getClassRooms() async {
    final response =
        await http.get(Uri.parse('https://smart-education-system.onrender.com/classRoom/'));
    classRooms.value = jsonDecode(response.body);
    classRoomsThatAppear.value = classRooms.value;
    print(classRooms);
    ready.value = true;
  }

  void initCameras() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    print(cameras);

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras[1];

    cameraController =
        CameraController(firstCamera, ResolutionPreset.ultraHigh);

    await cameraController.initialize();

    cameraController.setZoomLevel(2);
    ready.value = true;
  }

  Future<void> pickFileFromGallery(filePath) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      filePath.value = image.path;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void filterClassRooms(text) {
    classRoomsThatAppear.value = [];
    classRooms.value.forEach((classRoom) {
      if ((romanNumerals[classRoom['grade']] ?? '').contains(text) ||
          classRoom['collegeCode'].contains(text) ||
          classRoom['section'].toString().toLowerCase().contains(text) ||
          classRoom['grade'].toString() == text) {
        classRoomsThatAppear.value.add(classRoom);
      }
    });
  }

  Future<void> register() async {
    try {
  final request = http.MultipartRequest(
      'POST', Uri.parse('https://smart-education-system.onrender.com/students/'));
  
  request.files
      .add(await http.MultipartFile.fromPath('file', firstfilePath.value));
  request.files.add(await 
      http.MultipartFile.fromPath('file', secondfilePath.value));
  
  request.fields['firstName'] = firstNameController.text;
  request.fields['lastName'] = lastNameController.text;
  request.fields['studentID'] = studentIDController.text;
  request.fields['age'] = ageController.text;
  request.fields['bDay'] = bDayController.text;
  request.fields['gender'] = genderController.text;
  request.fields['phone'] = phoneController.text;
  request.fields['email'] = emailController.text;
  request.fields['address'] = addressController.text;
  request.fields['classRoomID'] = selectedClassCode.value;
  
  final response = await request.send();
  
  if (response.statusCode == 200) {
    success.value = true;
  }
} on Exception catch (e) {
  // TODO
}
  }
}
