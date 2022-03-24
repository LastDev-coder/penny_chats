import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screen_Helper/PostScreens/FavouritePostScreen.dart';
import 'package:penny_chats/views/Screen_Helper/PostScreens/LatestPostScreen.dart';
import 'package:penny_chats/views/Screen_Helper/PostScreens/PopularPostScreen.dart';

class Post extends StatefulWidget {
  Post({Key? key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.POST_BACKGROUND_COLOR,
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Get.isDarkMode ? Colors.white24 : AppColors.POST_TAB_BACKGROUND_COLOR,
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.POST_SELECT_TAB_COLOR,
                  ),
                  unselectedLabelColor: AppColors.POST_SELECT_TAB_COLOR,
                  tabs: [
                    Tab(
                      text: 'LATEST',
                    ),
                    Tab(
                      text: 'POPULAR',
                    ),
                    Tab(
                      text: 'FAVOURITE',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                child: TabBarView(
                  children: [
                    LatestPostScreen(),
                    PopularPostScreen(),
                    FavouritePostScreen(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
