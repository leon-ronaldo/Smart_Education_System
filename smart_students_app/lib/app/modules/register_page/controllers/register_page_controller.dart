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

  RxBool canPop = true.obs;

  RxBool ready = false.obs;
  RxBool loading = false.obs;
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
      if (pageController.value.page! == 0) {
        canPop.value = true;
        print('connot pop now');
      }
      else {
        canPop.value = false;
        print('canpop now');
      }
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
        await http.get(Uri.parse('http://localhost:5000/classRoom/'));
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
loading.value = true;
  final request = http.MultipartRequest(
      'POST', Uri.parse('http://localhost:5000/students/'));
  
  request.files
      .add(await http.MultipartFile.fromPath('file', firstfilePath.value));
  request.files.add(await 
      http.MultipartFile.fromPath('file', secondfilePath.value));
  
  request.fields['firstName'] = firstNameController.text.trim();
  request.fields['lastName'] = lastNameController.text.trim();
  request.fields['studentID'] = studentIDController.text.trim();
  request.fields['age'] = ageController.text.trim();
  request.fields['bDay'] = bDayController.text.trim();
  request.fields['gender'] = genderController.text.trim();
  request.fields['phone'] = phoneController.text.trim();
  request.fields['email'] = emailController.text.trim();
  request.fields['address'] = addressController.text.trim();
  request.fields['classRoomID'] = selectedClassCode.value;
  
  final response = await request.send();
  
  if (response.statusCode == 200) {
    success.value = true;
    loading.value = false;
  }
} on Exception catch (e) {
  print(e);
}
  }
}
