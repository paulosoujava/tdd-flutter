import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../data/http/http.dart';

class HttpAdadpter implements HttpClient {
  final Client client;

  HttpAdadpter(this.client);

  Future<Map> request(
      {@required String url, @required String method, Map body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final payload = body != null ? jsonEncode(body) : null;
    final response = await client.post(url, headers: headers, body: payload);

    if(response.statusCode == 200 ){
      return response.body.isEmpty ? null : jsonDecode(response.body);
    }

    return null;
  }
}