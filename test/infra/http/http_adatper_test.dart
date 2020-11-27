import 'dart:convert';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:clean_code/data/http/http_client.dart';

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
    return response.body.isEmpty ? null : jsonDecode(response.body);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  ClientSpy client;
  HttpAdadpter sut;
  String url;
  setUp(() {
    client = ClientSpy();
    sut = HttpAdadpter(client);
    url = faker.internet.httpUrl();
  });
  group('post', () {
    test('should call post with correct values', () async {
      when(client.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));
      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(url,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });

    test('should call post without body correct values', () async {
      when(client.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));
      await sut.request(url: url, method: 'post');

      verify(client.post(any, headers: anyNamed('headers')));
    });

    test('should return data if post return 200', () async {
      when(client.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('should return null if post return 200 with no data', () async {
      when(client.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('', 200));
      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
  });
}
