import 'package:material_ui/material_ui.dart';

/// Supplies English material localizations when the host provides none.
class const FieldLocalizations({required final Widget child, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Localizations.of<MaterialLocalizations>(context, MaterialLocalizations) != null) {
      return child;
    }

    return Localizations(
      locale: Localizations.maybeLocaleOf(context) ?? const Locale('en', 'US'),
      delegates: const [
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      child: child,
    );
  }
}
