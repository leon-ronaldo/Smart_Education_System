import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(fontFamily: 'poppins'),
    ),
  );
}

String formatDateTime(String dateTimeString) {
  final DateTime dateTime = DateTime.parse(dateTimeString);

  final List<String> monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  final day = dateTime.day.toString().padLeft(2, '0');
  final monthName = monthNames[dateTime.month - 1];
  final year = dateTime.year;

  return "$day $monthName, $year";
}
