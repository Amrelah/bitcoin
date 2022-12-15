import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();

  DropdownButton getDropdownButton() {
    List<DropdownMenuItem<String>> ddItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      ddItems.add(item);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: ddItems,
      onChanged: (val) {
        setState(() {
          selectedCurrency = val!;
          Btc = '?';
          Eth = '?';
          Ltc = '?';
        });
        updateUI();
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Widget> items = [];
    for (String currency in currenciesList) {
      Widget item = Text(currency);
      items.add(item);
    }
    return CupertinoPicker(
      itemExtent: 35.0,
      onSelectedItemChanged: (val) {
        print(val);
      },
      children: items,
    );
  }

  //TODO: Create a method here called getData() to get the coin data from coin_data.dart
  updateUI() async {
    await getData(selectedCurrency);
    setState(() {
      Btc = '${data[0]}';
      Eth = '${data[1]}';
      Ltc = '${data[2]}';
    });
    data.clear();
  }

  @override
  void initState() {
    super.initState();
    //TODO: Call getData() when the screen loads up.
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DisplayContainer(
              Crypto: 'BTC', value: Btc, Currency: selectedCurrency),
          DisplayContainer(
              Crypto: 'ETH', value: Eth, Currency: selectedCurrency),
          DisplayContainer(
              Crypto: 'LTC', value: Ltc, Currency: selectedCurrency),
          Expanded(child: SizedBox()),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}

class DisplayContainer extends StatelessWidget {
  final String Crypto;
  final String value;
  final String Currency;
  DisplayContainer(
      {required this.Crypto, required this.value, required this.Currency});

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
            //TODO: Update the Text Widget with the live bitcoin data here.
            '1 $Crypto = $value $Currency',
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
