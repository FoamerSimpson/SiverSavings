import 'package:flutter/material.dart';

class SessionProvider with ChangeNotifier {
  String? _sessionCookie;

  String? get sessionCookie => _sessionCookie;

  void setSessionCookie(String? cookie) {
    _sessionCookie = cookie;
    notifyListeners();
  }
}