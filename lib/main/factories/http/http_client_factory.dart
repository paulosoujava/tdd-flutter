import 'package:http/http.dart';

import '../../../infra/http/http.dart';

HttpAdadpter makeHttpAdapter() {
  final client = Client();
  return HttpAdadpter(client);
}
