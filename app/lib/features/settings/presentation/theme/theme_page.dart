import 'dart:async';

import 'package:app/features/profile/presentation/widgets/profile_theme_picker.dart';
import 'package:app/features/settings/data/repositories/settings_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';

/// The three app colours; the choice is kept on the device, so it works before sign-in.
@RoutePage()
class const SettingsThemePage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.settingsHome;

    return BaseView(
      appBar: BaseAppBar(title: l10n.theme),
      body: BaseStackedContent(
        body: ProfileThemePicker(
          selected: AppThemeScope.of(context),
          onChanged: (variant) => unawaited(_select(context, variant)),
        ),
      ),
    );
  }

  Future<void> _select(BuildContext context, AppThemeVariant variant) async {
    AppThemeScope.set(context, variant);
    final repository = AppInjector.instance.get<SettingsRepository>();
    await repository.save(repository.get().copyWith(themeVariant: variant.name));
  }
}
