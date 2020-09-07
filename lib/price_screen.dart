import 'package:bitcoin_ticker/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String result1;
  String result2;
  String result3;

  void getExchangeData(String cryp) async {
    CoinData coinData = CoinData(selectedCurrency,cryp);
    var exchangeData = await coinData.getData();
    setState(() {
      if(cryp=='BTC') {
        result1 = exchangeData;
      }
      else if(cryp=='ETH'){
        result2 = exchangeData;
      }
      else{
        result3 = exchangeData;
      }

    });
  }

  void initState(){
    super.initState();
    getExchangeData('BTC');
    getExchangeData('ETH');
    getExchangeData('LTC');
  }
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
          child: Text(currency),
          value: currency
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>
      (value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getExchangeData('BTC');
          getExchangeData('ETH');
          getExchangeData('LTC');
        });
      },
    );
  }
  CupertinoPicker iOSPicker(){
    List<Text> getPickerItems() {
      List<Text> pickerItems = [];
      for (String currency in currenciesList) {
        pickerItems.add(Text(currency));
      }
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      children: getPickerItems(),
    );
  }
  Widget getPicker(){
    if(Platform.isIOS){
      return (iOSPicker());
    }
    else{
      return (androidDropdown());
    }
  }
  String selectedCurrency = 'USD';

//  void updateUI(dynamic exchangeData){
//    setState(() {
//      price = exchangeData['rate'];
//    });
//  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              CryptoCard(cryptoCur: 'BTC', result: result1, selectedCurrency: selectedCurrency),
              CryptoCard(cryptoCur: 'ETH', result: result2, selectedCurrency: selectedCurrency),
              CryptoCard(cryptoCur: 'LTC', result: result3, selectedCurrency: selectedCurrency),
            ],
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPicker()
          ),
        ],
      ),
    );
  }

}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.cryptoCur,
    @required this.result,
    @required this.selectedCurrency,
  }) : super(key: key);
  final String cryptoCur;
  final String result;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCur = $result $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


