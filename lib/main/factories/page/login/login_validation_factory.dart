import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validation.dart';
import '../../../builders/builders.dart';
import '../../../composites/composites.dart';

Validation makeLoginValidation() => ValidationComposite(makeLoginValidations());

List<FieldValidation> makeLoginValidations() => [
      ...ValidationBuilder.field('matricula').required().build(),
      ...ValidationBuilder.field('senha').required().build(),
    ];
