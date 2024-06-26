import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class Investment extends StatefulWidget {
  const Investment({super.key});

  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {

  int initial =0;
  int years =0;
  int interest=0;


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
                          int x =int.parse(value!);
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
                      
                      const SizedBox(height: 450),
                      FilledButton(
                        onPressed: () {
                          if(_formGlobalKey.currentState!.validate()){
                            _formGlobalKey.currentState!.save();
                          }
                          
                          setState(() {
                            print(years+initial);
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