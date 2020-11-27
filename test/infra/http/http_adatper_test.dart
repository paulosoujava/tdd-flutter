import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class HttpAdadpter {
  final Client client;
  HttpAdadpter(this.client);
  Future<void> request({@required String url, @required String method}) async {
    await client.post(url);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  group('post', () {
    test('should call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdadpter(client);
      final url = faker.internet.httpUrl();

      await sut.request(url: url, method: 'post');

      verify(client.post(url));
    });
  });
}
