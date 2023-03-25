// ignore_for_file: use_build_context_synchronously
// TODO: check if context is mounted

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:need2give/constants/error_handling.dart';
import 'package:need2give/constants/global.dart';
import 'package:need2give/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:need2give/models/user.dart';
import 'package:need2give/provider/user_provider.dart';
import 'package:need2give/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void onSuccess(BuildContext context, http.Response res) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Provider.of<UserProvider>(context, listen: false)
        .setUser(jsonEncode(jsonDecode(res.body)['account']));
    await prefs.setString('token', jsonDecode(res.body)['token']);
    Navigator.pushNamedAndRemoveUntil(
      context,
      Home.routeName,
      (route) => false,
    );
  }

  void signUp({
    required BuildContext context,
    required String email,
    required String username,
    required String password,
    String? phone,
  }) async {
    try {
      UserDTO user = UserDTO(
        username: username,
        email: email,
        password: password,
        phoneNumber: phone,
      );

      http.Response res = await http.post(
        Uri.parse('${Global.url}/auth/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          onSuccess(context, res);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${Global.url}/auth/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          onSuccess(context, res);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
