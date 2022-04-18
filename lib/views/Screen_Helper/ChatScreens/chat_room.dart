import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  AppColors.REGISTER_PAGE_APPBAR_G1,
                  AppColors.REGISTER_PAGE_APPBAR_G2
                ])),
          ),
          title: Column(
            children: [
              Text(
                'CHAT ROOM',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white,
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '( 30 members onine )',
                style: GoogleFonts.openSans(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, 'back');
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.chevron_left),
                Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Badge(
              position: BadgePosition.topEnd(top: -20),
              child: SvgPicture.asset(
                "assets/icon/search.svg",
                height: 20,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Badge(
              position: BadgePosition.topEnd(top: 5, end: -5),
              badgeContent: Text(
                '20',
                style: TextStyle(
                  fontSize: 7.93,
                  color: AppColors.DASHBOARD_SELECTED_ICON_COLOR,
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.bold,
                ),
              ),
              badgeColor: AppColors.white,
              child: SvgPicture.asset(
                "assets/icon/bell.svg",
                height: 25,
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Container(
          // color: AppColors.black12,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/chatroom.jpg',
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Divider(
                                thickness: 1,
                                color:
                                    AppColors.CHAT_ROOM_DATEOFMESSAGE_DIVIDER,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Today',
                            style: GoogleFonts.openSans(
                              color: AppColors.CHAT_ROOM_DATEOFMESSAGE,
                              fontSize: 14.11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Divider(
                                  color:
                                      AppColors.CHAT_ROOM_DATEOFMESSAGE_DIVIDER,
                                  thickness: 1,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://i1.wp.com/avatarfiles.alphacoders.com/206/206578.jpg'),
                                ),
                              ),
                            ),
                            Text(
                              '1.03 PM',
                              style: GoogleFonts.openSans(
                                color: AppColors.CHAT_ROOM_DATEOFMESSAGE,
                                fontSize: 10.59,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Thus much I thought proper to tell you in relation to yourself, and to the trust I responed in you',
                              style: TextStyle(
                                  fontSize: 14.09,
                                  color: AppColors.CHAT_SCREEN_BLACK_TEXT,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://pacelab.tech/wp-content/uploads/learn-press-profile/3/abaeb11ef7963388064b42315feb6984.jpg'),
                                ),
                              ),
                            ),
                            Text(
                              '3.08 PM',
                              style: GoogleFonts.openSans(
                                color: AppColors.CHAT_ROOM_DATEOFMESSAGE,
                                fontSize: 10.59,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Please send me the view.',
                              style: TextStyle(
                                  fontSize: 14.09,
                                  color: AppColors.CHAT_SCREEN_BLACK_TEXT,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    color:  Colors.black38,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Container(
                          color: AppColors.white,
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 4,
                            minLines: 1,
                            style: GoogleFonts.openSans(
                              color: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.send,
                                      size: 30,
                                      color:AppColors.LOGIN_PAGE_LOGINBOX,
                                    )),
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.emoji_emotions_outlined,
                                          size: 30,
                                          color: AppColors
                                              .CHAT_ROOM_INPUTFIELD_ICON_COLOR,
                                        )),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.attach_file,
                                          size: 30,
                                          color: AppColors
                                              .CHAT_ROOM_INPUTFIELD_ICON_COLOR,
                                        ))
                                  ],
                                ),
                                hintText: 'Type in your message...',
                                hintStyle: GoogleFonts.openSans(
                                  //color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding: EdgeInsets.all(5)),
                          )),
                    )),
              )
            ],
          ),
        ));
  }
}
