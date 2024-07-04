import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _MorgageState();
}

class _MorgageState extends State<Register> {
  String email ='';

  String username ='';

  String password='';

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
                          label: Text('Email:')
                        ),
                        validator: (value) {
                          
                        },

                        onSaved: (value){
                          
                          email = value!;
                        },

                      ),


                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('username:')
                        ),
                        validator: (value) {
                          
                        },
                        onSaved: (value){
                          
                          username = value!;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('password:')
                        ),
                        validator: (value) {
                          
                        },
                        onSaved: (value){
                          password = value!;
                        },
                      ),

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
                        onPressed: () async {
                          if(_formGlobalKey.currentState!.validate()){
                            _formGlobalKey.currentState!.save();
                          }

                          var response = await http.post(Uri.parse('http://10.0.2.2:5000/contact'),
                              headers: {
                                'Content-Type': 'application/json', // Set headers
                              },
                            body:  jsonEncode({
                              'email': email,
                              'username': username,
                              'password': password,

                            })
                          );
                          
                          setState(() {
                            var responseBody = jsonDecode(response.body);
                            total = responseBody['message'];
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