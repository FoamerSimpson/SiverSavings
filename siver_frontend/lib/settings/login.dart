import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:siver_frontend/sessionprovider.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? sessionCookie;

  String username ='';

  String password='';

  String returnMessage='';

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formGlobalKey=GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveSessionCookie(String? cookie) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessionCookie', cookie ?? '');
  }

  String? getSessionCookie(){
    return sessionCookie;
  }


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
                        controller: _usernameController,
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
                        controller: _passwordController,
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
                          try{  
                          var response = await http.post(Uri.parse('http://10.0.2.2:5000/login'),
                              headers: {
                                'Content-Type': 'application/json', 
                              },
                            body:  jsonEncode({
                              'username': username,
                              'password': password,

                            })
                          ).timeout(const Duration(seconds: 3));
                          if (!mounted) return;
                          
                          setState(() {
                            var responseBody = jsonDecode(response.body);
                            if (response.statusCode==400){
                              returnMessage = responseBody['error'];
                              _passwordController.clear();
                            }else{
                              returnMessage = responseBody['message'];
                              sessionCookie = response.headers['set-cookie'];
                              Provider.of<SessionProvider>(context, listen: false).setSessionCookie(sessionCookie);
                              _saveSessionCookie(sessionCookie);
                              _usernameController.clear();
                              _passwordController.clear();
                            }
                                                       
                          });
                          } on TimeoutException{
                            if (!mounted) return;
                            setState(() {
                              returnMessage = "cannot connect";
                            });
                          }
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                          )
                        ),
                        child: const Text('Submit'),
                      ),
                    const SizedBox(height: 30.0,),
                    FilledButton(
                      child: Text('Click to print cookie'),
                      onPressed: () => print(Provider.of<SessionProvider>(context, listen: false).sessionCookie),
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