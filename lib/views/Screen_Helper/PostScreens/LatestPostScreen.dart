import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/Api/PostAPI/LatestPostApi.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/LatestPostModel.dart';
import 'package:penny_chats/models/Likemodel.dart';
import 'package:penny_chats/views/Screen_Helper/PostScreens/PostDetailsScreen.dart';

class LatestPostScreen extends StatefulWidget {
  LatestPostScreen({Key? key}) : super(key: key);

  @override
  _LatestPostScreenState createState() => _LatestPostScreenState();
}

class _LatestPostScreenState extends State<LatestPostScreen> {
  LatestPostModel? _latestPostModel;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd – kk:mm');
String isLike="true";
var data;
  @override
  void initState() {
    LatestPostApi.getLatestPost(context, AppStrings.getLatestPostApi)
        .then((value) {
      setState(() {
        _latestPostModel = value;
      });
    });
    super.initState();
  }
  makelike(String postid) async {
    print(postid);
    data = await Apiservice().getlike(postid);
   if(data["status"]==true){
     isLike = "true";
   }else {
     isLike = "false";
   }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'You liked this post')));
    print(data);
   print("post id -> $postid , like -> $isLike");

  }
  makedislike(String postid) async {
    print(postid);
    data = await Apiservice().getlike(postid);
    if(data["status"]==true){
      isLike = "true";
    }else {
      isLike = "false";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'You disliked this post')));
    print(data);
    print("post id -> $postid , like -> $isLike");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.POST_BACKGROUND_COLOR,
      body: _latestPostModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _latestPostModel?.response?.length,
              itemBuilder: (context, int index) {

                var _post = _latestPostModel!.response![index];
                print(_post.id.toString());
     //           makelike(_post.id.toString());
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
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
                                  )));
                    },
                    // splashColor: AppColors.DASHBOARD_SELECTED_ICON_COLOR,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        child: Column(
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
                                              'https://static.wikia.nocookie.net/itstabletoptime/images/b/b5/Default.jpg/revision/latest?cb=20210606184459'
                                                  'https://static.wikia.nocookie.net/itstabletoptime/images/b/b5/Default.jpg/revision/latest?cb=20210606184459'
                                          )
                                              : NetworkImage(
                                                  'https://www.pennychats.com/uploads/profile_pictures/${_post.profilePic}'),
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
                                      color: AppColors
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
                                              color: AppColors
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
                                _post.content.toString().length < 150
                                    ? AppStrings.parseHtmlString(
                                        _post.content.toString())
                                    : "${AppStrings.parseHtmlString(_post.content.toString().substring(0, 150))}.....",
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.4,
                                  color: AppColors.POST_TAB_COMMENTS_COLOR,
                                  fontFamily: 'Gotham',
                                ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                GestureDetector(

                                  child: SvgPicture.asset(
                                    'assets/icon/heart.svg',
                                    height: 20,
                                    color: AppColors.POST_TAB_LIKE_COLOR,

                                  ),
                                  onTap: (){
                                    makelike(_post.id.toString());
                          //          makedislike(_post.id.toString());
                                  },
                                ),
                                      //   data["status"]==true ? SvgPicture.asset(
                                      //   'assets/icon/heart.svg',
                                      //   height: 20,
                                      //   color: AppColors.POST_TAB_LIKE_COLOR,
                                      //
                                      // ) :  SvgPicture.asset(
                                      //     'assets/icon/heart.svg',
                                      //     height: 20,
                                      //   color: Colors.red,
                                      //
                                      // ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _post.votes.toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  AppColors.POST_TAB_LIKE_COLOR,
                                              fontFamily: 'Gotham',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icon/chat.svg',
                                          height: 20,
                                          color: AppColors.POST_TAB_LIKE_COLOR,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _post.comments.toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  AppColors.POST_TAB_LIKE_COLOR,
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
}
