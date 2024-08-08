import 'package:flutter/material.dart';
import 'objects/stockobj.dart';

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



  Widget stockTemplate(Stock){
    return Card(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: Column(
        children: <Widget>[
          Text('${Stock.ticker} - ${Stock.value}',
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
      body: Center(
        child: ListView(
          children: Stocklist.map((stock) => stockTemplate(stock)).toList(),
        ),
      ),
    );
  }
}