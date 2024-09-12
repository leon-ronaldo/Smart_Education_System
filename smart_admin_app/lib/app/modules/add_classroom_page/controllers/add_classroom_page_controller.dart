import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddClassroomPageController extends GetxController {
  final profileUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Harvard_University_coat_of_arms.svg/640px-Harvard_University_coat_of_arms.svg.png';
  final instituionAcronym = 'snsct';

  final gradeController = TextEditingController().obs;
  final classController = TextEditingController().obs;
  final classIDController = TextEditingController().obs;
  final classMentorController = TextEditingController();
  final classFireIDController = TextEditingController();
  final classSmartBoardIDController = TextEditingController();
  final classNoiseIDController = TextEditingController();

  RxInt gradeCounter = 1.obs;

  Map<int, String> romanNumerals = {
    1: 'I',
    2: 'II',
    3: 'III',
    4: 'IV',
    5: 'V',
    6: 'VI',
    7: 'VII',
    8: 'VIII',
    9: 'IX',
    10: 'X',
    11: 'XI',
    12: 'XII',
  };

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeClassId() {
    classIDController.value.text =
        '$instituionAcronym${romanNumerals[gradeCounter.value]}${classController.value.text.toLowerCase().removeAllWhitespace}';
  }

  Future<void> createClassRoom() async {
    if (classController.value.text == "" ||
        gradeController.value.text == "" ||
        classMentorController.text == "") {
      Get.snackbar('Warning', 'Fill Required Fields');
      return;
    }

    final response =
        await http.post(Uri.parse('https://smart-education-system.onrender.com/classRoom/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'classRoomID': classIDController.value.text,
              'grade': gradeCounter.value,
              'class': classController.value.text,
              'collegeCode': 'snsct',
              'mentor': classMentorController.text,
              'smartBoardID': classSmartBoardIDController.text,
              'noiseControllerID': classNoiseIDController.text,
              'fireSensorID': classFireIDController.text,
            }));

    if (response.statusCode == 200) {
      print('success');
    } else {
      print(response.body);
    }
  }
}
