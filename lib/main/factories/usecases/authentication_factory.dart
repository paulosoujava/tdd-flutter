import 'package:clean_code/data/usecases/remote_authentication.dart';
import 'package:clean_code/main/factories/http/http.dart';
import '../factory.dart';

RemoteAuthentication makeRemoteAuthentication() {
  return RemoteAuthentication(httpClient: makeHttpAdapter(), url: makeApiUrl('login'));
}
