import 'package:clean_code/validation/protocols/field_validation.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String value) {
    final regex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    final isValid = value?.isNotEmpty != true || regex.hasMatch(value);
    return isValid ? null : 'Campo inválido';
  }
}

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