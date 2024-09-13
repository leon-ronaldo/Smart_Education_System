import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_staffs_app/main.dart';

class RegisterPageController extends GetxController {
  Rx<PageController> pageController = PageController().obs;
  RxInt currentPage = 0.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final staffIDController = TextEditingController();
  final ageController = TextEditingController()..text = '24';
  final bDayController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final departmentController = TextEditingController();
  final mentorClassController = TextEditingController();

  RxBool success = false.obs;

  RxBool ready = false.obs;
  RxString filePath = "".obs;
  RxString fileSize = "".obs;

  RxString selectedClassCode = "".obs;

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
        await http.get(Uri.parse('http://10.0.2.2:5000/classRoom/'));
    classRooms.value = jsonDecode(response.body);
    classRoomsThatAppear.value = classRooms.value;
    print(classRooms);
    ready.value = true;
  }

  Future<void> pickFileFromDevice() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null &&
          (result.files.single.extension == 'jpg' ||
              result.files.single.extension == 'jpeg' ||
              result.files.single.extension == 'png' ||
              result.files.single.extension == 'pdf')) {
        filePath.value = result.files.single.path!;
        fileSize.value =
            (result.files.single.size / 1048576).toDouble().toStringAsFixed(2);
      }

      if (result != null &&
          !(result.files.single.extension == 'jpg' ||
              result.files.single.extension == 'jpeg' ||
              result.files.single.extension == 'png' ||
              result.files.single.extension == 'pdf')) {
        Get.snackbar('Info', 'Only PDF, JPG, and PNG formats are allowed.');
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  void removeFile() {
    filePath.value = '';
    fileSize.value = '';
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
      final staffData = {
        'staffID': staffIDController.text,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'age': ageController.text,
        'dateOfBirth': bDayController.text,
        'gender': genderController.text,
        'department': departmentController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'mentoringClass': mentorClassController.text,
      };

      // Create a multipart request object
      final multipartRequest = http.MultipartRequest(
          'POST', Uri.parse('http://10.0.2.2:5000/staffs/'));

      print(filePath.value);

      //send file
      multipartRequest.files
          .add(await http.MultipartFile.fromPath('timeTable', filePath.value));

      // Add text fields to the request
      multipartRequest.fields.addAll(staffData);

      // Send the request
      final response = await multipartRequest.send();

      // Handle the response
      if (response.statusCode == 200) {
        print('Staff profile created successfully.');
        success.value = true;
      } else {
        print('Error creating staff profile: ${response.reasonPhrase}');
      }
    } on Exception catch (e) {
      // TODO
    }
  }
}
