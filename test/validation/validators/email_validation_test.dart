import 'package:test/test.dart';

import 'package:clean_code/validation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });
  test('should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('should return null if email is valid', () {
    expect(sut.validate('paulosoujava@gmail.com'), null);
  });

  test('should return error if email is valid', () {
    expect(sut.validate('paulosoujava'), 'Campo inválido');
  });
}
