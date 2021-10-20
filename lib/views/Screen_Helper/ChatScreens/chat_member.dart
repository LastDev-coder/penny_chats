import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screen_Helper/ChatScreens/chat_room_personal.dart';

class ChatMember extends StatefulWidget {
  ChatMember({Key? key}) : super(key: key);

  @override
  _ChatMemberState createState() => _ChatMemberState();
}

class _ChatMemberState extends State<ChatMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.POST_BACKGROUND_COLOR,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0.00),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatRoomPersonal()));
            },
            // splashColor: colors.DASHBOARD_SELECTED_ICON_COLOR,
            child: Container(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'YESTERDAY',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 10.57,
                          color: AppColors.CHAT_SCREEN_TIME_COLOR,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  'https://i1.wp.com/avatarfiles.alphacoders.com/206/206578.jpg'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    'Tanufriya Sakila',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.LOGIN_PAGE_LOGINBOX,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Thus much I thought proper to tell you in relation to yourself,and ...',
                                        style: TextStyle(
                                            fontSize: 14.09,
                                            color: AppColors
                                                .CHAT_SCREEN_BLACK_TEXT,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(
                                      'assets/icon/elipsis.svg',
                                      color: AppColors.CHAT_SCREEN_ICON,
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
