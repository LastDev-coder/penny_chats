import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/Api/NotificationsApi.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/NotificationsModel.dart';
import 'package:readmore/readmore.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationsModel? _notificationsList;

  @override
  void initState() {
    NotificationsApi.getNotification(context, AppStrings.getNotificationApi)
        .then((value) {
      setState(() {
        _notificationsList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.white12 :AppColors.white,
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
        title: Text('NOTIFICATION'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, 'back');
          },
          child: Icon(
            Icons.chevron_left,
            size: 40,
          ),
        ),
      ),
      body: _notificationsList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Get.isDarkMode ? Colors.black12 :AppColors.NOTIFICATION_BLACKSHADE,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 30, bottom: 30),
                      child: Text('TODAY',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.LOGIN_PAGE_LOGINBOX,
                              fontFamily: 'Gotham',
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  ListView.builder(
                      itemCount: _notificationsList!.response!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var _notification =
                            _notificationsList!.response![index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('ⓘ',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color:Get.isDarkMode ? Colors.white : AppColors
                                                .LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.normal)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(_notification.topic.toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color:Get.isDarkMode ? Colors.white70 :
                                                AppColors.NOTIFICATION_HEADING,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                ReadMoreText(
                                    AppStrings.parseHtmlString(
                                        _notification.content.toString()),
                                    trimLines: 2,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:Get.isDarkMode ? Colors.white38 :
                                            AppColors.NOTIFICATION_NEWSDETAILS,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500),
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
