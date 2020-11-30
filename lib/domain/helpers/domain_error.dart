enum DomainError { unexpected, invalidCredentials }

extension DomainErrorExtensin on DomainError {
  String get description {
    switch (this) {
      case DomainError.invalidCredentials:
        return 'Credentiais inválidas';
      default:
        return 'Culpa do estagiário, tente mais tarde...';
    }
  }
}
