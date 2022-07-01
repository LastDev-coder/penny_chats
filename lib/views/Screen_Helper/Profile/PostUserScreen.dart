import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:penny_chats/controllers/Api/User/UserDataApi.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/PostUserDataModel.dart';

import '../../../ApiService/Apiservice.dart';
import '../../../models/StockAlertModel.dart';
import '../../../models/UserWeeklyWatch.dart';

class PostUserScreen extends StatefulWidget {
  final String? postUserId;

  PostUserScreen({Key? key, this.postUserId}) : super(key: key);

  @override
  _PostUserScreenState createState() => _PostUserScreenState();
}

class _PostUserScreenState extends State<PostUserScreen> {
  DateFormat dateFormat = DateFormat('yyyy');

  PostUserDataModel? _postUserData;

  void initState() {
    UserDataApi.getUserData(
            context, '${AppStrings.getUserDataApi}${widget.postUserId}')
        .then((value) {
      setState(() {
        _postUserData = value;
      });
    });
    super.initState();
  }

  Future userweekly() async {
    List<UserWeeklyWatch> weekmodel = [];
    var data;

    data = await Apiservice().getSearchUserDetails(widget.postUserId.toString());

    var dataresponse = data["response"]['weekly_watch'];
    print(data);
    int i = 0;
    for (var x in dataresponse) {
      // print( dataresponse[i]["id"]);
      UserWeeklyWatch myModel = UserWeeklyWatch(
          dataresponse[i]["id"],
          dataresponse[i]["user_id"],
          dataresponse[i]["stock"],
          DateTime.parse(dataresponse[i]["alert"]),
          dataresponse[i]["description"],
          dataresponse[i]["status"],
          DateTime.parse(dataresponse[i]["created"]),
          DateTime.parse(dataresponse[i]["modified"])
      );
      weekmodel.add(myModel);

      i++;
    }
    return weekmodel;
  }
  Future<bool> ShowDescription(String name,String description) async{
    String text =  _parseHtmlString(description);
    final shouldPop = await showDialog(
      context: context,
      builder: (context) {

        return  AlertDialog(
          title: Text("$name"),
          content: SingleChildScrollView(child: Text("$text")),
        );
      },
    );

    return shouldPop ?? false;
  }
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    String parsedString = "";
    try {
      parsedString = parse(document.body!.text).documentElement!.text;
    } catch (e) {
      parsedString = "";
    }
    return parsedString;
  }

  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(localDate.toString());
    // var outputFormat = DateFormat('yyyy/MM/dd');
    var outputFormat = DateFormat('MM/dd/yy');

    var outputDate = outputFormat.format(inputDate);

    return "${outputDate.toString()}";
  }

  getStockDetails() async {
    List<StockAlertModel> stockmodel = [];
    String text, date;
    var data;

    data = await Apiservice().getSearchUserDetails(widget.postUserId.toString());
    var dataresponse = data["response"]['stock_trades'];

    int i = 0;
    for (var x in dataresponse) {
      date = getFormattedDate(dataresponse[i]["created"]);
      double formattedDouble = double.parse(dataresponse[i]["price_start"].toString());
      var num2 = double.parse(formattedDouble.toStringAsFixed(4));

      StockAlertModel model = StockAlertModel(
          dataresponse[i]["stock"],
          dataresponse[i]["alert"],
          num2.toString(),
          dataresponse[i]["display_order"],
          dataresponse[i]["effect"],
          dataresponse[i]["gain"],
          date,
          dataresponse[i]["modified"]);
      stockmodel.add(model);
      i++;
    }
    return stockmodel;
  }

  String getGain(var ga) {
    String dd = ga.toString().trim();

    if (dd.contains("%")) {
      dd.replaceAll("%", "");
    }

    return "$dd%";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : AppColors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          child: Image.asset(
            'assets/images/profile-bg.jpg',
            fit: BoxFit.cover,
          ),
        ),

        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, 'back');
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
        ),
      ),
      body: _postUserData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      color: Colors.green,
                      height: 260,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/profile-bg.jpg',
                            height: 260,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            height: double.infinity,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: CircleAvatar(
                                    radius: 65,
                                    backgroundImage: _postUserData!
                                            .response!.profilePic!.isNotEmpty
                                        ? NetworkImage(
                                            '${AppStrings.profilePictureApi}/${_postUserData!.response!.profilePic}')
                                        : NetworkImage(
                                            '${AppStrings.noProfilePicture}'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 120, bottom: 80),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _postUserData!
                                                      .response!.isActive ==
                                                  "1"
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 40, right: 30, bottom: 30),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.PROFILE_TAB_LABEL_TEXT,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w500),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  _postUserData!.response!.name.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : AppColors.PROFILE_TAB_NORMAL_TEXT,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                      )),
                  Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 10, right: 30, bottom: 30),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'User name',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.PROFILE_TAB_LABEL_TEXT,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w500),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  _postUserData!.response!.username.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : AppColors.PROFILE_TAB_NORMAL_TEXT,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                      )),
                  Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 10, right: 30, bottom: 30),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'User Since',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.PROFILE_TAB_LABEL_TEXT,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w500),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  dateFormat.format(
                                      _postUserData!.response!.created!),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : AppColors.PROFILE_TAB_NORMAL_TEXT,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                      )),
                  Card(
                    elevation: 2,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10,top: 10,bottom: 20),
                              child: Text(
                                "Stock Alert",
                                style: TextStyle(
                                    color:Get.isDarkMode ? Colors.white : AppColors
                                        .CHAT_SCREEN_BLACK_TEXT,
                                    fontFamily: 'Gotham',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          "Date",
                                          style: TextStyle(
                                              color: AppColors.STOCKALERT_TEXTBOLD,
                                              fontFamily: 'Gotham',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          "Stock",
                                          style: TextStyle(
                                              color: AppColors.STOCKALERT_TEXTBOLD,
                                              fontFamily: 'Gotham',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          "Price",
                                          style: TextStyle(
                                              color: AppColors.STOCKALERT_TEXTBOLD,
                                              fontFamily: 'Gotham',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          "Gain",
                                          style: TextStyle(
                                              color: AppColors.STOCKALERT_TEXTBOLD,
                                              fontFamily: 'Gotham',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8,left: 8),
                              child: Divider(thickness: 1,),
                            ),

                            SizedBox(
                              height: 2,
                            ),
                            FutureBuilder(

                              future: getStockDetails(),
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
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data.length,

                                      itemBuilder: (BuildContext context, int i) {

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [

                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data[i].created,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .STOCKALERT_TEXTBOLD,
                                                              fontFamily: 'Gotham',
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data[i].stock,
                                                          style: TextStyle(
                                                              color: Get.isDarkMode
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                              fontFamily: 'Gotham',
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data[i].price_start,
                                                          style: TextStyle(
                                                              color: Get.isDarkMode
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                              fontFamily: 'Gotham',
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Center(
                                                        child: Text(
                                                          getGain(
                                                              snapshot.data[i].gain),
                                                          style: TextStyle(
                                                              color: snapshot.data[i]
                                                                  .effect ==
                                                                  "Up"
                                                                  ? Colors.green
                                                                  : Colors.green,
                                                              fontFamily: 'Gotham',
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Divider(thickness: 1,),

                                            ],
                                          ),
                                        );
                                      })
                                      : Center(child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text("Sorry! No Stock Alert Found.",
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
                      ),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10,top: 10,bottom: 20),
                              child: Text(
                                "Weekly Watch",
                                style: TextStyle(
                                    color:Get.isDarkMode ? Colors.white : AppColors
                                        .CHAT_SCREEN_BLACK_TEXT,
                                    fontFamily: 'Gotham',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    // color: AppColors.amber,
                                    child: Row(
                                      children: [
                                        Text('DATE',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: AppColors
                                                    .STOCK_ADD_SEARCH,
                                                fontFamily: 'Gotham',
                                                fontWeight:
                                                FontWeight.w500)),
                                        SizedBox(width: 5),
                                        Icon(Icons.compare_arrows,
                                            size: 15),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    // color: AppColors.orange,
                                    child: Row(
                                      children: [
                                        Text('STOCK',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: AppColors
                                                    .STOCK_ADD_SEARCH,
                                                fontFamily: 'Gotham',
                                                fontWeight:
                                                FontWeight.w500)),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.compare_arrows,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('VIEW',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.STOCK_ADD_SEARCH,
                                          fontFamily: 'Gotham',
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(thickness: 1,),
                            SizedBox(
                              height: 10,
                            ),
                            FutureBuilder(

                              future: userweekly(),
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
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data.length,

                                      itemBuilder: (BuildContext context, int i) {

                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Column(
                                            children: [

                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(

                                                      child: Text(
                                                          dateFormat.format(snapshot.data[i].created!),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: AppColors
                                                                  .STOCK_ADD_SEARCH,
                                                              fontFamily:
                                                              'Gotham',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      // color: AppColors.amber,

                                                      child: Text("${snapshot.data[i].stock!}",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:Get.isDarkMode ? Colors.white :
                                                              Colors.black,
                                                              fontFamily:
                                                              'Gotham',
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.visibility,
                                                          size: 12,
                                                          color: AppColors
                                                              .WeeklyWatch_SAVEBUTTON,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        GestureDetector(
                                                          onTap: (){
                                                            ShowDescription(snapshot.data[i].stock!,snapshot.data[i].description!);
                                                          },
                                                          child: Text('More Info',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: AppColors
                                                                      .WeeklyWatch_SAVEBUTTON,
                                                                  fontFamily:
                                                                  'Gotham',
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                        ),
                                                        // SizedBox(
                                                        //   width: 20,
                                                        // ),
                                                        // Icon(
                                                        //   Icons.remove_circle,
                                                        //   size: 12,
                                                        //   color: Colors.red,
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Divider(
                                                thickness: 1,
                                              ),


                                            ],
                                          ),
                                        );
                                      })
                                      : Center(child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text("Sorry! No Weekly Watch Found.",
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
                      ),
                    ),
                  ),

                ],

              ),
            )),
    );
  }
}
