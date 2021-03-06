import 'dart:convert';
import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/PostDetailsModel.dart';
import 'package:penny_chats/views/Screen_Helper/Profile/PostUserScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/AppStrings.dart';

class PostDetails extends StatefulWidget {
  final String? id;
  final String? name;
  final String? time;
  final String? desc;
  final String? likes;
  final String? comments;
  final String? image;
  final String? postUserId;
  final String? title;

  PostDetails(
      {Key? key,
      this.id,
      this.name,
      this.time,
      this.likes,
      this.comments,
      this.image,
      this.desc,
      this.postUserId,
      this.title})
      : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  TextEditingController textController = TextEditingController();

  String postLikes = "0", postComment = "0";
  String isLike = "false", _resultisLike = '0';
  String myId = '';

  var content='';
  bool _sloading = false;
  Future<List<PostDetailsModel>>? list;
  bool currentPostLike = false;
  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);

    return "${outputDate.toString()}";
  }


  checkHyperlink(String text){
    RegExp exp = new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(text);
    bool match = exp.hasMatch(text);
    if(match){
      matches.forEach((match) {

        print(text.substring(match.start, match.end));
      });
    }else{
      print('$text');
    }

    return text;
  }



  makelike(String postid) async {
    print(postid);
    if (currentPostLike) {
      makeDisLike(postid);
      return;
    }

    var data = await Apiservice().getlike(postid);
    print(data);
    if (data["status"] == true) {
      currentPostLike = !currentPostLike;
      postLikes = data["response"].toString();
      String msg = 'You liked this post';

      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }

    print("=============================");
    print(data);
    print("post id -> $postid , like -> $isLike");
  }

  makeDisLike(String postid) async {
    print(postid);
    var data = await Apiservice().getdislike(postid);
    print(data);
    if (data["status"] == true) {
      currentPostLike = false;
      postLikes = data["response"].toString();
      String msg = 'You disliked this post';

      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  MyComment(String postId, String comment) async {
    var _data = new Map<String, dynamic>();
    _data['post_id'] = postId;
    _data['comment'] = comment;

    print(_data);

    var data = await Apiservice().PostComment(_data);
    print('---------------------------------');
    print(data);
    print('---------------------------------');

    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(
        'comment successful',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ));
    // Navigator.of(context).pop();
  }
  List<TextSpan> extractText(String rawString) {
    List<TextSpan> textSpan = [];

    final urlRegExp = new RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

    getLink(String linkString) {
      textSpan.add(
        TextSpan(
          text: linkString,

          style: new TextStyle(color: Colors.blue),
          recognizer: new TapGestureRecognizer()
            ..onTap = () {
              launch(linkString!);

            },
        ),
      );
      return linkString;
    }

    getNormalText(String normalText) {
      textSpan.add(
        TextSpan(
          text: normalText,
          style: new TextStyle(color:Get.isDarkMode ? Colors.white : Colors.black),
        ),
      );
      return normalText;
    }

    rawString.splitMapJoin(
      urlRegExp,
      onMatch: (m) => getLink("${m.group(0)}"),
      onNonMatch: (n) => getNormalText("${n.substring(0)}"),
    );

    return textSpan;}

  PostDetail() async {
    List<PostDetailsModel> postmodel = [];

    var data = await Apiservice().getPostDetails(widget.id.toString());

    // var commentdata = data["response"]["comment"];
    // name = data["response"]["name"];
    // print("---------------------------------");
    // log(jsonEncode(data).toString());
    // print("---------------------------------");
    int i = 0;

    // setState(() {
    //   postComment  = data["response"]["comment"].length.toString();
    // });
    print(data["response"]);
    for (var x in data["response"]["comment"]) {
      // date = getFormattedDate(dataresponse[i]["created"]);

      PostDetailsModel model = PostDetailsModel(
          data["response"]["comment"][i]["id"],
          data["response"]["comment"][i]["post_id"],
          data["response"]["comment"][i]["user_id"],
          data["response"]["comment"][i]["comment"],
          getFormattedDate(
              data["response"]["comment"][i]["created"]),
          data["response"]["comment"][i]["modified"],
          data["response"]["comment"][i]["is_active"],
          data["response"]["comment"][i]["name"],
          data["response"]["comment"][i]["profile_pic"]);
      postmodel.add(model);
      i++;
    }

    list = Future.value(postmodel);

    postComment = data["response"]["comment"].length.toString();
    postLikes = data["response"]["total_like_count"]["postcnt"].toString();
    print("==================================ff==");
    print(data["response"]["post_liked"]);
    currentPostLike = data["response"]["post_liked"] > 0;
    print("likes -> $postLikes  comment -> $postComment");

    setState(() {});
  }

  Future<bool> ShowProfile(String userId) async {
    var data = await Apiservice().getOthersprofile(userId);
    var dataresponse = data["response"];
    print("profile ================ $dataresponse ");

    final shouldPop = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // title: Text('Percent gain calculator'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              // color: Colors.red,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data["response"]['profile_pic']
                                      .toString() ==
                                  ''
                              ? '${AppStrings.noProfilePicture}'
                              : 'https://www.pennychats.com/uploads/profile_pictures/${data["response"]['profile_pic'].toString()}'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.supervised_user_circle_sharp,
                          size: 20,
                          color: Get.isDarkMode ? Colors.white70 : Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Name :',
                          style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white70
                                  : Colors.black,
                              fontFamily: 'Gotham',
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          data["response"]["name"].toString(),
                          style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white70
                                  : Colors.black,
                              fontFamily: 'Gotham',
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.email_rounded,
                          size: 20,
                          color: Get.isDarkMode ? Colors.white70 : Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Email Id :',
                          style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white70
                                  : Colors.black,
                              fontFamily: 'Gotham',
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            data["response"]["email"].toString(),
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white70
                                    : Colors.black,
                                fontFamily: 'Gotham',
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );

    return shouldPop ?? false;
  }

  myUserid() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';
    setState(() {
      myId = id;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postLikes = widget.likes.toString();
    myUserid();
    PostDetail();
  }

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
        title: Text('POST DETAILS'),
        leading: GestureDetector(
          onTap: () {
            if (currentPostLike) {
              _resultisLike = '1';
            } else {
              _resultisLike = '0';
            }

            Navigator.pop(context, '$postLikes-$postComment-$_resultisLike');
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: (){
        //       Share.share('PennyChats post by ${widget.name}\n\n ${widget.desc}', subject: '${widget.desc}');
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 20),
        //       child: Icon(Icons.share),
        //     ),
        //   )
        // ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (currentPostLike) {
            _resultisLike = '1';
          } else {
            _resultisLike = '0';
          }

          Navigator.pop(context, '$postLikes-$postComment-$_resultisLike');
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostUserScreen(
                                          postUserId: widget.postUserId,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: widget.image == ''
                                  ? NetworkImage(
                                      '${AppStrings.noProfilePicture}')
                                  : NetworkImage(
                                      '${AppStrings.profilePictureApi}/${widget.image}'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'By',
                        style: TextStyle(
                            fontSize: 13,
                            color: Get.isDarkMode
                                ? Colors.white
                                : AppColors.FORGOT_PAGE_INPUT_TEXT,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          widget.name.toString(),
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.LOGIN_PAGE_LOGINBOX,
                              fontFamily: 'Gotham',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: VerticalDivider(
                          thickness: 1,
                          width: 10,
                          color: Get.isDarkMode
                              ? Colors.white
                              : AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        'assets/icon/clock.svg',
                        color: Get.isDarkMode
                            ? Colors.white
                            : AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            widget.time.toString(),
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                                fontFamily: 'Gotham',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  widget.title.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      color: Get.isDarkMode
                          ? Colors.white
                          : AppColors.POST_TAB_COMMENTS_COLOR,
                      fontFamily: 'Gotham',
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child:
              Html(
                  data: widget.desc,
                  onLinkTap: (String? url, RenderContext context,
                      Map<String, String> attributes, dom.Element? element) {
                    //open URL in webview, or launch URL in browser, or any other logic here
                    print('clicked');
                    launch(url!);
                  },
                  shrinkWrap: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Divider(
                  thickness: 1,
                  color: AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        makelike(widget.id.toString());
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        child: Row(
                          children: [
                            currentPostLike
                                ? SvgPicture.asset(
                                    'assets/icon/heart-fill.svg',
                                    height: 20,
                                    color: AppColors.red,
                                  )
                                : SvgPicture.asset(
                                    'assets/icon/heart.svg',
                                    height: 20,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : AppColors.POST_TAB_LIKE_COLOR,
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              (postLikes == "0" || postLikes == "1")
                                  ? '${postLikes} Like'
                                  : '${postLikes} Likes',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : AppColors.POST_TAB_LIKE_COLOR,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/chat.svg',
                            height: 20,
                            color: Get.isDarkMode
                                ? Colors.white
                                : AppColors.POST_TAB_LIKE_COLOR,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            (postComment == "0" || postComment == "1")
                                ? '${postComment} comment'
                                : '${postComment} comments',
                            style: TextStyle(
                                fontSize: 12,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : AppColors.POST_TAB_LIKE_COLOR,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Divider(
                  thickness: 1,
                  color: Get.isDarkMode
                      ? Colors.white
                      : AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  children: [
                    // Card(
                    //   elevation: 2,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(50)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(2.0),
                    //     child: CircleAvatar(
                    //       radius: 25,
                    //       backgroundImage: NetworkImage(
                    //           'https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg'),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Container(
                        // height: 20,
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Get.isDarkMode
                              ? Colors.black
                              : AppColors.POST_DETAILS_COMMENTBOX,
                        ),

                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: textController,
                            maxLines: 2,
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                fontFamily: 'Gotham',
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Write your comments',
                                hintStyle: TextStyle(
                                  fontSize: 11.0,
                                  color: AppColors.POST_DETAILS_COMMENTBOX_HINT,
                                  fontWeight: FontWeight.w500,
                                )),
                            validator: (value) {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                        height: 40,
                        width: 40,
                        child: RaisedButton(
                          // textColor: Colors.white,
                          color: _sloading?Colors.transparent: AppColors.POST_DETAILS_ICONCOLOR,
                          child: _sloading
                              ? CupertinoActivityIndicator(
                              animating: true, radius: 10)
                              : Icon(
                            Icons.send,
                            size: 15,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if (textController.text.isNotEmpty &&
                                textController.text.toString() != '') {
                              setState(() {
                                _sloading = true;
                              });
                              await MyComment(
                                  widget.id.toString(), textController.text);
                              textController.clear();
                              PostDetail();
                              setState(() {
                                _sloading = false;
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(new SnackBar(
                                content: new Text(
                                  'Please write your comments',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Divider(
                  thickness: 1,
                  color: Get.isDarkMode
                      ? Colors.white
                      : AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                ),
              ),
              FutureBuilder(
                future: list,
                // initialData: InitialData,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                          child: CupertinoActivityIndicator(
                              animating: true, radius: 15)),
                    );
                  } else {
                    return snapshot.data.length.toString() != "0" ||
                            snapshot.data.length.toString() != "null"
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int i) {
                              postComment = snapshot.data.length.toString();
                              print(postComment);

                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PostUserScreen(
                                                      postUserId: snapshot
                                                          .data[i].user_id,
                                                    )));
                                      },
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundImage: snapshot
                                                        .data[i].profile_pic ==
                                                    ''
                                                ? NetworkImage(
                                                    '${AppStrings.noProfilePicture}')
                                                : NetworkImage(
                                                    '${AppStrings.profilePictureApi}/${snapshot.data[i].profile_pic}'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Text(
                                                '${snapshot.data[i].name}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors
                                                        .LOGIN_PAGE_LOGINBOX,
                                                    fontFamily: 'Gotham',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                              RichText(
                                              text: TextSpan(
                                                children: extractText(snapshot.data[i].comment),
                                              ),
                                              ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icon/clock.svg',
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : AppColors
                                                                .POST_DETAILS_ICONCOLOR,
                                                        height: 15,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Text(
                                                          '${snapshot.data[i].created}',
                                                          style: TextStyle(
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Colors.white
                                                                  : AppColors
                                                                      .POST_DETAILS_ICONTEXT,
                                                              fontFamily:
                                                                  'Gotham',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  snapshot.data[i].user_id ==
                                                          myId
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            onDelete(snapshot
                                                                .data[i]
                                                                .id);
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .delete_forever,
                                                            color: Colors.red,
                                                            size: 20,
                                                          ))
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        : Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onDelete(String mid) async {
    bool _loading = false;

    final shouldPop = await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text('Do you want to delete your comment?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No'),
                      ),
                      FlatButton(
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });

                          var data = await Apiservice().getCommentDelete(mid);

                          if (data["status"].toString() == "true") {
                            PostDetail();

                            Navigator.of(context).pop(false);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(new SnackBar(
                              content: new Text(
                                data["response"].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                            ));
                          } else {
                            Navigator.of(context).pop(false);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(new SnackBar(
                              content: new Text(
                                data["response"].toString(),
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
}
