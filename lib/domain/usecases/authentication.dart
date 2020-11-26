import 'package:clean_code/domain/entities/account_entity.dart';
import 'package:meta/meta.dart';

abstract class Atuhentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams {
  final String email;
  final String secret;

  AuthenticationParams({@required this.email, @required this.secret});

  Map toJseon() => {'email': email, 'password': secret};
}
