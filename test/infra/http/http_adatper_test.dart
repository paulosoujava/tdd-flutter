import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class HttpAdadpter {
  final Client client;
  HttpAdadpter(this.client);
  Future<void> request({@required String url, @required String method}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    await client.post(url, headers: headers);
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
      await sut.request(url: url, method: 'post');

      verify(client.post(url, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      }));
    });
  });
}
