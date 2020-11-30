import 'package:clean_code/validation/protocols/field_validation.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String value) {
    return null;
  }
}

void main() {
  test('should return null if email is empty', () {
    final sut = EmailValidation('any_fiedl');

    final error = sut.validate('');

    expect(error, null);
  });

  test('should return null if email is null', () {
    final sut = EmailValidation(null);

    final error = sut.validate(null);

    expect(error, null);
  });
}
