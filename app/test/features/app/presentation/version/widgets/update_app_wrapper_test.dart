import 'dart:async';

import 'package:app/features/app/presentation/version/cubit/version_gate_cubit.dart';
import 'package:app/features/app/presentation/version/update_required_page.dart';
import 'package:app/features/app/presentation/version/widgets/update_app_wrapper.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockVersionGateCubit() extends MockCubit<VersionGateState> implements VersionGateCubit;

void main() {
  late VersionGateCubit versionGateCubit;
  late StreamController<VersionGateState> versionStates;

  setUp(() {
    versionGateCubit = _MockVersionGateCubit();
    versionStates = StreamController<VersionGateState>.broadcast();
    whenListen(versionGateCubit, versionStates.stream, initialState: const VersionGateState());
    when(() => versionGateCubit.check()).thenAnswer((_) async {});
    AppInjector.instance.registerFactory<VersionGateCubit>(() => versionGateCubit);
  });

  tearDown(() async {
    AppInjector.instance.unregister<VersionGateCubit>();
    await versionStates.close();
    await versionGateCubit.close();
  });

  Future<void> pumpWrapper(WidgetTester tester) =>
      tester.pumpApp(const UpdateAppWrapper(child: Text('content')));

  testWidgets('shows the update page when the version is below the minimum', (tester) async {
    await pumpWrapper(tester);

    versionStates.add(const VersionGateState(updateRequired: true));
    await tester.pump();

    expect(find.byType(UpdateRequiredPage), findsOneWidget);
    expect(find.text('content'), findsNothing);
  });

  testWidgets('shows the child when the version is allowed', (tester) async {
    await pumpWrapper(tester);
    await tester.pump();

    expect(find.text('content'), findsOneWidget);
    expect(find.byType(UpdateRequiredPage), findsNothing);
  });

  testWidgets('checks the version once', (tester) async {
    await pumpWrapper(tester);
    await tester.pump();

    verify(() => versionGateCubit.check()).called(1);
  });
}
