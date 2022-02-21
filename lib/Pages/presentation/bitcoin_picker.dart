import 'package:cryptoapp/Pages/application/services/currency.dart';
import 'package:cryptoapp/Pages/application/themes/coin_data.dart';
import 'package:cryptoapp/Pages/application/themes/colors.dart';
import 'package:cryptoapp/Pages/mode.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BitCoin extends StatefulWidget {
  @override
  _BitCoinState createState() => _BitCoinState();
}

class _BitCoinState extends State<BitCoin> {
  /// set the default currency
  String selectedCurrency = 'USD';
  Map<String, String> coinValues = {};
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    getCurrenciesData();
  }

  getCurrenciesData() async {
    isWaiting = true;
    try {
      dynamic data = await Currency().getCurrencies(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  List<DropdownMenuItem> dropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      //for every currency in the list we create a new dropdownmenu item
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      // add to the list of menu item
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: blue8,
      appBar: AppBar(title: Text('Crypto App'), actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Mode()));
          },
        )
      ]),
      body: Column(
        children: [
          Expanded(
            child: new FutureBuilder(
              future: fetchassetsData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var assets = snapshot.data;
                  print("cgfkygljbjn$assets");
                  return new ListView.builder(
                      itemCount: assets.length,
                      itemBuilder: (context, index) {
                        return new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(assets[index]["asset_id"].toString(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                              new Text(assets[index]["name"].toString(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                              new Text(assets[index]["price_usd"].toString(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                              new Divider()
                            ]);
                      });
                } else if (snapshot.hasError) {
                  return new Text("${snapshot.error}");
                }

                // By default, show a loading spinner
                return new CircularProgressIndicator();
              },
            ),
          ),
          Container(
            height: 75.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 20.0),
            // color: Colors.pink,
            child: DropdownButton<String>(
              dropdownColor: white,
              value: selectedCurrency,
              items: dropDown(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value;

                  /// call this function each time the value in the drop down changes.
                  getCurrenciesData();
                });
              },
            ),
          ),
        ],
      ),
      // ],
      // ),
    );
  }

  Future fetchassetsData() async {
    var header = {"X-CoinAPI-Key": "9A2F88EB-DC4C-444C-8C6C-7C172F79C4D7"};
    var url = Uri.parse('https://rest.coinapi.io/v1/assets');
    var data = await http.get(
      url,
      headers: header,
    );

    if (data.statusCode == 200) {
      var utfDecode = utf8.decode(data.bodyBytes);
      var response = json.decode(utfDecode);
      print("hdbsjkadnajsndkaskm $response ");
      return response;
    } else {
      print(data.statusCode.toString());
    }
  }
}
