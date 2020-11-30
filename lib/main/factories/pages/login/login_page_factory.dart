import 'package:clean_code/data/usecases/remote_authentication.dart';
import 'package:clean_code/infra/http/http_adapter.dart';
import 'package:clean_code/presentation/presenters/stream_login_presenter.dart';
import 'package:clean_code/ui/pages/pages.dart';
import 'package:clean_code/validation/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

Widget makeLoginPage() {
  final url = 'http://fordevs.heroku.com/api/login';
  final client = Client();
  final httpAdapter = HttpAdadpter(client);
  final remoteAuthentication = RemoteAuthentication(httpClient: httpAdapter, url: url);
  final validatinComposite = ValidationComposite([RequiredFieldValidation('email'), EmailValidation('email'), RequiredFieldValidation('password')]);
  final streamLoginPresenter = StreamLoginPresenter(authentication: remoteAuthentication, validation: validatinComposite);

  return LoginPage(streamLoginPresenter);
}
