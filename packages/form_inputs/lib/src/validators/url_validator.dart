import 'package:form_inputs/src/validators/validator.dart';

enum UrlValidationError() {
  invalid,
}

/// Accepts absolute `http` and `https` links with a host name.
class UrlValidator() implements Validator<String> {
  @override
  UrlValidationError? validate(String value) {
    final uri = Uri.tryParse(value);
    final isValid =
        uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.contains('.') &&
        !uri.host.endsWith('.');

    return isValid ? null : .invalid;
  }
}
