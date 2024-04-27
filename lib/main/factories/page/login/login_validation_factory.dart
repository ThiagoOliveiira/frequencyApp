import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validation.dart';
import '../../../builders/builders.dart';
import '../../../composites/composites.dart';

Validation makeLoginValidation() => ValidationComposite(makeLoginValidations());

List<FieldValidation> makeLoginValidations() => [...ValidationBuilder.field('registration').required().build(), ...ValidationBuilder.field('password').required().build()];
