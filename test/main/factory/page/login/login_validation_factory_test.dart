import 'package:clean_code/main/factories/pages/login/login_validation_factory.dart';
import 'package:clean_code/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {});
  test('should return the correct validations', () {
    final validations = makeLoginValidations();
    expect(validations, [RequiredFieldValidation('email'), EmailValidation('email'), RequiredFieldValidation('password')]);
  });
}
