import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/FAQModel.dart';

import '../../../models/TradingModel.dart';
import '../appdrawer.dart';

class Trading extends StatefulWidget {
  Trading({Key? key}) : super(key: key);

  @override
  _TradingState createState() => _TradingState();
}

class _TradingState extends State<Trading> {
  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('dd yyyy');
    var outputmonthFormat = DateFormat('MMMM');
    var outputmonth = outputmonthFormat.format(inputDate);
    String month = outputmonth.toString();
    var outputDate = outputFormat.format(inputDate);

    return "$month  ${outputDate.toString()}";
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

  String? _parseHtmlImage(String htmlString){
    final document = parse(htmlString);
    final element;
    String? parsedString = "";
    try {
      parsedString = document.getElementsByTagName('img') as String?;
    } catch (e) {
      parsedString = "";
    }
    return htmlString;
  }

  Future gettrade() async {
    List<TradingModel> faqmodel = [];
    String text,url, date;
    var data;

    data = await Apiservice().getTrading();

    var dataresponse = data["response"];

    int i = 0;
    for (var x in dataresponse) {
      text = _parseHtmlString(dataresponse[i]["content"]);
      url = _parseHtmlImage(dataresponse[i]["content"])!;
      print('url ==================='+ url.toString());
      date = getFormattedDate(dataresponse[i]["created"]);
      TradingModel model = TradingModel(
          dataresponse[i]["title"], text,url, date, dataresponse[i]["modified"]);
      faqmodel.add(model);
      i++;
    }
    return faqmodel;
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context).copyWith(dividerColor: Colors.transparent); //new

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
        title: Text("Trading 101"),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Container(
              width: double.infinity,
              height: 150,
              child: Stack(
                children: [
                  Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                            "https://pennychats.com/assets/images/list-img.png")),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black.withOpacity(0.2),
                      ),
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  Center(
                      child: Text("Trading Tips By Our Experts",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Gotham',
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: gettrade(),
              // initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                        child: CupertinoActivityIndicator(
                            animating: true, radius: 15)),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 5, bottom: 2.5),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0,
                                left: 10.0,
                                right: 10.0,
                                bottom: 10.0),
                            child: Theme(
                              data: theme,
                              child: Column(
                                children: [
                                  ExpansionTile(
                                    title: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text((i + 1).toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Gotham',
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Text(
                                              '${snapshot.data[i].title}',
                                              style: TextStyle(
                                                  color:Get.isDarkMode ? Colors.white : Colors.black,
                                                  fontFamily: 'Gotham',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: <Widget>[

                                      Html(
                                        data: '${snapshot.data[i].image}',

                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       left: 25, right: 10),
                                      //   child: Text(
                                      //     '${snapshot.data[i].ans}',
                                      //     style: TextStyle(
                                      //       fontSize: 14,
                                      //       height: 1.4,
                                      //       color: Get.isDarkMode ? Colors.white38 : AppColors
                                      //           .POST_TAB_COMMENTS_COLOR,
                                      //       fontFamily: 'Gotham',
                                      //     ),
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       left: 10, right: 10),
                                      //   child: Image.network('${snapshot.data[i].image}'),
                                      // ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Divider(
                                      color: Get.isDarkMode ? Colors.white:AppColors
                                          .POST_TAB_FAVOURITE_TIME_COLOR,
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Card(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: CircleAvatar(
                                                radius: 15,
                                                backgroundImage: AssetImage(
                                                  'assets/images/_logo.png',

                                                )
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            // width: MediaQuery.of(context).size.width *0.15,

                                            child: Text(
                                              "PennyChats",
                                              style: TextStyle(
                                                  color: Get.isDarkMode ? Colors.white:AppColors
                                                      .POST_TAB_FAVOURITE_TIME_COLOR,
                                                  fontFamily: 'Gotham',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          SvgPicture.asset(
                                            'assets/icon/clock.svg',
                                            color: Get.isDarkMode ? Colors.white:AppColors
                                                .POST_TAB_FAVOURITE_TIME_COLOR,
                                            height: 18,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              child: Text(
                                                '${snapshot.data[i].created}',
                                                style: TextStyle(
                                                    color: Get.isDarkMode ? Colors.white:AppColors
                                                        .POST_TAB_FAVOURITE_TIME_COLOR,
                                                    fontFamily: 'Gotham',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),


    );
  }
}
