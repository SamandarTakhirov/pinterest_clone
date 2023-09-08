import 'package:flutter/material.dart';

import '../common/constants/app_color.dart';
import '../common/constants/app_icons.dart';
import 'main/added/added_page.dart';
import 'main/boards/boards_page.dart';
import 'main/home/home_page.dart';
import 'main/message/message_page.dart';
import 'main/profile_page/profile_page.dart';
import 'widgets/custom_button_icons.dart';

class CustomPageController extends StatefulWidget {
  const CustomPageController({Key? key}) : super(key: key);

  @override
  State<CustomPageController> createState() => _CustomPageControllerState();
}

class _CustomPageControllerState extends State<CustomPageController> {
  int pageIndex = 0;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void pageChange(int value) {
    pageController.jumpToPage(value);
    setState(() {
      pageIndex = value;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: pageChange,
        children: const [
          HomePage(),
          Boards(),
          AddedPage(),
          MessagePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.black,
        unselectedItemColor: AppColor.white,
        currentIndex: pageIndex,
        onTap: pageChange,
        unselectedLabelStyle: const TextStyle(
          color: AppColor.white,
          fontSize: 11,
        ),
        selectedLabelStyle: const TextStyle(
          color: AppColor.red,
          fontSize: 11,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        fixedColor: AppColor.red,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: CustomButtonIcons(image: AppIcons.icHome),
            label: "Home",
            activeIcon:
                CustomButtonIcons(image: AppIcons.icHome, isActive: true),
          ),
          const BottomNavigationBarItem(
            icon: CustomButtonIcons(image: AppIcons.icBoards),
            label: "Boards",
            activeIcon:
                CustomButtonIcons(image: AppIcons.icBoards, isActive: true),
          ),
          BottomNavigationBarItem(
            icon: DecoratedBox(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.red,
              ),
              child: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: CustomButtonIcons(image: AppIcons.icMessage),
            label: "Message",
            activeIcon:
                CustomButtonIcons(image: AppIcons.icMessage, isActive: true),
          ),
          const BottomNavigationBarItem(
            icon: CustomButtonIcons(image: AppIcons.icMessage),
            label: "Profile",
            activeIcon:
                CustomButtonIcons(image: AppIcons.icMessage, isActive: true),
          ),
        ],
      ),
    );
  }
}
