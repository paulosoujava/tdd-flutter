import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:clean_code/infra/http/http.dart';
import 'package:clean_code/data/http/http.dart';

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

  group('shared', () {
    test('should throw server error if invalid method is provided', () async {
      final future = sut.request(url: url, method: 'invalid_metho');
      expect(future, throwsA(HttpError.serverError));
    });
  });
  group('post', () {
    PostExpectation mockRequest() => when(
        client.post(any, headers: anyNamed('headers'), body: anyNamed('body')));

    void mockResponse(int statusCode,
        {String body: '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    void mockError() {
      mockRequest().thenThrow(Exception());
    }

    setUp(() {
      mockResponse(200);
    });

    test('should call post with correct values', () async {
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
      await sut.request(url: url, method: 'post');

      verify(client.post(any, headers: anyNamed('headers')));
    });

    test('should return data if post return 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('should return null if post return 200 with no data', () async {
      mockResponse(200, body: '');
      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });

    test('should return null if post return 204', () async {
      mockResponse(204, body: '');
      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });

    test('should return null if post return 204 with data', () async {
      mockResponse(204);
      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
    test('should return BadRequestError if post returns 400', () async {
      mockResponse(400);
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('should return BadRequestError if post returns 400 with empty body',
        () async {
      mockResponse(400, body: '');
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });
    test('should return Server if post returns 500', () async {
      mockResponse(500);
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });

    test('should return UnauthorizedError if post returns 401', () async {
      mockResponse(401);
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('should return forbbiden if post returns 403', () async {
      mockResponse(403);
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.forbidden));
    });

    test('should return notFound if post returns 404', () async {
      mockResponse(404);
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.notFound));
    });

    test('should return serverError if post throws', () async {
      mockError();
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });
  });
}
