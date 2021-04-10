import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yru_flutter_workshop_101/configApp.dart';
import 'package:yru_flutter_workshop_101/model/CatDao.dart';
import 'package:yru_flutter_workshop_101/model/authLogin.dart';

import '../saveData.dart';

class ApiService {

  static login(String email, String password) async {
    var url = Uri.https(yru_service, api_login, {'q': '{http}'});
    String _json = '{"email": "$email", "password": "$password"}';
    var response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      // "Authorization": "$userTokenType $userAccessToken",
    }, body: _json);

    LogDebug('Request url: $url');
    LogDebug('Request body: $_json');
    // LogDebug('response statusCode: ${response.statusCode}');

    if (response.statusCode == 200) {
      // LogDebug('response: ${response.body.toString()}');
      Map map = json.decode(response.body.toString());
      AuthLogin dao = AuthLogin.fromJson(map);
      print('tokenType = ${dao.tokenType}');
      print('accessToken = ${dao.accessToken}');
      accessTokenSave = dao.accessToken.toString();
      SaveData.saveAccessToken(accessTokenSave);
      print('expiresIn = ${dao.expiresIn.toString()}');
      return response.body.toString();
    } else if (response.statusCode == 201) {
      LogDebug('response: ${response.body.toString()}');
      return response.body.toString();
    } else {
      LogDebug(
          'Request failed with status: ${response.statusCode} \n ${response.body
              .toString()}');
      return response.statusCode.toString();
    }
  }

  static allUser(String  userAccessToken) async {
    LogDebug('Request allUser >>');
    var url = Uri.https(yru_service, api_user, {'q': '{http}'});
    LogDebug('Request url allUser: $url');
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $userAccessToken",
    });
    LogDebug('Request url allUser: $url');
    LogDebug('response statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      // LogDebug('response: ${response.body.toString()}');
      return response.body.toString();
    } else {
      LogDebug(
          'Request failed with status: ${response.statusCode} \n ${response.body
              .toString()}');
      return response.statusCode.toString();
    }
  }

  static me(String  userAccessToken) async {
    LogDebug('Request me >>');
    var url = Uri.https(yru_service, api_me, {'q': '{http}'});
    LogDebug('Request url me: $url');
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $userAccessToken",
    });
    LogDebug('Request url me: $url');
    LogDebug('response statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      // LogDebug('response: ${response.body.toString()}');
      return response.body.toString();
    } else {
      LogDebug(
          'Request failed with status: ${response.statusCode} \n ${response.body
              .toString()}');
      return response.statusCode.toString();
    }
  }

  static Future<CatDao> randomCat() async {
    var url = Uri.https('some-random-api.ml', '/img/cat', {'q': '{http}'});
    var response = await http.get(url, headers:  {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }
    );

    print('Request url: $url');
    if (response.statusCode == 200) {
      Map map = json.decode(response.body);
      CatDao dao = CatDao.fromJson(map);
      // print("URL link = " + dao?.link);
      return dao;
    }
  }

}