import '../../../../ui/pages/pages.dart';
import '../../factory.dart';
import '../../../../presentation/presenters/presenters.dart';

LoginPresenter makeLoginPresenter() {
  return StreamLoginPresenter(authentication: makeRemoteAuthentication(), validation: makeLoginValidation());
}
