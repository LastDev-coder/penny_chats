import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/online_user_list_model.dart';
import 'package:penny_chats/models/user_chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRoomPersonal extends StatefulWidget {
  ChatRoomPersonal({Key? key}) : super(key: key);

  @override
  _ChatRoomPersonalState createState() => _ChatRoomPersonalState();
}

class _ChatRoomPersonalState extends State<ChatRoomPersonal> {
  TextEditingController _messagesendController = new TextEditingController();

  List<Messages> _listMessages = [];
  String lastMessageId = "";
  String firstMessageId = "";
  String uID = "";
  bool isBottom = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    getMessage();
    // callTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 100,
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: FutureBuilder(
                  future: getOnlineUser(),
                  // initialData: InitialData,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<UserList>> snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children:
                              snapshot.data!.map((e) => getUser(e)).toList()),
                    );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _listMessages.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return getMessagesView(_listMessages[index], index);
                      })),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  color: Colors.black45,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Container(
                        color:
                            Get.isDarkMode ? Colors.black12 : AppColors.white,
                        child: TextFormField(
                          controller: _messagesendController,
                          keyboardType: TextInputType.text,
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 4,
                          minLines: 1,
                          style: GoogleFonts.openSans(
                            color: Get.isDarkMode
                                ? Colors.white
                                : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                  onPressed: sendmessage,
                                  icon: Icon(
                                    Icons.send,
                                    size: 30,
                                    color: AppColors.LOGIN_PAGE_LOGINBOX,
                                  )),
                              hintText: 'Type in your message...',
                              hintStyle: GoogleFonts.openSans(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              contentPadding: EdgeInsets.all(5)),
                        )),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<UserList>> getOnlineUser() async {
    List<UserList> list = [];
    var data = await Apiservice().getOnlineUser();

    OnlineUsers onlineUsers = OnlineUsers.fromJson(data);
    if (onlineUsers.status as bool) {
      list = onlineUsers.response as List<UserList>;
    }
    return list;
  }

  Widget getUser(UserList user) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: CircleAvatar(
                  radius: 27,
                  backgroundImage: user.profilePic == ''
                      ? NetworkImage('${AppStrings.noProfilePicture}')
                      : NetworkImage(
                          '${AppStrings.profilePictureApi}/${user.profilePic}'),
                ),
              ),
            ),
            Card(
              elevation: 0,
              color: AppColors.LOGIN_PAGE_LOGINBOX,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
              ),
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            width: 55,
            child: Text(
              user.username!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                color: Get.isDarkMode
                    ? Colors.white
                    : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  sendmessage() async {
    String msg = _messagesendController.text;
    print("======================$msg");
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (msg.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter something")));
      // _formKey.currentState?.reset();
      currentFocus.focusedChild?.unfocus();

      return;
    }

    var data = await Apiservice().sendMessage(msg);
    _messagesendController.text = "";
    currentFocus.focusedChild?.unfocus();

    print("======================$data");
    gatLastMessage();
  }

  getMessage() async {
    final prefs = await SharedPreferences.getInstance();
    uID = prefs.getString('id') ?? '';
    bool iisf = false;

    print(lastMessageId);
    var data = await Apiservice().getMessages(lastMessageId);
    if (_listMessages.isEmpty) {
      iisf = true;
    }

    print(data);
    UserChatModel userChatModel = UserChatModel.fromJson(data);
    for (Messages me in userChatModel.messages!) {
      _listMessages.insert(0, me);
    }
    if (iisf) {
      print("------------xx-----${_scrollController.hasClients}");
      print("------------xx-----${_scrollController.position.maxScrollExtent}");

      if (_scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 500)).then((value) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
          );
        });
      }
      if (_scrollController.hasClients)
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 10,
          duration: const Duration(milliseconds: 1),
          curve: Curves.bounceInOut,
        );
    }
    lastMessageId = _listMessages.first.iD.toString();
    setState(() {});
  }

  getMessagesView(Messages user, int index) {
    bool Visiibility = false;
    String md = "";
    try {
      md = user.time!.split(" ")[0] + " " + user.time!.split(" ")[1];
    } catch (e) {}
    if (md == "") {
      Visiibility = false;
    } else if (index == 0) {
      Visiibility = true;
    } else if (index > 0) {
      try {
        String md1 = _listMessages[index - 1].time!.split(" ")[0] +
            " " +
            _listMessages[index - 1].time!.split(" ")[1];
        String md2 = _listMessages[index].time!.split(" ")[0] +
            " " +
            _listMessages[index].time!.split(" ")[1];
        if (md1 != md2) {
          Visiibility = true;
        }
      } catch (e) {}
    } else {
      Visiibility = false;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Visibility(
        visible: uID != user.uid,
        child: Column(
          children: [
            Visibility(
              visible: Visiibility,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Divider(
                        thickness: 1,
                        color: AppColors.CHAT_ROOM_DATEOFMESSAGE_DIVIDER,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(md),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Divider(
                          color: Get.isDarkMode
                              ? Colors.white38
                              : AppColors.CHAT_ROOM_DATEOFMESSAGE_DIVIDER,
                          thickness: 1,
                        )),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: CircleAvatar(
                      radius: 27,
                      backgroundImage: user.pic == ''
                          ? NetworkImage('${AppStrings.noProfilePicture}')
                          : NetworkImage(
                              '${AppStrings.profilePictureApi}/${user.pic}'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user.user.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.4,
                                color: Get.isDarkMode
                                    ? Colors.white38
                                    : AppColors.PROFILE_TAB_CAMERA_ICON_COLOR,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            user.time.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color: Get.isDarkMode
                                    ? Colors.white38
                                    : AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          user.isReport != '1'
                              ?
                          Expanded(
                            flex: 1,
                            child: Container(
                                        margin: EdgeInsets.only(top: 5, right: 10),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? Colors.black38
                                                : Color(0xfff1f2f6),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            )),
                                        child: Text(
                                          user.message.toString(),
                                        ),
                                      ),
                          )
                              : Container(
                            margin: EdgeInsets.only(top: 5, right: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.black38
                                    : Color(0xfff1f2f6),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            child: Text('Blocked Content',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.normal)),
                          ),
                          GestureDetector(
                            onTap: () {
                              onDelete(index, user.iD.toString(), user);
                            },
                            child: Align(
                                alignment: Alignment.topLeft,

                                child: user.isReport != '1'
                                    ? Container(
                                  margin: EdgeInsets.only( right: 45),

                                  child: Icon(Icons.report,size: 15,
                                color: Get.isDarkMode
                                      ? Colors.black54
                                      : Colors.black26,),
                                    )
                                    : Container()),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        replacement: Column(
          children: [
            Visibility(
              visible: Visiibility,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Divider(
                        thickness: 1,
                        color: AppColors.CHAT_ROOM_DATEOFMESSAGE_DIVIDER,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    md,
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
                          color: AppColors.CHAT_ROOM_DATEOFMESSAGE_DIVIDER,
                          thickness: 1,
                        )),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user.time.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color: Get.isDarkMode
                                    ? Colors.white38
                                    : AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            user.user.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.4,
                                color: Get.isDarkMode
                                    ? Colors.white38
                                    : AppColors.PROFILE_TAB_CAMERA_ICON_COLOR,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 70),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xfff6ec68d),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: Text(user.message.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.normal)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: CircleAvatar(
                      radius: 27,
                      backgroundImage: user.pic == ''
                          ? NetworkImage('${AppStrings.noProfilePicture}')
                          : NetworkImage(
                              '${AppStrings.profilePictureApi}/${user.pic}'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  gatLastMessage() async {
    firstMessageId = _listMessages.last.iD.toString();
    var data = await Apiservice().getCurrentMessages(firstMessageId);
    UserChatModel userChatModel = UserChatModel.fromJson(data);
    print(data);

    for (Messages me in userChatModel.messages!) {
      _listMessages.add(me);
      print("------------------>>$isBottom");
      print(
          "------------------>>${_scrollController.position.maxScrollExtent}");
      if (isBottom) {
        setState(() {});
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 100),
          curve: Curves.bounceInOut,
        );
      }
    }
  }

  callTimer() {
    Timer.periodic(Duration(seconds: 10), (timer) => gatLastMessage());
    _scrollController.addListener(() {
      print("------------------<>");
      print(_scrollController.position.pixels);
      print(_scrollController.position.axisDirection);
      print("------------------<>");
      if (_scrollController.position.atEdge) {
        print("------------------end");
        isBottom = true;
      } else {
        print("------------------top");
        isBottom = false;
      }
      if (_scrollController.position.pixels < 0.1) {
        getMessage();
      }
    });
  }

  Future<bool> onDelete(int index, String mid, Messages user) async {
    bool _loading = false;

    final shouldPop = await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text('Do you want to report this message ?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No'),
                      ),
                      FlatButton(
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                            // _listMessages.removeAt(index);
                            refresh(user);
                          });

                          print('-------------$index--------------');
                          print('*************${mid}***********');
                          var _data = new Map<String, dynamic>();
                          _data['msg_id'] = mid;
                          print(_data);

                          var data =
                              await Apiservice().postReportMessage(_data);

                          print("***********************-------------------" +
                              data.toString());
                          print(
                              "delete message index no --> ${index.toString()}");
                          print("message id --> ${mid.toString()}");

                          if (data["status"].toString() == "true") {
                            setState(() {
                              _listMessages.removeAt(index);
                            });

                            Navigator.of(context).pop(false);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(new SnackBar(
                              content: new Text(
                                data["message"].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                            ));
                          } else {
                            Navigator.of(context).pop(false);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(new SnackBar(
                              content: new Text(
                                data["message"].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        child: _loading
                            ? CupertinoActivityIndicator(
                                animating: true, radius: 10)
                            : Text('Yes'),
                      ),
                    ],
                  ));
        });

    return shouldPop ?? false;
  }

  refresh(user) {
    setState(() {
      user.isReport = '1';
    });
  }
}
