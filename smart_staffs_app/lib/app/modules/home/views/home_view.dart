import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

//bottom margins for all widgets

const primaryPurple = Color(0xff6255fa);

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 227, 239, 255),
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            children: [HomePageHeaderSection(title: 'Teaching', subtitle: 'Teach with the power of technology'), HomePageCarouselSection()],
          ),
        ),
      ),
    );
  }
}

class HomePageHeaderSection extends StatelessWidget {
  HomePageHeaderSection({super.key, required this.title, required this.subtitle});

  String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      width: screenSize.width,
      height: screenSize.height * 0.18,
      decoration: const BoxDecoration(
          color: primaryPurple,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: screenSize.width * 0.08, color: Colors.white)),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(subtitle,
                style: TextStyle(
                    fontSize: screenSize.width * 0.04, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class HomePageCarouselSection extends GetWidget<HomeController> {
  const HomePageCarouselSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 15, left: 10),
      height: screenSize.height * 0.05,
      width: screenSize.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Obx(
              () => Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5000)),
                    color: controller.carouselIndex.value == index
                        ? primaryPurple
                        : Colors.white),
                child: Text(
                    [
                      'All',
                      'Guidelines',
                      'Students Analysis',
                      'Attendance'
                    ][index],
                    style: TextStyle(
                        fontSize: screenSize.width * 0.028,
                        color: controller.carouselIndex.value == index
                            ? Colors.white
                            : null)),
              ),
            );
          }),
    );
  }
}
