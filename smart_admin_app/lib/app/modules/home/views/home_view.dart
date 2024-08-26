import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:smart_admin_app/main.dart';

import '../controllers/home_controller.dart';

const colors = [
  Color(0xfff9e9c8),
  Color(0xffdeeced),
  Color(0xffdeecdd),
  Color(0xffddd2fd)
];

const Map<String, Color> gradeColors = {
  'I': Color(0xfff5e6c2), // Grade 1: Creamy Beige
  'II': Color(0xfff29e72), // Grade 2: Peach
  'III': Color(0xffd9e9c8), // Grade 3: Light Green
  'IV': Color(0xffc5e6d7), // Grade 4: Pastel Green
  'V': Color(0xfff2e3d3), // Grade 5: Soft Pink
  'VI': Color(0xffd9e9c8), // Grade 6: Light Green
  'VII': Color(0xfff29e72), // Grade 7: Peach
  'VIII': Color(0xffc5e6d7), // Grade 8: Pastel Green
  'IX': Color(0xfff5e6c2), // Grade 9: Creamy Beige
  'X': Color(0xfff29e72), // Grade 10: Peach
  'XI': Color(0xffd9e9c8), // Grade 11: Light Green
  'XII': Color(0xffc5e6d7), // Grade 12: Pastel Green
};

//bottom margin based spacing

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        color: Color(0xfffffdfc),
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavBar(
                profileUrl: controller.data['profileUrl'].toString(),
              ),
              HomePageHeroSection(),
              HomePageClassRoomsSection()
            ],
          ),
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  NavBar({super.key, required this.profileUrl});

  String profileUrl;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
        margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Smart Education',
              style: TextStyle(fontSize: screenSize.width * 0.05),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(profileUrl),
              backgroundColor: Colors.grey.shade200,
            )
          ],
        ));
  }
}

class HomePageHeroSection extends GetWidget<HomeController> {
  const HomePageHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationData = (controller.data['notifications'] as List);
    int colorCounter = -1;
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width,
      margin: const EdgeInsets.only(bottom: 30, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenSize.width * 0.5,
            child: Text(
              controller.data['institutionName'].toString(),
              style: TextStyle(
                  fontSize: screenSize.width * 0.04,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            width: screenSize.width * 0.65,
            child: Text(
              'Recent Notifications (${notificationData.length >= 5 ? '5+' : notificationData.length.toString()})',
              style: TextStyle(
                  fontSize: screenSize.width * 0.08,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.28,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount:
                    notificationData.length >= 5 ? 5 : notificationData.length,
                itemBuilder: (context, index) {
                  colorCounter++;
                  if (colorCounter == 3) colorCounter == 0;
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: double.infinity,
                    width: screenSize.width * 0.6,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: colors[colorCounter],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const Icon(
                                      Icons.calendar_month,
                                      color: Colors.black87,
                                      size: 20,
                                    )),
                                Text(formatDateTime(
                                    notificationData[index]['triggeredOn'])),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5000))),
                              child: const Icon(
                                Icons.arrow_outward,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notificationData[index]['type'],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: screenSize.width * 0.07),
                              ),
                              Text(
                                notificationData[index]['classRoom'],
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: screenSize.width * 0.05),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class HomePageClassRoomsSection extends GetWidget<HomeController> {
  const HomePageClassRoomsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final classRooms = controller.data['classRooms'] as List;
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenSize.width * 0.6,
                  child: Text(
                    'Class Room Management',
                    style: TextStyle(
                        fontSize: screenSize.width * 0.075,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5000))),
                  child: const Icon(
                    Icons.add,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: classRooms.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Container(
                  height: screenSize.height * 0.1,
                  decoration: BoxDecoration(
                      color: gradeColors[classRooms[index]['grade']],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black54),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5000))),
                                  child: const Icon(
                                    Icons.arrow_outward,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    classRooms[index]['class'],
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: screenSize.width * 0.05),
                                  ),
                                  Text(
                                    'Mentor : ${classRooms[index]['mentor']}',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: screenSize.width * 0.04),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: -screenSize.width * 0.05,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/badge-icon.svg',
                              height: screenSize.width * 0.27,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                classRooms[index]['grade'],
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.1,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
