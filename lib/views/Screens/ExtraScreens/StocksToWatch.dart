import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/StockToWatchModel.dart';
import 'package:penny_chats/views/Screens/ExtraScreens/NewsDetails.dart';

import '../appdrawer.dart';

class StocksToWatch extends StatefulWidget {
  final String id;

  const StocksToWatch({Key? key, required this.id}) : super(key: key);

  @override
  _StocksToWatchState createState() => _StocksToWatchState();
}

class _StocksToWatchState extends State<StocksToWatch> {
  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('dd-yyyy');
    var outputmonthFormat = DateFormat('MMMM');
    var outputTimeFormat = DateFormat('hh:mm a');

    var outputmonth = outputmonthFormat.format(inputDate);
    var outputTime = outputTimeFormat.format(inputDate);

    String month = outputmonth.toString();
    String time = outputTime.toString();
    var outputDate = outputFormat.format(inputDate);

    return "$time $month-${outputDate.toString()}";
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

  Future getstock() async {
    List<StockToWatchModel> stockmodel = [];
    String text, date;
    var data;

    data = await Apiservice().getStocktoWatch(widget.id);

    var dataresponse = data["response"];

    int i = 0;
    for (var x in dataresponse) {
      text = _parseHtmlString(dataresponse[i]["content"]);

      date = getFormattedDate(dataresponse[i]["created"]);
      StockToWatchModel model = StockToWatchModel(
        dataresponse[i]["newscategory"],
        dataresponse[i]["title"],
        dataresponse[i]["url_title"],
        text,
        dataresponse[i]["img_news"],
        dataresponse[i]["img_caption"],
        date,
        dataresponse[i]["modified"],
      );
      stockmodel.add(model);
      i++;
    }
    return stockmodel;
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
        title: Text(widget.id == "2"
            ? "Penny Stocks To Watch"
            : (widget.id == "3" ? "Penny Stocks Help" : "Upcoming IPO Stocks")),
      ),
      body: FutureBuilder(
        future: getstock(),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child:
                      CupertinoActivityIndicator(animating: true, radius: 15)),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsDetails(
                                    id: widget.id,
                                    title: snapshot.data[i].title,
                                    content: snapshot.data[i].content,
                                    time: snapshot.data[i].created,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Get.isDarkMode ? Colors.transparent : Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        // <-- Radius
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.network(
                                "https://www.pennychats.com/beta/uploads/stocknews/${snapshot.data[i].img_news}")),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            '${snapshot.data[i].title}',
                            style: TextStyle(
                                color: AppColors.WeeklyWatch_SAVEBUTTON,
                                fontFamily: 'Gotham',
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            'PennyChats',
                            style: TextStyle(
                                color: Get.isDarkMode ? Colors.white : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                fontFamily: 'Gotham',
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            '${snapshot.data[i].created}',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.4,
                              color: Get.isDarkMode ? Colors.white38 :AppColors.POST_TAB_COMMENTS_COLOR,
                              fontFamily: 'Gotham',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
