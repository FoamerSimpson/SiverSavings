import 'package:flutter/material.dart';
import 'objects/stockobj.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Stocks extends StatefulWidget {
  const Stocks({super.key});

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  List<Stock> Stocklist = [
    Stock(ticker: "APPL", value: "102"),
    Stock(ticker: "FORD", value: "122"),
    Stock(ticker: "TSLA", value: "142")
  ];

  final TextEditingController tickerController = TextEditingController();

  Future<void> fetchStockPrice(String ticker) async {
    final String apiUrl = 'http://10.0.2.2:5000/get_stock_price/$ticker';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String stockPrice = data['price'].toString();
        
        
        setState(() {
          Stocklist.add(Stock(ticker: ticker, value: stockPrice));
        });

        tickerController.clear();
      } else {
        
        print("Failed to fetch stock price: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching stock price: $e");
    }
  }

  Widget stockTemplate(Stock stock) {
    return Card(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: Column(
        children: <Widget>[
          Text('${stock.ticker} - ${stock.value}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 25.0
            )        
          ),
          SizedBox(height: 6.0), 
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: tickerController,
                decoration: InputDecoration(
                  labelText: 'Enter Ticker Symbol',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                fetchStockPrice(tickerController.text);
              },
              child: Text('Add Stock'),
            ),
            Expanded(
              child: ListView(
                children: Stocklist.map((stock) => stockTemplate(stock)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
