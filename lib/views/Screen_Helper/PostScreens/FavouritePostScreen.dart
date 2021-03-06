import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/Api/PostAPI/LatestPostApi.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/LatestPostModel.dart';
import 'package:penny_chats/views/Screen_Helper/PostScreens/PostDetailsScreen.dart';

class FavouritePostScreen extends StatefulWidget {
  FavouritePostScreen({Key? key}) : super(key: key);

  @override
  _FavouritePostScreenState createState() => _FavouritePostScreenState();
}

class _FavouritePostScreenState extends State<FavouritePostScreen> {
  LatestPostModel? _favouritePostList;

  @override
  void initState() {
    LatestPostApi.getLatestPost(context, AppStrings.getFavouritePostApi)
        .then((value) {
      setState(() {
        _favouritePostList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.POST_BACKGROUND_COLOR,
      body: _favouritePostList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _favouritePostList?.response?.length,
              itemBuilder: (context, int index) {
                var _post = _favouritePostList!.response![index];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: InkWell(
                    onTap: () async{
                      final result = await  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostDetails(
                                id: _post.id,
                                    name: _post.name,
                                    time: AppStrings.dateFormat
                                        .format(_post.created!),
                                    desc:
                                        _post.content!,
                                    likes: _post.votes,
                                    comments: _post.comments,
                                    image: _post.profilePic,
                                    postUserId: _post.userId,
                                title: _post.title,
                                  )));
                      print('--------------------result -> ${result.toString()}');
                      print('--------------------result -> ${index.toString()}');

                      var arr = result.split('-');

                      // print(arr[0]);
                      // print('**************** ${result.toString().substring( 0,split)}');


                      setState(() {
                        _favouritePostList!.response![index].votes =arr[0].toString();
                        _favouritePostList!.response![index].comments = arr[1].toString();
                        _favouritePostList!.response![index].is_liked_ornot=arr[2].toString();

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
                                        color:Get.isDarkMode ? Colors.white: AppColors
                                            .POST_TAB_FAVOURITE_TIME_COLOR,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(
                                      'assets/icon/clock.svg',
                                      color: Get.isDarkMode ? Colors.white:AppColors
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
                                              color:Get.isDarkMode ? Colors.white: AppColors
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
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: Text(
                                _post.title.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Get.isDarkMode ? Colors.white : AppColors.POST_TAB_COMMENTS_COLOR,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(height: 10,),
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
                                  color:Get.isDarkMode ? Colors.white : AppColors.POST_TAB_COMMENTS_COLOR,
                                  fontFamily: 'Gotham',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 1,
                                color: Get.isDarkMode ? Colors.white:AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                              ),
                            ),
                            GestureDetector(

                              behavior: HitTestBehavior.opaque,
                              onTap: (){
                                String currentStatus= "1";
                                int votes = int.parse(_post.votes!);
                                if(_post.is_liked_ornot=="1"){
                                  currentStatus = "0";
                                  if(votes>0){
                                    votes--;
                                  }
                                }else{
                                  if(votes>0){
                                    votes++;
                                  }
                                }

                                _favouritePostList!.response![index].votes = votes.toString();
                                makeDisLike(_favouritePostList!.response![index].id!,index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icon/heart-fill.svg',
                                            height: 20,
                                            color: AppColors.red
                                            ,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            _post.votes.toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color:Get.isDarkMode ? Colors.white:
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
                                            color: Get.isDarkMode ? Colors.white:AppColors.POST_TAB_LIKE_COLOR,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            _post.comments.toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color:Get.isDarkMode ? Colors.white:
                                                    AppColors.POST_TAB_LIKE_COLOR,
                                                fontFamily: 'Gotham',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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

  makeDisLike(String postid,int index) async {
    print(postid);
    var data = await Apiservice().getdislike(postid);
    print(data);
    if(data["status"]==true){
      String  msg= 'You disliked this post';
      _favouritePostList?.response!.removeAt(index);
      setState(() {

      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              msg)));
    }


  }
}
