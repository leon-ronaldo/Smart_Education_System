import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:smart_staffs_app/main.dart';

import '../controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        color: const Color(0xfff3f3f4),
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Obx(() {
              if (controller.success.value) {
                Future.delayed(const Duration(milliseconds: 1500),
                    () => Get.toNamed('/home'));
              }
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 500),
                crossFadeState: controller.success.value
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                secondChild: Container(
                  color: const Color(0xffffffff),
                  height: screenSize.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: screenSize.height * 0.3,
                          width: screenSize.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://cdn.dribbble.com/users/1363231/screenshots/8052893/media/bc537a463af4ec5e78ec5082a9277adb.png?resize=1000x750&vertical=center'),
                                  fit: BoxFit.cover))),
                      Text('Hello ${controller.firstNameController.text}',
                          style: TextStyle(
                              height: 2,
                              fontSize: screenSize.width * 0.045,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold)),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            'Explore Our App And Experience The Best Teaching Experience Ever...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                firstChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: screenSize.width,
                        height: screenSize.height * 0.7,
                        child: PageView(
                            controller: controller.pageController.value,
                            children: [
                              RegisterPageHeroImage(),
                              RegisterPageStudentGeneralDetailsSection(),
                              RegisterPagePersonalDetailsSection(),
                              RegisterPageClassAndPhotoDetailsSection()
                            ])),
                    RegisterPageNextButtons()
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class RegisterPageNextButtons extends GetWidget<RegisterPageController> {
  const RegisterPageNextButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: screenSize.height * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: index == controller.currentPage.value
                      ? screenSize.width * 0.1
                      : 3,
                  height: 3,
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5000))),
                ),
              );
            }),
          ),
        ),
        Obx(
          () => InkResponse(
            onTap: controller.currentPage.value == 3
                ? () {
                    controller.register();
                  }
                : () {
                    controller.pageController.value.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
            child: Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: screenSize.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                            offset: const Offset(0, 4),
                            color: Colors.grey.shade200,
                            blurRadius: 3)
                        .scale(3)
                  ]),
              child: Obx(
                () => Text(
                  controller.currentPage.value == 0
                      ? 'Get Started'
                      : controller.currentPage.value == 3
                          ? 'Submit'
                          : 'Next',
                  style: TextStyle(fontSize: screenSize.width * 0.04),
                ),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: controller.currentPage.value == 0 ? 1.0 : 0.0,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Text(
                    'Already Have An Account?',
                    style: TextStyle(fontSize: screenSize.width * 0.03),
                  ),
                ),
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: screenSize.width * 0.03,
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blueAccent),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class RegisterPageHeroImage extends GetWidget<RegisterPageController> {
  const RegisterPageHeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          height: screenSize.height * 0.3,
          width: screenSize.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/hero-1.png"),
                  fit: BoxFit.fitWidth)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(top: 20),
          child: Text(
            'Your window into your immersive learning experience with technology.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: screenSize.width * 0.05),
          ),
        ),
      ],
    );
  }
}

class RegisterPageStudentGeneralDetailsSection
    extends GetWidget<RegisterPageController> {
  const RegisterPageStudentGeneralDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(6, (index) {
          if (index == 5) {
            return Container(
              margin: const EdgeInsets.only(top: 5),
              width: screenSize.width,
              alignment: Alignment.center,
              child: Text(
                'Fill Up Your General Details',
                style: TextStyle(fontSize: screenSize.width * 0.04),
              ),
            );
          }

          if (index == 4) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Class',
                      style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                  TextField(
                      onChanged: (text) =>
                          controller.filterClassRooms(text.toLowerCase()),
                      controller: controller.mentorClassController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))))),
                  Container(
                    height: screenSize.height * 0.11,
                    width: screenSize.width,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: SingleChildScrollView(
                        child: Obx(
                      () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              controller.classRoomsThatAppear.length, (index) {
                            return InkResponse(
                              onTap: () {
                                controller.mentorClassController.text =
                                    '${controller.classRoomsThatAppear.value[index]['collegeCode']} ${romanNumerals[controller.classRoomsThatAppear.value[index]['grade']]} ${controller.classRoomsThatAppear.value[index]['section']}';
                                controller.selectedClassCode.value = controller
                                    .classRoomsThatAppear
                                    .value[index]['classRoomID'];
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                    '${controller.classRoomsThatAppear.value[index]['collegeCode']} ${romanNumerals[controller.classRoomsThatAppear.value[index]['grade']]} ${controller.classRoomsThatAppear.value[index]['section']}',
                                    style: TextStyle(
                                        fontSize: screenSize.width * 0.035,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                              ),
                            );
                          })),
                    )),
                  )
                ],
              ),
            );
          }

          if (index == 2) {
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: List.generate(2, (classSelctionIndex) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ['Staff ID', 'Age'][classSelctionIndex],
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  maxLength: classSelctionIndex == 1 ? 5 : null,
                                  controller: [
                                    controller.staffIDController,
                                    controller.ageController
                                  ][classSelctionIndex],
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
                                      counterText: '',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)))),
                                ),
                              ),
                              if (classSelctionIndex == 1)
                                Column(
                                  children: List.generate(2, (suffixIndex) {
                                    return Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        padding: const EdgeInsets.all(3),
                                        color: Colors.grey.shade200,
                                        child: InkResponse(
                                          onTap: () {
                                            int age = int.parse(
                                                controller.ageController.text);
                                            if (suffixIndex == 0 &&
                                                (!(age >= 27))) {
                                              controller.ageController.text =
                                                  '${age + 1}';
                                            }
                                            if (suffixIndex == 1 &&
                                                !(age <= 16)) {
                                              controller.ageController.text =
                                                  '${age - 1}';
                                            }
                                          },
                                          child: Icon(
                                            [
                                              Icons.keyboard_arrow_up,
                                              Icons.keyboard_arrow_down
                                            ][suffixIndex],
                                            size: 18,
                                          ),
                                        ));
                                  }),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    [
                      'First Name',
                      'Last Name',
                      null,
                      'Date Of Birth',
                      'Class',
                      null
                    ][index]
                        .toString(),
                    style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold)),
                TextField(
                    controller: [
                      controller.firstNameController,
                      controller.lastNameController,
                      null,
                      controller.bDayController,
                      controller.mentorClassController,
                      null
                    ][index],
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5))))),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class RegisterPagePersonalDetailsSection
    extends GetWidget<RegisterPageController> {
  const RegisterPagePersonalDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: List.generate(5, (index) {
          if (index == 0) {
            return Container(
              height: screenSize.height * 0.3,
              width: screenSize.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/hero-2.png"),
                      fit: BoxFit.fitHeight)),
            );
          }

          if (index == 1) {
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: List.generate(2, (classSelctionIndex) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ['Phone', 'Gender'][classSelctionIndex],
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  maxLength: classSelctionIndex == 1 ? 5 : null,
                                  controller: [
                                    controller.phoneController,
                                    controller.genderController
                                  ][classSelctionIndex],
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
                                      counterText: '',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)))),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          }

          if (index == 4) {
            return Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                width: screenSize.width,
                child: Text(
                  'Fill Up Your Personal Details',
                  style: TextStyle(fontSize: screenSize.width * 0.04),
                ));
          }

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    [null, null, 'Email', 'Department', null][index].toString(),
                    style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold)),
                TextField(
                    controller: [
                      null,
                      null,
                      controller.emailController,
                      controller.departmentController,
                      null
                    ][index],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 10, top: index == 3 ? 15 : 0.0),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5))))),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class RegisterPageClassAndPhotoDetailsSection
    extends GetWidget<RegisterPageController> {
  const RegisterPageClassAndPhotoDetailsSection({super.key});

  final pdfSvg = 'assets/icons/pdf-icon.svg';
  final jpgSvg = 'assets/icons/jpg-icon.svg';
  final pngSvg = 'assets/icons/png-icon.svg';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: screenSize.height * 0.3,
          margin: EdgeInsets.only(top: screenSize.height * 0.08),
          width: screenSize.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/time-table.png"),
                  fit: BoxFit.fitHeight)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25),
          alignment: Alignment.center,
          width: screenSize.width,
          child: Text(
            'Upload Your Time Table',
            style: TextStyle(fontSize: screenSize.width * 0.04),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: screenSize.width,
          child: Text(
            'Capture a picture of your time table to schedule it in the app.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: screenSize.width * 0.032),
          ),
        ),
        Obx(
          () => Container(
              child: controller.filePath.value == ""
                  ? InkResponse(
                      onTap: () => controller.pickFileFromDevice(),
                      child: Container(
                        margin: EdgeInsets.only(top: screenSize.height * 0.04),
                        alignment: Alignment.center,
                        width: screenSize.width,
                        child: Text(
                          '+',
                          style: TextStyle(fontSize: screenSize.width * 0.15),
                        ),
                      ),
                    )
                  : Obx(() => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 18),
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(
                          20, screenSize.height * 0.05, 20, 0),
                      width: screenSize.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey.shade300,
                          boxShadow: [
                            BoxShadow(
                                    offset: const Offset(0, 4),
                                    color: Colors.grey.shade200,
                                    blurRadius: 3)
                                .scale(3)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: SvgPicture.asset(
                                      controller.filePath.contains('png')
                                          ? pngSvg
                                          : controller.filePath.contains('jpg')
                                              ? jpgSvg
                                              : pdfSvg,
                                      height: screenSize.width * 0.08,
                                      width: screenSize.width * 0.08)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.filePath.value.split('/')[
                                        controller.filePath.value
                                                .split('/')
                                                .length -
                                            1],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: screenSize.width * 0.032),
                                  ),
                                  Text(
                                    '${controller.fileSize.value} mb',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: screenSize.width * 0.028),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkResponse(
                              onTap: () => controller.removeFile(),
                              child: Icon(Icons.close))
                        ],
                      )))),
        )
      ],
    );
  }
}
