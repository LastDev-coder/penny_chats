import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/StockAlertModel.dart';

class NoStocks extends StatefulWidget {
  NoStocks({Key? key}) : super(key: key);

  @override
  _NoStocksState createState() => _NoStocksState();
}

class _NoStocksState extends State<NoStocks> {

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

    data = await Apiservice().StockAlert();
    var dataresponse = data["response"];

    int i = 0;
    for (var x in dataresponse) {
       date = getFormattedDate(dataresponse[i]["created"]);

      StockAlertModel model = StockAlertModel(
          dataresponse[i]["stock"],
          dataresponse[i]["alert"],
          dataresponse[i]["price_start"],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 0),
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      color: AppColors.WeeklyWatch_SORTBUTTON,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                            bottom: 5),
                        child: Row(
                          children: [
                            Text('Sort by A-Z',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors
                                        .STOCK_ADD_SEARCH,
                                    fontFamily: 'Gotham',
                                    fontWeight:
                                    FontWeight.w500)),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: AppColors.WeeklyWatch_SORTBUTTON,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                            bottom: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: AppColors.WeeklyWatch_SAVEBUTTON,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Edit',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.WeeklyWatch_SAVEBUTTON,
                                    fontFamily: 'Gotham',
                                    fontWeight:
                                    FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
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
              Expanded(
                child: FutureBuilder(
                  future: getStockDetails(),
                  // initialData: InitialData,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                            child: CupertinoActivityIndicator(
                                animating: true, radius: 15)),
                      );
                    } else {
                    return  snapshot.data.length.toString() != "0" || snapshot.data.length.toString() != "null" ?
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int i) {
                          return   Padding(
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
                                            snapshot.data[i].stock,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Gotham',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            snapshot.data[i].price_start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Gotham',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            "${snapshot.data[i].gain} %",
                                            style: TextStyle(
                                                color: snapshot.data[i].effect=="Up" ? Colors.green : Colors.red,
                                                fontFamily: 'Gotham',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )),
                                  ],
                                ),
                             SizedBox(height: 5,),
                             Divider()
                              ],
                            ),
                          ) ;
                        },
                      ) :  NoStock();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  NoStock() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextButton(
            onPressed: () => {},

            // padding: EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(
                    Icons.search,
                    size: 20,
                    color: AppColors.STOCK_ADD_SEARCH,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text("Search for stocks",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.STOCK_ADD_SEARCH,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w500)),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45, right: 45),
            child: Text(
                'THERE IS NO STOCK ALERT YET, PLEASE ADD STOCK TO WATCH',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.STOCK_ADD_SEARCH,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 100, left: 100),
            child: DottedBorder(
              color: AppColors.STOCK_ADD_SEARCH,
              dashPattern: [10],
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                height: 40,
                onPressed: () => {},

                // padding: EdgeInsets.all(10.0),
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 20,
                      color: AppColors.STOCK_ADD_SEARCH,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text("Add Stock Alert",
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.STOCK_ADD_SEARCH,
                              fontFamily: 'Gotham',
                              fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
