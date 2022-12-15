//TODO: Add your imports here.
import 'dart:convert';
import 'package:http/http.dart' as http;

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '1CCFBEAA-E5A9-42DF-A552-59CF07AC7D50';

class CoinData {
  //TODO: Create your getCoinData() method here.

  Future getCoinData(String cry, String curr) async {
    http.Response data =
        await http.get(Uri.parse('$coinAPIURL/$cry/$curr?apikey=$apiKey'));
    return jsonDecode(data.body);
  }
}

CoinData coinData = CoinData();
var result, result1;
String Btc = '?';
String Eth = '?';
String Ltc = '?';

List<int> data = [];
Future getData(String currency) async {
  print('$Btc,  $Eth,  $Ltc\n\n');
  for (String crypt in cryptoList) {
    result = await coinData.getCoinData(crypt, currency);
    double res1 = result['rate'];
    int res2 = res1.toInt();
    data.add(res2);
  }
  print('$Btc,  $Eth,  $Ltc\n\n');
}
