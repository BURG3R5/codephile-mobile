import 'dart:convert';
import 'package:codephile/models/user.dart';
import 'package:http/http.dart' as http;

String url = "https://codephile-test.herokuapp.com/v1";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<User> getUser(String uId) async {
  //contestList(String token)
  String endpoint = "/user/fetch/$uId/";
  String uri = url + endpoint;
//  var tokenAuth = {"Authorization": "Token " + token};
  try {
    //var response = await client.get(
    //  uri,
    //  headers: tokenAuth,
    //);

    http.Response response = await client.get(uri);
    final jsonResponse = jsonDecode(response.body);
    User user = new User.fromJson(jsonResponse);
    //print(response.body);
    return user;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
