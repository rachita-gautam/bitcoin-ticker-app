import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'price_screen.dart';
import 'networking.dart';
import 'price_screen.dart';

const apiKey = '05543998-A78F-4A67-B331-154349C3E2C6';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override

  void initState(){
    super.initState();
    getExchangeData();
  }

  void getExchangeData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$apiKey');
    var exchangeData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(priceExchange: exchangeData,);
    }));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.indigo,
          size: 120.0,
        ),
      ),
    );
  }
}
