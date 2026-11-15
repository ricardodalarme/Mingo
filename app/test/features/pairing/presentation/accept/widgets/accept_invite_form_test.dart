import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/features/pairing/presentation/accept/widgets/accept_invite_form.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockPairingRepository() extends Mock implements PairingRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('the invite hint reads as an example, not a prefilled code', (tester) async {
    final cubit = AcceptInviteCubit(
      pairingRepository: _MockPairingRepository(),
      profileRepository: _MockProfileRepository(),
    );
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const AcceptInviteForm()));
    await tester.pumpAndSettle();

    expect(tester.widget<BaseTextField>(find.byType(BaseTextField)).hint, 'Ex.: ABCD2345');
  });
}
