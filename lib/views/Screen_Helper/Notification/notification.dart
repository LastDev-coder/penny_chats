import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/Api/NotificationsApi.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/NotificationsModel.dart';
import 'package:readmore/readmore.dart';

import '../../../ApiService/Apiservice.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationsModel? _notificationsList;

late String n_length;

  Future<bool> onDelete(int index, String nid) async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to delete this notification?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () async {

              var   data = await Apiservice().getDeleteNotification(nid);
              Navigator.of(context).pop(false);

           print("***********************-------------------"+data.toString());
              print("delete notification index no --> ${index.toString()}");
              print("notification id --> ${nid.toString()}");

if(data["status"].toString() == "true"){
  setState(() {
    _notificationsList!.response!.removeAt(index);
  });
  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
    content: new Text(
      data["response"].toString(),
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.green,
  ));


}
else{
  Navigator.of(context).pop(false);

  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
    content: new Text(
      data["response"].toString(),
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
  ));
}

            },
            child: Text('Yes'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }
  Future<bool> _willPopCallback() async {
    Navigator.pop(context, ' ${_notificationsList!.response!.length}');


    return Future.value(true);
  }

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
      backgroundColor: Get.isDarkMode ? Colors.white12 : AppColors.white,
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

            Navigator.pop(context, ' ${_notificationsList!.response!.length}');

          },
          child: Icon(
            Icons.chevron_left,
            size: 40,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: _willPopCallback,
        child: _notificationsList == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //   width: double.infinity,
                    //   color: Get.isDarkMode ? Colors.black12 :AppColors.NOTIFICATION_BLACKSHADE,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(
                    //         left: 30, right: 30, top: 30, bottom: 30),
                    //     child: Text('TODAY',
                    //         textAlign: TextAlign.start,
                    //         style: TextStyle(
                    //             fontSize: 12,
                    //             color: AppColors.LOGIN_PAGE_LOGINBOX,
                    //             fontFamily: 'Gotham',
                    //             fontWeight: FontWeight.bold)),
                    //   ),
                    // ),
                    ListView.builder(
                        reverse: false,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 30, right: 30),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'ⓘ ',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Get.isDarkMode
                                                        ? Colors.white
                                                        : AppColors
                                                            .LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                                    fontFamily: 'Gotham',
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text: _notification.notification
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Get.isDarkMode
                                                        ? Colors.white
                                                        : AppColors
                                                            .NOTIFICATION_HEADING,
                                                    fontFamily: 'Gotham',
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 20, bottom: 10,top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(_notification.c_date.toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : AppColors
                                                      .NOTIFICATION_NEWSDETAILS,
                                              fontFamily: 'Gotham',
                                              fontWeight: FontWeight.normal)),
                                      GestureDetector(
                                          onTap: () {
                                            onDelete(index,_notification.nid.toString());
                                          },
                                          child: Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                            size: 20,
                                          ))
                                    ],
                                  ),
                                ),
                                // ReadMoreText(
                                //     AppStrings.parseHtmlString(
                                //         '${_notification.notification.toString()}'),
                                //     trimLines: 2,
                                //     style: TextStyle(
                                //         fontSize: 12,
                                //         color:Get.isDarkMode ? Colors.white38 :
                                //             AppColors.NOTIFICATION_NEWSDETAILS,
                                //         fontFamily: 'Gotham',
                                //         fontWeight: FontWeight.w500),
                                //     colorClickableText: Colors.pink,
                                //     trimMode: TrimMode.Line,
                                //     trimCollapsedText: 'Show more',
                                //     trimExpandedText: 'Show less',
                                //     moreStyle: TextStyle(
                                //         fontSize: 14,
                                //         fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}
