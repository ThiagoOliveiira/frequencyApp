enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  cpfOrCnpjInUse,
  cpfOrCnpjNotFound,
  invalidToken,
  notFound,
  notConnected,
  emailInUse,
  phoneInUse,
  emailAndPhoneInUse,
  unprocessableEntity,
  canNotRegister,
  invalidData,
  unableToCancel,
  reachedLimit,
  requiredName,
  insertNameAndSurname,
  invalidPhone,
  requiredPhone,
  invalidEmail,
  requiredEmail,
  invalidInsuranceNumber,
  invalidIdCode,
  invalidPlate,
  requiredPlate,
  notInDateRange,
  minimalAge,
  maxAge,
  futureDate,
  userNotFound,
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.requiredField:
        return 'Campo obrigatório';
      case UIError.invalidField:
        return 'Campo inválido';
      case UIError.invalidCredentials:
        return 'Credenciais inválidas.';
      case UIError.cpfOrCnpjInUse:
        return 'Já existe uma conta com o dado informado.';
      case UIError.userNotFound:
      case UIError.cpfOrCnpjNotFound:
        return 'Usuário não encontrado. Verifique a informação e tente novamente.';
      case UIError.emailAndPhoneInUse:
        return 'O e-mail e o celular informados já estão em uso. Gostaria de tentar outros?';
      case UIError.emailInUse:
        return 'O e-mail informado já está em uso. Gostaria de tentar outro?';
      case UIError.phoneInUse:
        return 'O celular informado já está em uso. Gostaria de tentar outro?';
      case UIError.notFound:
        return 'Recurso não encontrado. Verifique a informação e tente novamente.';
      case UIError.notConnected:
        return 'Parece que você está sem internet. Verifique sua conexão e tente novamente!';
      case UIError.unprocessableEntity:
        return 'Não conseguimos processar a informação. Tente novamente.';
      case UIError.canNotRegister:
        return 'Para o seguro de vida, você não pode ser seu próprio beneficiário. Por favor, escolha outras pessoas.';
      case UIError.unableToCancel:
        return 'Você tem pendências que impedem o cancelamento da proteção.';
      case UIError.invalidData:
        return 'Os dados informados são inválidos/incorretos. Por favor, tente novamente!';
      case UIError.reachedLimit:
        return 'Você já fez uma alteração no nome. Por favor, fale com nosso time de atendimento para te ajudar!';
      case UIError.requiredName:
        return 'O nome é obrigatório';
      case UIError.insertNameAndSurname:
        return 'Insira o nome e o sobrenome';
      case UIError.invalidPhone:
        return 'Por favor, confira se este telefone é válido';
      case UIError.requiredPhone:
        return 'O telefone é obrigatório';
      case UIError.invalidEmail:
        return 'Por favor, confira se este email é válido';
      case UIError.requiredEmail:
        return 'O email é obrigatório';
      case UIError.invalidInsuranceNumber:
        return 'A apólice deve conter 13 números';
      case UIError.invalidIdCode:
        return 'O CI deve conter 14 caracteres alfanuméricos';
      case UIError.requiredPlate:
        return 'A placa deve ter no mínimo 7 caracteres';
      case UIError.invalidPlate:
        return 'Placa inválida';
      case UIError.notInDateRange:
        return 'Selecione uma data que não seja anterior a {date}';
      case UIError.futureDate:
        return 'Selecione uma data que não seja posterior a {date}';
      case UIError.minimalAge:
        return 'A idade mínima é de 18 anos';
      case UIError.maxAge:
        return 'A idade máxima é de 100 anos';
      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }

  String get errorCode {
    switch (this) {
      case UIError.unprocessableEntity:
        return 'L.1';
      case UIError.cpfOrCnpjNotFound:
        return 'L.6';
      default:
        return '';
    }
  }
}
