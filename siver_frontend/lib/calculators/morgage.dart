import 'package:flutter/material.dart';
import 'package:siver_frontend/calculators/mathfunctions/math.dart';
import 'package:string_validator/string_validator.dart';

class Morgage extends StatefulWidget {
  const Morgage({super.key});

  @override
  State<Morgage> createState() => _MorgageState();
}

class _MorgageState extends State<Morgage> {
  double loanAmount =0;

  double years =0;

  double interestRate=0;

  double monthly=0;

  String total= '';

  final _formGlobalKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Morgage Calculator'),
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
                          label: Text('Loan amount \$:')
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
                          loanAmount = x;
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
                          double x =double.parse(value!);
                          years = x;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Interest Rate:')
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

                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   decoration: const InputDecoration(
                      //     label: Text('Monthly contributions')
                      //   ),
                      //   validator: (value) {
                      //     if(value == null || value.isEmpty){
                      //       return 'enter a valid number';
                      //     }
                      //     if(!isNumeric(value)){
                      //       return 'Numbers only';
                      //     }
                      //     int? x = int.parse(value);
                      //     if(x < 0 || x > 15000){
                      //       return 'You must enter a value between 0 and 15000';
                      //     }
                      //     return null;
                      //   },
                      //   onSaved: (value){
                      //     double x =double.parse(value!);
                      //     monthly = x;
                      //   },
                      //),
                      SizedBox(height: 30.0,),
                      Center(
                        child: Text(
                          'Monthly payment: $total\$',
                          style: TextStyle(
                            fontFamily: 'Sivir',
                            fontSize: 25.0,
                          ),
                          )
                      ),
                      
                      
                      const SizedBox(height: 250),
                      FilledButton(
                        onPressed: () {
                          if(_formGlobalKey.currentState!.validate()){
                            _formGlobalKey.currentState!.save();
                          }
                          
                          setState(() {
                            total= morgageCalculation(loanAmount, years, interestRate);
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