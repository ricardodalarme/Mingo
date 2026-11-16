import 'package:app/infrastructure/config/env_variables.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:link_launcher_service/link_launcher_service.dart';

/// The terms and privacy line under the sign-in actions.
///
/// Links appear only when the build configures their addresses.
class const LegalFooter({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.authentication;
    final hasLinks = EnvVariables.termsUrl.isNotEmpty && EnvVariables.privacyUrl.isNotEmpty;

    if (!hasLinks) {
      return Text(
        l10n.legalPlain,
        textAlign: TextAlign.center,
        style: context.text.caption.copyWith(color: context.colors.textSecondary),
      );
    }

    return BaseLegalNote(
      text: l10n.legal(terms: '{}', privacy: '{}'),
      links: [
        BaseLegalLink(text: l10n.legalTerms, onTap: () => _open(EnvVariables.termsUrl)),
        BaseLegalLink(text: l10n.legalPrivacy, onTap: () => _open(EnvVariables.privacyUrl)),
      ],
    );
  }

  Future<void> _open(String url) =>
      AppInjector.instance.get<LinkLauncherService>().openExternal(Uri.parse(url));
}
