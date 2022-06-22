// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookingsystem/models/http_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication with ChangeNotifier {
  static const _apiKey = 'AIzaSyAzwRER4Me3NaN7AkrznAnnZUXMWzd98j8';

  String? _token;
  String? _userId;
  DateTime? _expiryDate;
  Authentication();
  // @override
  // Authentication._privateConstructor();
  // final Authentication authInstance = new Authentication._privateConstructor();
  String? get token {
    if (_expiryDate != null && _token != null) {
      return _token;
    } else {
      return null;
    }
  }

  String? get userId {
    if (_userId != null)
      return _userId;
    else {
      return null;
    }
  }

  bool get isAuth {

    if (token == null) {
      return false;
    } else {

      return true;
    }
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$_apiKey';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      print(responseData['idToken']);
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      isAuth;
      print(isAuth);
      notifyListeners();

      /// to store user data on device
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate?.toIso8601String(),
      });
      print(userData);
      prefs.setString('userData', userData);
    } catch (error) {
      throw (error);
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final _extractedData =
        json.decode(prefs.getString('userData') ?? '') as Map<String, dynamic>;
    // final expiryDate = DateTime.parse(extractedData['expiryDate']);  //  i don't want to sign out what ever happened
    // if(expiryDate.isBefore(DateTime.now())) {
    //   return false;
    // }
    print('try auto login');
    _token = _extractedData['idToken'];
    _userId = _extractedData['localId'];
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = DateTime.now();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }
}
/*
 var errorMessage = 'Authentication failed!';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'The email address is already in use by another account';
      } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        errorMessage = 'Too many attempts now, Please try again later ';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This email is invalid, Please try with valid email';
      } else if (error.toString().contains('WEAK_PASSWORWD')) {
        errorMessage = 'This password is weak, please use strong password';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password please enter correct password';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage =
            'This E-mail is not registered, please signup and try again!';
      }
      _showErrorDialog(errorMessage)  ;
  */
