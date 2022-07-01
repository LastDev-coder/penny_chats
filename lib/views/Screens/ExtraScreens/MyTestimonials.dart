import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/MyTestimonialsModel.dart';

import '../appdrawer.dart';

class MyTestimonials extends StatefulWidget {
  const MyTestimonials({Key? key}) : super(key: key);

  @override
  _MyTestimonialsState createState() => _MyTestimonialsState();
}

class _MyTestimonialsState extends State<MyTestimonials> {
  Future getmytestimonial(String field) async {
    List<MyTestimonialsModel> testimodel = [];
    var data;

    data = await Apiservice().getTestimonial();

    var dataresponse = data["response"]['$field'];
print(data);
    int i = 0;
    for (var x in dataresponse) {
      print(i.toString());
      // print( dataresponse[i]["id"]);
      MyTestimonialsModel myTestimonialsModel = MyTestimonialsModel(
          dataresponse[i]["id"],
          dataresponse[i]["user_id"],
          dataresponse[i]["content"],
          dataresponse[i]["status"],
          dataresponse[i]["created"],
          dataresponse[i]["modified"],
          dataresponse[i]["name"],
          dataresponse[i]["profile_pic"]
      );
      testimodel.add(myTestimonialsModel);
      i++;
    }
    return testimodel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: appdrawer(),
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
          title: Text("My Testimonials"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 20),
                child: Text(
                  "My Testimonials",
                  style: TextStyle(
                      color:Get.isDarkMode ? Colors.white : AppColors
                          .CHAT_SCREEN_BLACK_TEXT,
                      fontFamily: 'Gotham',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              FutureBuilder(

                future: getmytestimonial('my_testimonials'),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                          child: CupertinoActivityIndicator(
                              animating: true, radius: 15)),
                    );
                  } else {
                    return snapshot.data.length.toString() != "0"
                        ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Image.network(
                                              "https://www.pennychats.com/uploads/profile_pictures/${snapshot.data[i].profile_pic}",height: 200,)),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                " ${snapshot.data[i].content}",
                                                style: TextStyle(
                                                    color:Get.isDarkMode ? Colors.white : AppColors
                                                        .CHAT_SCREEN_BLACK_TEXT,
                                                    fontFamily: 'Gotham',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      height: 30,
                                                      child: VerticalDivider(
                                                        color: AppColors
                                                            .WeeklyWatch_SAVEBUTTON,
                                                        thickness: 2,
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 0, right: 20),
                                                    child: Container(
                                                      width: 90,
                                                      child: Text(
                                                        "${snapshot.data[i].name}",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .WeeklyWatch_SAVEBUTTON,
                                                            fontFamily: 'Gotham',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text("Sorry! No Testimonial Found.",
                          style: TextStyle(
                              color:Get.isDarkMode ? Colors.white : AppColors
                                  .CHAT_SCREEN_BLACK_TEXT,
                              fontFamily: 'Gotham',
                              fontSize: 16,
                              fontWeight: FontWeight.w400)
                      ),
                    ));
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 20),
                child: Text(
                  "My Pending Testimonials",
                  style: TextStyle(
                      color:Get.isDarkMode ? Colors.white : AppColors
                          .CHAT_SCREEN_BLACK_TEXT,
                      fontFamily: 'Gotham',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              FutureBuilder(
                future: getmytestimonial('pending_testimonials'),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                          child: CupertinoActivityIndicator(
                              animating: true, radius: 15)),
                    );
                  } else {
                    return snapshot.data.length.toString() != "0"
                        ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),

                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Image.network(
                                      "https://www.pennychats.com/uploads/profile_pictures/${snapshot.data[i].profile_pic}",height: 200,)),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          " ${snapshot.data[i].content}",
                                          style: TextStyle(
                                              color:Get.isDarkMode ? Colors.white : AppColors
                                                  .CHAT_SCREEN_BLACK_TEXT,
                                              fontFamily: 'Gotham',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                height: 30,
                                                child: VerticalDivider(
                                                  color: AppColors
                                                      .WeeklyWatch_SAVEBUTTON,
                                                  thickness: 2,
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0, right: 20),
                                              child: Container(
                                                width: 90,
                                                child: Text(
                                                  "${snapshot.data[i].name}",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .WeeklyWatch_SAVEBUTTON,
                                                      fontFamily: 'Gotham',
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Center(child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text("Sorry! No Pending Testimonial Found.",
                          style: TextStyle(
                          color:Get.isDarkMode ? Colors.white : AppColors
                          .CHAT_SCREEN_BLACK_TEXT,
                          fontFamily: 'Gotham',
                          fontSize: 16,
                          fontWeight: FontWeight.w400)
                    ),
                        ));
                  }
                },
              ),
            ],
          ),
        ));
  }
}
