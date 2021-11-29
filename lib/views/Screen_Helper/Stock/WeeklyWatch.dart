import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/Api/WeeklyWatchApi/WeeklyWatchAPI.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/WeeklyWatchModel.dart';
import 'package:penny_chats/views/Screens/mydashboard.dart';

class WeeklyWatchScreen extends StatefulWidget {
  WeeklyWatchScreen({Key? key}) : super(key: key);

  @override
  _WeeklyWatchScreenState createState() => _WeeklyWatchScreenState();
}

class _WeeklyWatchScreenState extends State<WeeklyWatchScreen> {
  WeeklyWatchModel? _weeklyWatchData;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  String finalDate = '';
  late DateTime _selectedDate;
  TextEditingController dateController = TextEditingController();

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

   _pickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime(2100)
    ) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        dateController.text =    "" ;

        return ;
      }else{
        _selectedDate = pickedDate;
        finalDate = DateFormat('MM/dd/yyyy').format(_selectedDate).toString();
        dateController.text =    finalDate ;

        // setState(() {
        //   //for rebuilding the ui
        //
        // });
        // return DateFormat('MM/dd/yyyy').format(_selectedDate).toString();

      }



      print(DateFormat('MM/dd/yyyy').format(_selectedDate));
    });
  }

  Future<bool> AddAlert() async{
    TextEditingController stockController = TextEditingController();
    TextEditingController descrController = TextEditingController();

    final shouldPop = await showDialog(
      context: context,
      builder: (context) {

        return  AlertDialog(
          title: Text('Weekly Watch '),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {

                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alert',
                            style: TextStyle(
                                color: AppColors.FROMTO_TEXT,
                                fontFamily: 'Gotham',
                                fontSize: 15,
                                fontWeight: FontWeight.normal)
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: GestureDetector(
                            onTap: () async {

                            },
                            child: Container(
                              width: double.infinity,

                              decoration: new BoxDecoration(
                                  color: AppColors.INPUT_BOX,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(5.0),
                                    topRight: const Radius.circular(5.0),
                                    bottomLeft: const Radius.circular(5.0),
                                    bottomRight: const Radius.circular(5.0),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                    controller: dateController,
                                    style: TextStyle(color: AppColors.FROMTO_TEXT),

                                    decoration:
                                    new InputDecoration.collapsed(hintText: '',
                                      hintStyle: TextStyle( color: AppColors.FROMTO_TEXT),

                                    ),
                                    onTap: () async {
                                      await  _pickDateDialog();
                                      setState(() {
                                        //for rebuilding the ui
                                        // var data = _pickDateDialog();
                                        // print(data);
                                        print(dateController.text.toString());
                                      });
                                    }
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        Text('Stock',
                            style: TextStyle(
                                color: AppColors.FROMTO_TEXT,
                                fontFamily: 'Gotham',
                                fontSize: 15,
                                fontWeight: FontWeight.normal)
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Container(
                            decoration: new BoxDecoration(
                                color: AppColors.INPUT_BOX,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(5.0),
                                  topRight: const Radius.circular(5.0),
                                  bottomLeft: const Radius.circular(5.0),
                                  bottomRight: const Radius.circular(5.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                controller: stockController,
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: AppColors.FROMTO_TEXT),

                                decoration:
                                new InputDecoration.collapsed(hintText: '',
                                  hintStyle: TextStyle( color: AppColors.FROMTO_TEXT),

                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        Text('Description',
                            style: TextStyle(
                                color: AppColors.FROMTO_TEXT,
                                fontFamily: 'Gotham',
                                fontSize: 15,
                                fontWeight: FontWeight.normal)
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Container(
                            decoration: new BoxDecoration(
                                color: AppColors.INPUT_BOX,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(5.0),
                                  topRight: const Radius.circular(5.0),
                                  bottomLeft: const Radius.circular(5.0),
                                  bottomRight: const Radius.circular(5.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                maxLines: 6,
                                minLines: 3,
                                controller: descrController,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: AppColors.FROMTO_TEXT),

                                decoration:
                                new InputDecoration.collapsed(hintText: '',
                                  hintStyle: TextStyle( color: AppColors.FROMTO_TEXT),

                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              // onPressed: () => exit(0),
                              color: AppColors.RESULT_TEXT,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: (){
                                // if(spController.text.toString().isEmpty || epController.text.toString().isEmpty){
                                //   setState(() {
                                //   });
                                // }else{
                                //  String  result = "null";
                                //   print("------> "+result);
                                //   setState(() {
                                //     CalculateResult = "$result %";
                                //   });
                                // }
                                _WeeklyWatchScreenState();
                                Navigator.of(context).pop();
                              },
                              child: Text('Close',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gotham',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)
                              ),
                            ),
                            SizedBox(width: 10,),
                            FlatButton(
                              color: AppColors.RESULT_TEXT,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                setState(() async {
                                  if (stockController.text.toString() == null ||
                                      stockController.text.toString().isEmpty ||
                                      stockController.text.toString() == '' ||
                                      descrController.text.toString() == null ||
                                      descrController.text.toString().isEmpty ||
                                      descrController.text.toString() == ''

                                  ) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                            'All fields should be fill up. Please try again.')));
                                  }
                                  else{
                                    var _data = new Map<String, dynamic>();
                                    _data['alert'] = finalDate;
                                    _data['stock'] = stockController.text.toString();
                                    _data['description'] = descrController.text.toString();

                                    print(_data);

                                    var data = await Apiservice().AddWatch(_data).whenComplete(() {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Mydashboard(number: 2,)));
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                data['response'].toString())));
                                    stockController.clear();
                                    descrController.clear();

                                    // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => AddPage())).whenComplete(retrieveData);
                                  }

                                });

                              },
                              child: Text('Submit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gotham',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),

        );
      },
    );

    return shouldPop ?? false;
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

  @override
  void initState() {
    WeeklyWatchApi.getWeeklyWatch(context, AppStrings.getWeeklyWatchApi)
        .then((value) {
      setState(() {
        _weeklyWatchData = value;
      });
    });
    super.initState();
    _WeeklyWatchScreenState();
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
                                  MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      //      color: AppColors.WeeklyWatch_SORTBUTTON,
                                      onPressed: () {
                                        AddAlert();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add_circle_outline,
                                              color: AppColors.STOCKALERT_TEXTBOLD,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('ADD',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.STOCKALERT_TEXTBOLD,
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
                                                        GestureDetector(
                                                          onTap: (){
                                                            ShowDescription(_data.stock!,_data.description!);
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
