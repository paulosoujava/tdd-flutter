import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:clean_code/validation/protocols/protocols.dart';
import 'package:clean_code/validation/validators/validators.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;
  ValidationComposite sut;

  void mockReturnValidation(FieldValidationSpy fieldValidator, String error) {
    when(fieldValidator.validate(any)).thenReturn(error);
  }

  void mockValidation1(String error) {
    mockReturnValidation(validation1, error);
  }

  void mockValidation2(String error) {
    mockReturnValidation(validation2, error);
  }

  void mockValidation3(String error) {
    mockReturnValidation(validation3, error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('any_field');
    mockValidation1(null);

    validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);

    validation3 = FieldValidationSpy();
    when(validation3.field).thenReturn('any_field');
    mockValidation3(null);
    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('should return null if all validations returns null or empty', () {
    mockValidation2('');
    final error = sut.validate(field: 'any_field', value: 'any_value');
    expect(error, null);
  });

  test('should return teh first error', () {
    mockValidation1('error_1');
    mockValidation2('error_2');
    mockValidation3('error_3');

    final error = sut.validate(field: 'any_field', value: 'any_value');
    expect(error, 'error_1');
  });
}
