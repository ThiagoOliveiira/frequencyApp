import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/validation.dart';
import '../../../builders/builders.dart';
import '../../../composites/composites.dart';

Validation makeHomeValidation() => ValidationComposite(makeHomeValidations());

List<FieldValidation> makeHomeValidations() => [...ValidationBuilder.field('codeClass').required().min(8).build()];
