import 'package:clean_code/main/factories/factory.dart';
import 'package:flutter/material.dart';

import '../../factory.dart';
import '../../../../ui/pages/pages.dart';

Widget makeLoginPage() {
  return LoginPage(makeLoginPresenter());
}
