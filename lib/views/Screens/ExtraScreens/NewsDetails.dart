import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

import '../../../ApiService/Apiservice.dart';
import '../../../models/NewsDetailsModel.dart';

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

  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();


  MyComment(String name, String comment, String news_id, String url_title) async {
    String title = url_title.replaceAll(' ','-');
    var _data = new Map<String, dynamic>();
    _data['news_id'] = news_id;
    _data['url_title'] = title;
    _data['cmt_name'] = name;
    _data['comment'] = comment;
    // print("$title");
    print(_data);

    var data = await Apiservice().PostCommentPennyPlay(_data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(data["response"].toString())));
    // Navigator.of(context).pop();
  }

  PostDetail() async {
    List<NewsDetailsModel> postmodel = [];

    var data = await Apiservice().getPostDetailsPennyPlay(widget.title.replaceAll(' ','-'));
    var commentdata = data["response"]["comment"];
    print(commentdata);
    int i = 0;
    for (var x in data["response"]["comment"]) {
      // date = getFormattedDate(dataresponse[i]["created"]);

      NewsDetailsModel model = NewsDetailsModel(
          data["response"]["comment"][i]["title"],
          data["response"]["comment"][i]["id"],
          data["response"]["comment"][i]["news_id"],
          data["response"]["comment"][i]["cmt_name"],
          data["response"]["comment"][i]["cmt_email"],
          data["response"]["comment"][i]["comment"],
          data["response"]["comment"][i]["created"],
          data["response"]["comment"][i]["status"]
      );
      postmodel.add(model);
      i++;
    }

// setState(() {
//
// });
    return postmodel;
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
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Divider(
                thickness: 1,
                color: AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
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
                  controller: nameController,
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
                      hintText: 'Write your name',
                      hintStyle: TextStyle(
                        fontSize: 11.0,
                        color: AppColors.POST_DETAILS_COMMENTBOX_HINT,
                        fontWeight: FontWeight.w500,
                      )),
                  validator: (value) {},
                ),
              ),
            ),

            Container(
              // height: 20,
              margin: EdgeInsets.only(left: 10,right: 10),
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
                  controller: commentController,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 0),
                  child: Container(
                    height: 40,
                    width: 150,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: AppColors.LOGIN_PAGE_LOGINBOX,
                        onPressed: () async {
                          if (nameController.text.toString() == null ||
                              nameController.text.toString().isEmpty ||
                              nameController.text.toString() == '' ||
                              commentController.text.toString() == null ||
                              commentController.text.toString().isEmpty ||
                              commentController.text.toString() == ''
                              ) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'All fields should be fill up. Please try again.')));
                          }else{
                            MyComment(nameController.text.toString(), commentController.text.toString(), widget.id, widget.title);
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: 'Gotham',
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Divider(
                thickness: 1,
                color: AppColors.POST_TAB_FAVOURITE_TIME_COLOR,
              ),
            ),

            FutureBuilder(
              future: PostDetail(),
              // initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                      // postComment = snapshot.data.length.toString();
                      // print("***********"+postComment);

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

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
                                            '${snapshot.data[i].cmt_name}',
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
                                        Text(
                                          '${snapshot.data[i].comment}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors
                                                  .POST_TAB_COMMENTS_COLOR,
                                              fontFamily: 'Gotham',
                                              fontWeight:
                                              FontWeight.w500),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15,
                                              top: 10,
                                              bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .end,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 5),
                                                child: Text(
                                                  'Posted on :',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .POST_DETAILS_ICONTEXT,
                                                      fontFamily:
                                                      'Gotham',
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .w400),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 5),
                                                child: Text(
                                                  '${snapshot.data[i].created}',
                                                  style: TextStyle(
                                                      color: AppColors
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
                                        ),

                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
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
    );
  }
}
