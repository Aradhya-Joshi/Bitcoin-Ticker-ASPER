import 'dart:io' show Platform;
import 'package:bitcoin_ticker/price_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}
class _PriceScreenState extends State<PriceScreen> {
  String selectedcur = "USD";
  CupertinoPicker iospicker() {
    List<Text> pickeritem = [];
    for (String cur in currenciesList) {
      pickeritem.add(Text(cur));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (secleterd) {
        // print(secleterd);
      },
      children: pickeritem,
    );
  }

  String cur = "";
  String values = '';

  DropdownButton<String> androidpicker() {
    List<DropdownMenuItem<String>> dropdown = [];

    for (int i = 0; i < currenciesList.length; i++) {
      String curname = (currenciesList[i]);
      var newItem = DropdownMenuItem(
        value: curname,
        child: Text(curname),
      );
      dropdown.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedcur,
      items: dropdown,
      onChanged: (value) {

        setState(() async {
          selectedcur = value!;
          cur = value;

          String p = await getdata(value.toString());
          values = p;
          setState(() {
            values = p;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Coin Tracker",
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0,),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0,),
                child: Text(

                  '1 BTC = $values $cur',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iospicker() : androidpicker(),
          ),
        ],
      ),
    );
  }
}