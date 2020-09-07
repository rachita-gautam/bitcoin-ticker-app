import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '05543998-A78F-4A67-B331-154349C3E2C6';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
    CoinData(this.cur,this.cryp);
    String cur;
    String cryp;

    Future<dynamic> getData() async {
      http.Response response = await http.get('https://rest.coinapi.io/v1/exchangerate/$cryp/$cur?apikey=$apiKey');
      if (response.statusCode == 200) {
        String data = response.body;
        double result = jsonDecode(data)['rate'];
        return result.toStringAsFixed(0) ;
      }
      else {
        print(response.statusCode);
      }
    }
}
