import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/widgets/today_blocks.dart';
import 'package:flutter_test/flutter_test.dart';

TodayHome _home({
  bool isPaired = true,
  int slipsThisWeek = 3,
  bool hasPendingInvite = false,
  int unopenedCards = 0,
  int unseenSignals = 0,
  DateTime? togetherSince,
  Suggestion? question = const Suggestion(slug: 'mania', title: 'Qual é uma mania dele?'),
}) => TodayHome(
  isPaired: isPaired,
  unopenedCards: unopenedCards,
  slipsThisWeek: slipsThisWeek,
  slipsTotal: slipsThisWeek,
  hasPendingInvite: hasPendingInvite,
  hasPlus: false,
  unseenSignals: unseenSignals,
  question: question,
  togetherSince: togetherSince,
);

List<TodayBlock> _blocks({
  TodayHome? home,
  bool isFirstDay = false,
  bool isInConflict = false,
  bool isSoloOnly = false,
}) => todayBlocksFor(
  home: home ?? _home(),
  isFirstDay: isFirstDay,
  isInConflict: isInConflict,
  isSoloOnly: isSoloOnly,
);

void main() {
  group('todayBlocksFor', () {
    test('connected keeps the board order: mood, question, the note, the week, para hoje', () {
      expect(_blocks(home: _home(unopenedCards: 0, unseenSignals: 0)), [
        TodayBlock.mood,
        TodayBlock.questionCard,
        TodayBlock.nothingReceived,
        TodayBlock.weekCard,
        TodayBlock.forToday,
      ]);
    });

    test('something received drops the nothing-received note', () {
      expect(_blocks(home: _home(unopenedCards: 1)), isNot(contains(TodayBlock.nothingReceived)));
    });

    test('a partner signal counts as something received', () {
      expect(_blocks(home: _home(unseenSignals: 1)), isNot(contains(TodayBlock.nothingReceived)));
    });

    test('an empty week shows the week first and only the question after it', () {
      expect(_blocks(home: _home(slipsThisWeek: 0)), [
        TodayBlock.mood,
        TodayBlock.weekCard,
        TodayBlock.emptyWeekCard,
      ]);
    });

    test('on your own the invite card comes after the week and before para hoje', () {
      expect(_blocks(home: _home(isPaired: false)), [
        TodayBlock.mood,
        TodayBlock.weekCard,
        TodayBlock.inviteCard,
        TodayBlock.forToday,
      ]);
    });

    test('solo-only keeps the invite and the code out', () {
      expect(_blocks(home: _home(isPaired: false), isSoloOnly: true), [
        TodayBlock.mood,
        TodayBlock.weekCard,
        TodayBlock.forToday,
      ]);
    });

    test('the first day shows the welcome, the week and para hoje', () {
      expect(_blocks(home: _home(isPaired: false), isFirstDay: true), [
        TodayBlock.firstDayCard,
        TodayBlock.weekCard,
        TodayBlock.forToday,
      ]);
    });

    test('a pending invite leaves only the private prompt', () {
      expect(_blocks(home: _home(isPaired: false, hasPendingInvite: true)), [
        TodayBlock.privateCard,
      ]);
    });

    test('a pending invite outranks the first day', () {
      expect(_blocks(home: _home(isPaired: false, hasPendingInvite: true), isFirstDay: true), [
        TodayBlock.privateCard,
      ]);
    });

    test('a fight answer keeps the screen to repair and conversation', () {
      expect(_blocks(home: _home(), isInConflict: true), [TodayBlock.conflict]);
    });

    test('the share entry only appears when there is a date to count from', () {
      expect(
        _blocks(home: _home(togetherSince: DateTime(2024, 3, 10))),
        contains(TodayBlock.shareEntry),
      );
      expect(_blocks(home: _home()), isNot(contains(TodayBlock.shareEntry)));
    });

    test('without a question the day still shows the week and para hoje', () {
      expect(_blocks(home: _home(question: null)), [
        TodayBlock.mood,
        TodayBlock.weekCard,
        TodayBlock.forToday,
      ]);
    });
  });

  group('todayBandFor', () {
    test('a pending invite is the band', () {
      expect(
        todayBandFor(home: _home(isPaired: false, hasPendingInvite: true), isOffline: true),
        TodayBandKind.pendingInvite,
      );
    });

    test('no connection outranks reminders off', () {
      expect(todayBandFor(home: _home(), isOffline: true), TodayBandKind.offline);
    });

    test('with everything else fine, the reminders notice decides', () {
      expect(todayBandFor(home: _home(), isOffline: false), TodayBandKind.notificationsOff);
    });
  });
}
