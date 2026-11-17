import 'dart:async';

import 'package:app/features/annoyances/data/models/gentle_request.dart';
import 'package:app/features/annoyances/data/models/gentle_response.dart';
import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:app/features/annoyances/presentation/gentle_request_detail/cubit/gentle_request_detail_cubit.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAnnoyanceRepository() extends Mock implements AnnoyanceRepository;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

GentleRequest _request({GentleResponse? response, DateTime? seenAt, DateTime? thankedAt}) =>
    GentleRequest(
      id: 'r1',
      whenText: 'chego em casa',
      feelText: 'sozinha',
      wishText: 'dividir a tarde',
      senderId: 'sender',
      recipientId: 'recipient',
      createdAt: DateTime(2026),
      response: response,
      seenAt: seenAt,
      thankedAt: thankedAt,
    );

void main() {
  late AnnoyanceRepository repository;
  late AuthenticationRepository authentication;
  late StreamController<GentleRequest> live;

  setUp(() {
    repository = _MockAnnoyanceRepository();
    authentication = _MockAuthenticationRepository();
    live = StreamController<GentleRequest>.broadcast();
    addTearDown(live.close);
    when(() => repository.watchGentleRequest(any())).thenAnswer((_) => live.stream);
    when(() => repository.markSeen(any())).thenAnswer((_) async {});
    when(
      () => repository.respond(
        id: any(named: 'id'),
        response: any(named: 'response'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => repository.thank(
        requestId: any(named: 'requestId'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async {});
  });

  setUpAll(() => registerFallbackValue(GentleResponse.willDo));

  GentleRequestDetailCubit build(String userId, GentleRequest? request) {
    when(() => authentication.currentUserId).thenReturn(userId);
    when(() => repository.getGentleRequest('r1')).thenAnswer((_) async => request);

    return GentleRequestDetailCubit(
      annoyanceRepository: repository,
      authenticationRepository: authentication,
    );
  }

  test('the recipient opening an unseen request marks it seen', () async {
    final cubit = build('recipient', _request());
    addTearDown(cubit.close);

    await cubit.load('r1');

    expect(cubit.state.isSender, isFalse);
    verify(() => repository.markSeen('r1')).called(1);
  });

  test('the sender opening it marks nothing', () async {
    final cubit = build('sender', _request());
    addTearDown(cubit.close);

    await cubit.load('r1');

    expect(cubit.state.isSender, isTrue);
    verifyNever(() => repository.markSeen(any()));
  });

  test('the recipient answers and the request is read again', () async {
    final cubit = build('recipient', _request(seenAt: DateTime(2026)));
    addTearDown(cubit.close);
    await cubit.load('r1');

    await cubit.respond(GentleResponse.willDo);

    verify(() => repository.respond(id: 'r1', response: GentleResponse.willDo)).called(1);
    verify(() => repository.getGentleRequest('r1')).called(2);
  });

  test('only a kept promise that was not thanked yet can be thanked', () {
    expect(_request(response: GentleResponse.willDo).canBeThanked, isTrue);
    expect(_request(response: GentleResponse.later).canBeThanked, isFalse);
    expect(
      _request(response: GentleResponse.willDo, thankedAt: DateTime(2026)).canBeThanked,
      isFalse,
    );
  });

  test('the sender thanks with the text that becomes a slip', () async {
    final cubit = build('sender', _request(response: GentleResponse.willDo));
    addTearDown(cubit.close);
    await cubit.load('r1');

    await cubit.thank('Ele cuidou disso');

    verify(() => repository.thank(requestId: 'r1', body: 'Ele cuidou disso')).called(1);
  });

  test('the answer of the recipient shows up on the sender page while it is open', () async {
    final cubit = build('sender', _request());
    addTearDown(cubit.close);
    await cubit.load('r1');

    live.add(_request(response: GentleResponse.willDo, seenAt: DateTime(2026, 1, 2)));
    await pumpEventQueue();

    final value = (cubit.state.request as Success<GentleRequest?>).value;
    expect(value?.response, GentleResponse.willDo);
  });

  test('stops following the request when it closes', () async {
    final cubit = build('sender', _request());
    await cubit.load('r1');
    expect(live.hasListener, isTrue);

    await cubit.close();

    expect(live.hasListener, isFalse);
  });
}
