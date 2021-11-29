import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/Api/PostAPI/LatestPostApi.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/LatestPostModel.dart';
import 'package:penny_chats/views/Screen_Helper/PostScreens/PostDetailsScreen.dart';

class PopularPostScreen extends StatefulWidget {
  PopularPostScreen({Key? key}) : super(key: key);

  @override
  _PopularPostScreenState createState() => _PopularPostScreenState();
}

class _PopularPostScreenState extends State<PopularPostScreen> {
  LatestPostModel? _popularPostList;

  @override
  void initState() {
    LatestPostApi.getLatestPost(context, AppStrings.getPopularPostApi)
        .then((value) {
      setState(() {
        _popularPostList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.POST_BACKGROUND_COLOR,
      body: _popularPostList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _popularPostList?.response?.length,
              itemBuilder: (context, int index) {
                var _post = _popularPostList!.response![index];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostDetails(
                                    name: _post.name,
                                    time: AppStrings.dateFormat
                                        .format(_post.created!),
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
                                                  'https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg')
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
                                          AppStrings.dateFormat
                                              .format(_post.created!),
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
                                        SvgPicture.asset(
                                          'assets/icon/heart.svg',
                                          height: 20,
                                          color: AppColors.POST_TAB_LIKE_COLOR,
                                        ),
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
