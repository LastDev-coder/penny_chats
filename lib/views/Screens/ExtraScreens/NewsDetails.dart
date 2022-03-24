import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

class NewsDetails extends StatefulWidget {
  final id, title, content, time;
  const NewsDetails(
      {Key? key,
      required this.id,
      required this.title,
      required this.content,
      required this.time})
      : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
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
        title: Text(widget.id == "2"
            ? "Penny Stocks To Watch"
            : (widget.id == "3" ? "Penny Stocks Help" : "Upcoming IPO Stocks")),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              child: Text(
                "${widget.title}",
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white70 :AppColors.PROFILE_TAB_NORMAL_TEXT,
                    fontFamily: 'Gotham',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0, left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "by PennyChats",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        "${widget.time}",
                        style: TextStyle(
                            color: AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                            fontFamily: 'Gotham',
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 10),
              child: Text(
                "${widget.content}",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color:Get.isDarkMode ? Colors.white38 : AppColors.POST_TAB_COMMENTS_COLOR,
                  fontFamily: 'Gotham',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
