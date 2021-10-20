import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/Api/WeeklyWatchApi/WeeklyWatchAPI.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/WeeklyWatchModel.dart';

class WeeklyWatchScreen extends StatefulWidget {
  WeeklyWatchScreen({Key? key}) : super(key: key);

  @override
  _WeeklyWatchScreenState createState() => _WeeklyWatchScreenState();
}

class _WeeklyWatchScreenState extends State<WeeklyWatchScreen> {
  WeeklyWatchModel? _weeklyWatchData;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    WeeklyWatchApi.getWeeklyWatch(context, AppStrings.getWeeklyWatchApi)
        .then((value) {
      setState(() {
        _weeklyWatchData = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _weeklyWatchData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                  Container(
                    height: MediaQuery.of(context).size.height,
                    color: AppColors.WeeklyWatch_BACKGROUND,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: AppColors.white,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
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
                                      color: AppColors.WeeklyWatch_SAVEBUTTON,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.save,
                                              color: AppColors.white,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('SAVE',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.white,
                                                    fontFamily: 'Gotham',
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
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
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          _weeklyWatchData!.response!.length,
                                      itemBuilder: (context, index) {
                                        var _data =
                                            _weeklyWatchData!.response![index];
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
                                                      // color: AppColors.amber,

                                                      child: Text(
                                                          dateFormat.format(
                                                              _data.created!),
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

                                                      child: Text(_data.stock!,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
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
                                                        Text('More Info',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .WeeklyWatch_SAVEBUTTON,
                                                                fontFamily:
                                                                    'Gotham',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Icon(
                                                          Icons.remove_circle,
                                                          size: 12,
                                                          color: Colors.red,
                                                        )
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
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
