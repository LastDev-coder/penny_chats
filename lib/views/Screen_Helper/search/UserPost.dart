import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../ApiService/Apiservice.dart';
import '../../../controllers/Api/PostAPI/LatestPostApi.dart';
import '../../../controllers/AppStrings.dart';
import '../../../controllers/colors/colors.dart';
import '../../../models/LatestPostModel.dart';
import '../PostScreens/PostDetailsScreen.dart';

class UserPost extends StatefulWidget {
  final String? id;

  const UserPost({Key? key,
    this.id,
  }) : super(key: key);

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {

  LatestPostModel? _latestPostModel;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd – kk:mm');
  String isLike = "true";

  var data;

  @override
  void initState() {
    LatestPostApi.getLatestPost(context, '${AppStrings.getUserPostApi}/${widget.id}')
        .then((value) {
      setState(() {
        _latestPostModel = value;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Get.isDarkMode
      //     ?Colors.transparent: AppColors.POST_BACKGROUND_COLOR,
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
        title: Text('Posts'),
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

      body: _latestPostModel == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _latestPostModel?.response?.length,
        itemBuilder: (context, int index) {
          var _post = _latestPostModel!.response![index];
          // print(_post.id.toString());
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: InkWell(
              onTap: () async{
                final result =    await   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostDetails(
                          id: _post.id,
                          name: _post.name,
                          time: dateFormat.format(_post.created!),
                          desc: AppStrings.parseHtmlString(
                              _post.content!),
                          likes: _post.votes,
                          comments: _post.comments,
                          image: _post.profilePic,
                          postUserId: _post.userId,
                          title: _post.title,
                        )));
                print('--------------------result -> ${ result.toString() }');
                print('--------------------index no  -> ${index.toString()}');

                var arr = result.split('-');

                // print(arr[0]);


                setState(() {
                  _latestPostModel!.response![index].votes =arr[0].toString();
                  _latestPostModel!.response![index].comments = arr[1].toString();
                  _latestPostModel!.response![index].is_liked_ornot=arr[2].toString();

                });
              },
              // splashColor: AppColors.DASHBOARD_SELECTED_ICON_COLOR,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
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
                                    borderRadius:
                                    BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: _post.profilePic ==
                                        ''
                                        ? NetworkImage(
                                        '${AppStrings.noProfilePicture}')
                                        : NetworkImage(
                                        '${AppStrings.profilePictureApi}/${_post.profilePic}'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    0.15,
                                child: Text(
                                  _post.name.toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color:
                                      AppColors.LOGIN_PAGE_LOGINBOX,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15),
                                child: VerticalDivider(
                                  thickness: 1,
                                  width: 10,
                                  color: AppColors
                                      .POST_TAB_FAVOURITE_TIME_COLOR,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                'assets/icon/clock.svg',
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : AppColors
                                    .POST_TAB_FAVOURITE_TIME_COLOR,
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.3,
                                  child: Text(
                                    dateFormat.format(_post.created!),
                                    style: TextStyle(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : AppColors
                                            .POST_TAB_FAVOURITE_TIME_COLOR,
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
                        padding:
                        const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          _post.title.toString(),
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
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          _post.content.toString().length < 150
                              ? AppStrings.parseHtmlString(
                              _post.content.toString())
                              : "${AppStrings.parseHtmlString(_post.content.toString().substring(0, 150))}.....",
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Get.isDarkMode
                                ? Colors.white
                                : AppColors.POST_TAB_COMMENTS_COLOR,
                            fontFamily: 'Gotham',
                          ),
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
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                String currentStatus = "1";
                                int votes = int.parse(_post.votes!);

                                if (_post.is_liked_ornot == "1") {
                                  currentStatus = "0";
                                  if (votes > 0) {
                                    votes--;
                                  }
                                } else {
                                  if (votes >= 0) {
                                    votes++;
                                  }
                                }
                                _latestPostModel!.response![index]
                                    .is_liked_ornot = currentStatus;
                                _latestPostModel!.response![index].votes =
                                    votes.toString();
                                likePost(
                                    _latestPostModel!
                                        .response![index].id!,
                                    currentStatus);
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    _post.is_liked_ornot == "1"
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
                                          : AppColors
                                          .POST_TAB_LIKE_COLOR,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _post.votes.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : AppColors
                                              .POST_TAB_LIKE_COLOR,
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
                                    _post.comments.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : AppColors
                                            .POST_TAB_LIKE_COLOR,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  likePost(String postId, String currentStatus) {
    if (currentStatus == "1") {
      makelike(postId);
    } else {
      makeDisLike(postId);
    }
  }

  makelike(String postid) async {
    print(postid);

    var data = await Apiservice().getlike(postid);
    print(data);
    if (data["status"] == true) {
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
      String msg = 'You disliked this post';

      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }
}
