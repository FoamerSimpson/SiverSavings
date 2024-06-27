import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:siver_frontend/calculators/mathfunctions/math.dart';

class Investment extends StatefulWidget {
  const Investment({super.key});

  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {

  double initial =0;
  int years =0;
  double interestRate=0;
  double monthly=0;
  double total= 0;

  final _formGlobalKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Investment Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Form(
              
              key: _formGlobalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Initial amount \$:')
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'enter a valid number';
                          }
                          if(!isNumeric(value)){
                            return 'Numbers only';
                          }
                          int? x = int.parse(value);
                          if(x < 0 || x > 10000000){
                            return 'You must enter a value between 0 and 10000000';
                          }
                          return null;
                        },

                        onSaved: (value){
                          double x =double.parse(value!);
                          initial = x;
                        },

                      ),


                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Years:')
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'enter a valid number';
                          }
                          if(!isNumeric(value)){
                            return 'Numbers only';
                          }
                          int? x = int.parse(value);
                          if(x < 0 || x > 70){
                            return 'You must enter a value between 0 and 70';
                          }
                          return null;
                        },
                        onSaved: (value){
                          int x =int.parse(value!);
                          years = x;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Return Rate:')
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'enter a valid number';
                          }
                          if(!isNumeric(value)){
                            return 'Numbers only';
                          }
                          int? x = int.parse(value);
                          if(x < 0 || x > 100){
                            return 'You must enter a value between 0 and 100';
                          }
                          return null;
                        },
                        onSaved: (value){
                          double x =double.parse(value!);
                          interestRate = x;
                        },
                      ),

                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Monthly contributions')
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'enter a valid number';
                          }
                          if(!isNumeric(value)){
                            return 'Numbers only';
                          }
                          int? x = int.parse(value);
                          if(x < 0 || x > 15000){
                            return 'You must enter a value between 0 and 15000';
                          }
                          return null;
                        },
                        onSaved: (value){
                          double x =double.parse(value!);
                          monthly = x;
                        },
                      ),
                      SizedBox(height: 30.0,),
                      Center(
                        child: Text(
                          'Total Amount: \$$total',
                          style: TextStyle(
                            fontFamily: 'Sivir',
                            fontSize: 25.0,
                          ),
                          )
                      ),
                      
                      
                      const SizedBox(height: 300),
                      FilledButton(
                        onPressed: () {
                          if(_formGlobalKey.currentState!.validate()){
                            _formGlobalKey.currentState!.save();
                          }
                          
                          setState(() {
                            total= investmentCalculation(initial, years, interestRate, monthly);
                          });
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                          )
                        ),
                        child: Text('Submit'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }
}