import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screen_Helper/ChatScreens/chat_member.dart';
import 'package:penny_chats/views/Screen_Helper/ChatScreens/chat_room.dart';

class Chat extends StatefulWidget {
  Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.POST_BACKGROUND_COLOR,
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
                  color: AppColors.POST_TAB_BACKGROUND_COLOR,
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.POST_SELECT_TAB_COLOR,
                  ),
                  unselectedLabelColor: AppColors.POST_SELECT_TAB_COLOR,
                  tabs: [
                    Tab(
                      text: 'MEMBERS',
                    ),
                    Tab(
                      text: 'PERSONAL',
                    ),
                    Tab(
                      text: 'FAVOURITE',
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
                height: double.infinity,
                child: TabBarView(
                  children: [
                    ChatMember(),
                    ChatMember(),
                    ChatMember(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
            onPressed: () {
              // Add your onPressed code here!
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatRoom()));
            },
            label: Text(
              'Start Discussion',
              style: GoogleFonts.openSans(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            // icon: const Icon(Icons.thumb_up),
            backgroundColor: AppColors.LOGIN_PAGE_LOGINBOX),
      ),
    );
  }
}
