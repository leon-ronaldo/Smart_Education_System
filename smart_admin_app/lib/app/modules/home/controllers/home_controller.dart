import 'package:get/get.dart';

class HomeController extends GetxController {
  final data = {
    'profileUrl':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Harvard_University_coat_of_arms.svg/640px-Harvard_University_coat_of_arms.svg.png',
    'institutionName': 'Harvard University',
    'notifications': [
      {
        'type': 'Fire Alarm Trigger',
        'triggeredOn': DateTime.now().toIso8601String(),
        'classRoom': 'III CSE B'
      },
      {
        "type": "Fire Alarm Trigger",
        "triggeredOn": "2024-08-25T15:00:00Z",
        "classRoom": "II ECE A"
      },
      {
        "type": "Temperature Sensor Alert",
        "triggeredOn": "2024-08-25T15:00:00Z",
        "classRoom": "Cafeteria",
        "temperature": 28.5
      }
    ],
    'classRooms': [
      {
        "classRoomId": "3cseb",
        "class": "III CSE B",
        "grade": "III",
        "mentor": "staffID",
      },
      {
        "classRoomId": "3cseb",
        "class": "II CSE B",
        "grade": "II",
        "mentor": "staffID",
      },
      {
        "classRoomId": "3cseb",
        "class": "IX AIML B",
        "grade": "IX",
        "mentor": "staffID",
      },
      {
        "classRoomId": "3cseb",
        "class": "VII ECE D",
        "grade": "VII",
        "mentor": "staffID",
      },
      {
        "classRoomId": "3cseb",
        "class": "X IT A",
        "grade": "X",
        "mentor": "staffID",
      }
    ]
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
}
