
import 'package:flutter/material.dart';

bool userAuth = true;
const enableLog = true; ///For debug mode [Enable=true , Disable=false]

///Log
// ignore: non_constant_identifier_names
LogDebug(String message){
  if(enableLog == true) {
    print('[yru_flutter_workshop>>] $message');
  }
}

///Api Service
const yru_service = '296be7f08342.ngrok.io';
const api_login = '/api/auth/login';
const api_signUp = '/api/auth/register';
const api_me = '/api/auth/me';
const api_user = '/api/users';
const api_posts = '/api/posts';
String accessTokenSave = '';


const kPrimaryColor = Colors.blueAccent;//Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);