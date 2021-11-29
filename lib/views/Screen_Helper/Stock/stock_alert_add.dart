import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/StockAlertModel.dart';
import 'package:penny_chats/views/Screens/mydashboard.dart';

class NoStocks extends StatefulWidget {
  NoStocks({Key? key}) : super(key: key);

  @override
  _NoStocksState createState() => _NoStocksState();
}

class _NoStocksState extends State<NoStocks> {
  List<String> _options = ['Up','Down'];
  String _selectedOption = "Up";
  String finalDate = '';
  late DateTime _selectedDate;
  TextEditingController dateController = TextEditingController();

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
    TextEditingController priceController = TextEditingController();
    TextEditingController gainController = TextEditingController();

    final shouldPop = await showDialog(
      context: context,
      builder: (context) {

        return  AlertDialog(
          title: Text('Add Stock '),
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

                        Text('Price',
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
                                controller: priceController,
                                keyboardType: TextInputType.number,
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

                        Text('Gain',
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
                                controller: gainController,
                                keyboardType: TextInputType.number,
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

                        Text('Effect',
                            style: TextStyle(
                                color: AppColors.FROMTO_TEXT,
                                fontFamily: 'Gotham',
                                fontSize: 15,
                                fontWeight: FontWeight.normal)
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0,bottom: 10),
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
                              padding: const EdgeInsets.only(top: 0,right: 10,left: 10,bottom: 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text("Topic",
                                      style: TextStyle(
                                          color: AppColors.FROMTO_TEXT,
                                          fontFamily: 'Gotham',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal)),
                                  // Not necessary for Option 1
                                  value: _selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedOption = value.toString();
                                    });
                                  },
                                  items: _options.map((op) {
                                    return DropdownMenuItem(
                                      child: new Text(op),
                                      value: op,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),

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
                                      priceController.text.toString() == null ||
                                      priceController.text.toString().isEmpty ||
                                      priceController.text.toString() == '' ||
                                      gainController.text.toString() == null ||
                                      gainController.text.toString().isEmpty ||
                                      gainController.text.toString() == ''
                                      ) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                            'All fields should be fill up. Please try again.')));
                                  }
                                  else{
                                    var _data = new Map<String, dynamic>();
                                    _data['alert'] = finalDate;
                                    _data['stock'] = stockController.text.toString();
                                    _data['price_start'] = priceController.text.toString();
                                    _data['gain'] = gainController.text.toString();
                                    _data['effect'] = _selectedOption;
                                    print(_data);

                                    var data = await Apiservice().AddStock(_data).whenComplete(() {
                                      stockController.clear();
                                      priceController.clear();
                                      gainController.clear();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Mydashboard(number: 1,)));
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                data['response'].toString())));

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
