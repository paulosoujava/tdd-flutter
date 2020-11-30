import 'package:test/test.dart';

import 'package:clean_code/validation/validators/required_field_validation.dart';

void main() {
  RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('should return null if value is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('should return error if value is not empty', () {
    expect(sut.validate(''), 'Campo obrigatório');
  });

  test('should return error if value is null', () {
    expect(sut.validate(null), 'Campo obrigatório');
  });
}
