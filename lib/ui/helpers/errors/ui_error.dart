enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  notFound,
  classNotFound,
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.classNotFound:
        return 'Aula não encontrada!';
      case UIError.requiredField:
        return 'Campo obrigatório';
      case UIError.invalidField:
        return 'Campo inválido';
      case UIError.invalidCredentials:
        return 'Credenciais inválidas.';
      case UIError.notFound:
        return 'Recurso não encontrado. Verifique a informação e tente novamente.';

      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
