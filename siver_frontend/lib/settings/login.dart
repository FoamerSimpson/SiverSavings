import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String username ='';

  String password='';

  String returnMessage='';

  final _formGlobalKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Login'),
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
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          label: Text('username:')
                        ),
                        validator: (value) {
                          return null;
                          
                        },
                        onSaved: (value){
                          
                          username = value!;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          label: Text('password:')
                        ),
                        validator: (value) {
                          return null;
                        
                          
                        },
                        onSaved: (value){
                          password = value!;
                        },
                      ),

                      const SizedBox(height: 30.0,),
                      Center(
                        child: Text(
                           returnMessage,
                          style: const TextStyle(
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
  
                          var response = await http.post(Uri.parse('http://10.0.2.2:5000/login'),
                              headers: {
                                'Content-Type': 'application/json', // Set headers
                              },
                            body:  jsonEncode({
                              'username': username,
                              'password': password,

                            })
                          );
                          
                          setState(() {
                            var responseBody = jsonDecode(response.body);
                            if (response.statusCode==400){
                              returnMessage = responseBody['error'];
                            }else{
                              returnMessage = responseBody['message'];
                            }
                            
                            
                          });
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                          )
                        ),
                        child: const Text('Submit'),
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