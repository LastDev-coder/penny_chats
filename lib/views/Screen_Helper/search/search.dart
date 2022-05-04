


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/LatestPostModel.dart';
import 'package:penny_chats/models/user_search_model.dart';
import 'package:penny_chats/views/Screen_Helper/PostScreens/PostDetailsScreen.dart';
import 'package:penny_chats/views/Screen_Helper/search/UserPost.dart';

import '../Profile/PostUserScreen.dart';

class Sarch extends StatefulWidget {
  @override
  _SarchState createState() => _SarchState();
}

class _SarchState extends State<Sarch> {

  TextEditingController searchController =TextEditingController();
  List<UserList > _popularPostList =[]  ;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd – kk:mm');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ceateLitener();
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
        title: Text('Post search'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, 'back');
          },
          child: Icon(
            Icons.close,
            size: 30,
          ),
        ),
      ),
      backgroundColor:Get.isDarkMode ? Colors.black38 :AppColors.SCAFFOLD_BACKGROUND,
      body: Padding(
        padding: const EdgeInsets.only(top: 10,left: 12,right: 12),
        child: Column(
          children: [
           TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintStyle:const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
                floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
                labelText: "Search name",
                //  filled: true, // Needed for adding a fill color
                isDense: true,
                fillColor: Get.isDarkMode ? Colors.black38 : Colors.white,
                focusColor: Colors.white,
                hoverColor: Colors.white,
                filled: true,

                //  filled: true, // Needed for adding a fill color
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Get.isDarkMode ? Colors.white70 : Colors.black),
                    borderRadius: new BorderRadius.circular(40)),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Get.isDarkMode ? Colors.white70 :Colors.black),
                  borderRadius: new BorderRadius.circular(40),
                ),

                contentPadding:const EdgeInsets.only(left: 15,right: 10),
                // Reduces height a bit
                prefixIcon: Container(
                    padding: const EdgeInsets.all(10),
                    height: 18,
                    width: 18,
                    child: Icon(Icons.search)
                ),

              ),
            ),
            _popularPostList==null?Container( ):
          Expanded(
              flex: 1,
              child:   SingleChildScrollView(

            child: ListView.builder(
              shrinkWrap:true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _popularPostList?.length,
              itemBuilder: (context, int index) {
                var _post = _popularPostList![index];
                print(_post.id.toString());

                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostUserScreen(
                                postUserId: _post.id.toString(),
                              )));
                    },
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
                                      width: 15,
                                    ),
                                    Container(

                                      child: Text(
                                        _post.name.toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color:Get.isDarkMode
                                                ? Colors.white
                                                :
                                            AppColors.LOGIN_PAGE_LOGINBOX,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),



                                  ],
                                ),
                              ),
                            ),


                            // Padding(
                            //   padding:
                            //   const EdgeInsets.only(left: 15, right: 15),
                            //   child: Text(
                            //     _post.content.toString().length < 150
                            //         ? AppStrings.parseHtmlString(
                            //         _post.content.toString())
                            //         : "${AppStrings.parseHtmlString(_post.content.toString().substring(0, 150))}.....",
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       height: 1.4,
                            //       color: Get.isDarkMode ? Colors.white38 :AppColors.POST_TAB_COMMENTS_COLOR,
                            //       fontFamily: 'Gotham',
                            //     ),
                            //   ),
                            // ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          SvgPicture.asset(
                            'assets/icon/clock.svg',
                            height: 20,
                            color: Get.isDarkMode ? Colors.white:AppColors.POST_TAB_LIKE_COLOR,
                          ),
                          SizedBox(
                            width: 10,
                          ),

                          Text(" Member since ${getDate(_post.created!)}",

                            style: TextStyle(
                                fontSize: 12,
                                color:Get.isDarkMode
                                    ? Colors.white
                                    :
                                AppColors.POST_TAB_LIKE_COLOR,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.bold),),
                        ],
                      ),

                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 1,
                                color: Get.isDarkMode ? Colors.white:AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: GestureDetector(
                                onTap: () async {
                                  if(_post.pcount.toString() == '0'){
                                    print('no post available');
                                  }else{
                                    await   Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UserPost(
                                              id: _post.id,

                                            )));
                                  }

                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icon/posts.svg',
                                            height: 20,
                                            color: Get.isDarkMode ? Colors.white:AppColors.POST_TAB_LIKE_COLOR,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("${_post.pcount!} Post",
                                            //_post.votes.toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color:Get.isDarkMode
                                                    ? Colors.white
                                                    :
                                                AppColors.POST_TAB_LIKE_COLOR,
                                                fontFamily: 'Gotham',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //   child: Row(
                                    //     children: [
                                    //       SvgPicture.asset(
                                    //         'assets/icon/chat.svg',
                                    //         height: 20,
                                    //         color: Get.isDarkMode ? Colors.white:AppColors.POST_TAB_LIKE_COLOR,
                                    //       ),
                                    //       SizedBox(
                                    //         width: 10,
                                    //       ),
                                    //       Text("${_post.tcount.toString()} Testimonial",
                                    //
                                    //         style: TextStyle(
                                    //             fontSize: 12,
                                    //             color:Get.isDarkMode
                                    //                 ? Colors.white
                                    //                 :
                                    //             AppColors.POST_TAB_LIKE_COLOR,
                                    //             fontFamily: 'Gotham',
                                    //             fontWeight: FontWeight.bold),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
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
          ))
          ],
        ),
      ),


    );
  }

  void ceateLitener() {
    searchController.addListener(() {

      String text = searchController.text.trim();
      if(text.length<3){
        return;
      }

      getData(text);


    });

  }

  getDate(String dd){
    print(dd);
    DateTime parseDate =
    new DateFormat("yyyy-MM-dd HH:mm:ss").parse(dd);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM dd yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;

  }

  getData(String text) async{

    print("=================xxx");
    var  data = await Apiservice().getSearchData(text);
    print(jsonEncode(data));
    print("=================xxx");
    SerachUserModel searchList= SerachUserModel.fromJson(data);
    setState(() {
      _popularPostList= searchList.response!;
    });
  }


}
