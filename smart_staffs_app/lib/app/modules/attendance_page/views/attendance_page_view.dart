import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:smart_staffs_app/app/modules/home/views/home_view.dart';
import 'package:smart_staffs_app/main.dart';

import '../controllers/attendance_page_controller.dart';

class AttendancePageView extends GetView<AttendancePageController> {
  const AttendancePageView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      //body
      body: Container(
        color: const Color.fromARGB(255, 235, 244, 255),
        width: screenSize.width,
        height: screenSize.height,
        child: Obx(
          () => Visibility(
            visible: controller.ready.value,
            replacement: const Center(
                child: SpinKitPouringHourGlassRefined(color: primaryPurple)),
            child: SingleChildScrollView(
              child: Obx(
                () => AnimatedCrossFade(
                    duration: const Duration(milliseconds: 800),
                    crossFadeState: controller.cameraOpened.value
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: AttendancePageAttendanceSection(),
                    secondChild: AttendancePageCameraSection()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AttendancePageNavbar extends GetWidget<AttendancePageController> {
  AttendancePageNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      height: screenSize.height * 0.35,
      margin: EdgeInsets.only(bottom: screenSize.height * 0.04),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.fromLTRB(20, screenSize.height * 0.08, 20, 20),
            width: screenSize.width,
            height: screenSize.height * 0.25,
            decoration: const BoxDecoration(
                color: primaryPurple,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Attendance',
                    style: TextStyle(
                        fontSize: screenSize.width * 0.08,
                        color: Colors.white)),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text('Take attendance like a snapshot',
                      style: TextStyle(
                          fontSize: screenSize.width * 0.04,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: screenSize.width,
              decoration: BoxDecoration(
                  boxShadow: [
                    const BoxShadow(
                            offset: Offset(0, 4),
                            color: Colors.black12,
                            blurRadius: 3)
                        .scale(3)
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Class',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.05,
                      )),
                  Container(
                    margin: const EdgeInsets.only(left: 2),
                    child: Text(
                        '${romanNumerals[controller.classData['grade']]} ${controller.classData['section']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.width * 0.035,
                        )),
                  ),
                  Row(
                    children: List.generate(
                        2,
                        (index) => Expanded(
                                child: InkResponse(
                              onTap: () {
                                controller.cameraOpened.value = true;
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: index == 0
                                    ? const EdgeInsets.only(right: 5, top: 10)
                                    : const EdgeInsets.only(left: 5, top: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                              offset: const Offset(0, 4),
                                              color: Colors.grey.shade200,
                                              blurRadius: 3)
                                          .scale(3)
                                    ],
                                    border: Border.all(
                                        color: [
                                      Colors.white,
                                      primaryPurple
                                    ][index]),
                                    color: [primaryPurple, Colors.white][index],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                child: Text(
                                    [
                                      'Capture Attendance',
                                      'Change Class'
                                    ][index],
                                    style: TextStyle(
                                        fontSize: screenSize.width * 0.03,
                                        color: [Colors.white, null][index])),
                              ),
                            ))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AttendancePageHeaderSection extends GetWidget<AttendancePageController> {
  const AttendancePageHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Attendance for this hour',
              style: TextStyle(
                fontSize: screenSize.width * 0.035,
              )),
          Text('Not Taken',
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
              )),
        ],
      ),
    );
  }
}

class AttendancePageAttendanceSection extends StatelessWidget {
  const AttendancePageAttendanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AttendancePageNavbar(),
      const AttendancePageHeaderSection()
    ]);
  }
}

class AttendancePageCameraSection extends GetWidget<AttendancePageController> {
  const AttendancePageCameraSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Obx(
      () => Visibility(
        visible: controller.previewImage.value,
        replacement: SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: OrientationBuilder(builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                        height: screenSize.height,
                        width: screenSize.width,
                        child: CameraPreview(controller.cameraController)),
                    Container(
                      margin: EdgeInsets.only(bottom: screenSize.height * 0.04),
                      child: FloatingActionButton(
                        onPressed: () async {
                          try {
                            controller.capturedImagePath.value =
                                (await controller.cameraController
                                        .takePicture())
                                    .path;
                            controller.previewImage.value = true;
                          } catch (e) {
                            print('bro error broo $e');
                          }
                        },
                        child: const Icon(Icons.camera_alt_rounded),
                      ),
                    )
                  ],
                );
              } else {
                return Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    SizedBox(
                        height: screenSize.height,
                        width: screenSize.width,
                        child: CameraPreview(controller.cameraController)),
                    Container(
                      margin: EdgeInsets.only(right: screenSize.height * 0.04),
                      child: FloatingActionButton(
                        onPressed: () async {
                          try {
                            controller.capturedImagePath.value =
                                (await controller.cameraController
                                        .takePicture())
                                    .path;
                            print(
                                'path bro ${controller.capturedImagePath.value}');
                            controller.previewImage.value = true;
                          } catch (e) {
                            print('bro error broo $e');
                          }
                        },
                        child: const Icon(Icons.camera_alt_rounded),
                      ),
                    )
                  ],
                );
              }
            })),
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              controller.previewImage.value = false;
            }
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: screenSize.width,
                height: screenSize.height,
                child: const Center(
                  child: SpinKitPouringHourGlassRefined(color: primaryPurple),
                ),
              ),
              SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Image.file(
                    File(controller.capturedImagePath.value),
                    fit: BoxFit.cover,
                  )),
              Container(
                margin: EdgeInsets.only(bottom: screenSize.height * 0.04),
                child: FloatingActionButton(
                  onPressed: () {
                    controller.uploadImage();
                  },
                  child: const Icon(Icons.upload),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
