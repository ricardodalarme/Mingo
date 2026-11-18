// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AcceptInvitePage]
class AcceptInviteRoute extends PageRouteInfo<AcceptInviteRouteArgs> {
  AcceptInviteRoute({String? code, Key? key, List<PageRouteInfo>? children})
    : super(
        AcceptInviteRoute.name,
        args: AcceptInviteRouteArgs(code: code, key: key),
        rawQueryParams: {'code': code},
        initialChildren: children,
      );

  static const String name = 'AcceptInviteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<AcceptInviteRouteArgs>(
        orElse: () =>
            AcceptInviteRouteArgs(code: queryParams.optString('code')),
      );
      return WrappedRoute(
        child: AcceptInvitePage(code: args.code, key: args.key),
      );
    },
  );
}

class AcceptInviteRouteArgs {
  const AcceptInviteRouteArgs({this.code, this.key});

  final String? code;

  final Key? key;

  @override
  String toString() {
    return 'AcceptInviteRouteArgs{code: $code, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AcceptInviteRouteArgs) return false;
    return code == other.code && key == other.key;
  }

  @override
  int get hashCode => code.hashCode ^ key.hashCode;
}

/// generated route for
/// [AgreementsPage]
class AgreementsRoute extends PageRouteInfo<void> {
  const AgreementsRoute({List<PageRouteInfo>? children})
    : super(AgreementsRoute.name, initialChildren: children);

  static const String name = 'AgreementsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AgreementsPage());
    },
  );
}

/// generated route for
/// [AnnoyanceCheckPage]
class AnnoyanceCheckRoute extends PageRouteInfo<AnnoyanceCheckRouteArgs> {
  AnnoyanceCheckRoute({
    required String id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         AnnoyanceCheckRoute.name,
         args: AnnoyanceCheckRouteArgs(id: id, key: key),
         initialChildren: children,
       );

  static const String name = 'AnnoyanceCheckRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnnoyanceCheckRouteArgs>();
      return WrappedRoute(
        child: AnnoyanceCheckPage(id: args.id, key: args.key),
      );
    },
  );
}

class AnnoyanceCheckRouteArgs {
  const AnnoyanceCheckRouteArgs({required this.id, this.key});

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'AnnoyanceCheckRouteArgs{id: $id, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AnnoyanceCheckRouteArgs) return false;
    return id == other.id && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode;
}

/// generated route for
/// [BadDayPage]
class BadDayRoute extends PageRouteInfo<void> {
  const BadDayRoute({List<PageRouteInfo>? children})
    : super(BadDayRoute.name, initialChildren: children);

  static const String name = 'BadDayRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const BadDayPage());
    },
  );
}

/// generated route for
/// [BreakupPage]
class BreakupRoute extends PageRouteInfo<void> {
  const BreakupRoute({List<PageRouteInfo>? children})
    : super(BreakupRoute.name, initialChildren: children);

  static const String name = 'BreakupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const BreakupPage());
    },
  );
}

/// generated route for
/// [CalmPage]
class CalmRoute extends PageRouteInfo<void> {
  const CalmRoute({List<PageRouteInfo>? children})
    : super(CalmRoute.name, initialChildren: children);

  static const String name = 'CalmRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CalmPage();
    },
  );
}

/// generated route for
/// [CapsulesPage]
class CapsulesRoute extends PageRouteInfo<void> {
  const CapsulesRoute({List<PageRouteInfo>? children})
    : super(CapsulesRoute.name, initialChildren: children);

  static const String name = 'CapsulesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CapsulesPage());
    },
  );
}

/// generated route for
/// [CardDetailPage]
class CardDetailRoute extends PageRouteInfo<CardDetailRouteArgs> {
  CardDetailRoute({
    required String cardId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         CardDetailRoute.name,
         args: CardDetailRouteArgs(cardId: cardId, key: key),
         rawPathParams: {'id': cardId},
         initialChildren: children,
       );

  static const String name = 'CardDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CardDetailRouteArgs>(
        orElse: () => CardDetailRouteArgs(cardId: pathParams.getString('id')),
      );
      return WrappedRoute(
        child: CardDetailPage(cardId: args.cardId, key: args.key),
      );
    },
  );
}

class CardDetailRouteArgs {
  const CardDetailRouteArgs({required this.cardId, this.key});

  final String cardId;

  final Key? key;

  @override
  String toString() {
    return 'CardDetailRouteArgs{cardId: $cardId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CardDetailRouteArgs) return false;
    return cardId == other.cardId && key == other.key;
  }

  @override
  int get hashCode => cardId.hashCode ^ key.hashCode;
}

/// generated route for
/// [CardSettingsPage]
class CardSettingsRoute extends PageRouteInfo<void> {
  const CardSettingsRoute({List<PageRouteInfo>? children})
    : super(CardSettingsRoute.name, initialChildren: children);

  static const String name = 'CardSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CardSettingsPage());
    },
  );
}

/// generated route for
/// [CardsListPage]
class CardsListRoute extends PageRouteInfo<void> {
  const CardsListRoute({List<PageRouteInfo>? children})
    : super(CardsListRoute.name, initialChildren: children);

  static const String name = 'CardsListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CardsListPage());
    },
  );
}

/// generated route for
/// [ChatPage]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    ChatMode mode = ChatMode.free,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ChatRoute.name,
         args: ChatRouteArgs(mode: mode, key: key),
         initialChildren: children,
       );

  static const String name = 'ChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>(
        orElse: () => const ChatRouteArgs(),
      );
      return WrappedRoute(
        child: ChatPage(mode: args.mode, key: args.key),
      );
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({this.mode = ChatMode.free, this.key});

  final ChatMode mode;

  final Key? key;

  @override
  String toString() {
    return 'ChatRouteArgs{mode: $mode, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatRouteArgs) return false;
    return mode == other.mode && key == other.key;
  }

  @override
  int get hashCode => mode.hashCode ^ key.hashCode;
}

/// generated route for
/// [ChatSettingsPage]
class ChatSettingsRoute extends PageRouteInfo<void> {
  const ChatSettingsRoute({List<PageRouteInfo>? children})
    : super(ChatSettingsRoute.name, initialChildren: children);

  static const String name = 'ChatSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ChatSettingsPage());
    },
  );
}

/// generated route for
/// [ChatTabPage]
class ChatTabRoute extends PageRouteInfo<void> {
  const ChatTabRoute({List<PageRouteInfo>? children})
    : super(ChatTabRoute.name, initialChildren: children);

  static const String name = 'ChatTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChatTabPage();
    },
  );
}

/// generated route for
/// [CheckinPage]
class CheckinRoute extends PageRouteInfo<void> {
  const CheckinRoute({List<PageRouteInfo>? children})
    : super(CheckinRoute.name, initialChildren: children);

  static const String name = 'CheckinRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CheckinPage());
    },
  );
}

/// generated route for
/// [ComposePage]
class ComposeRoute extends PageRouteInfo<void> {
  const ComposeRoute({List<PageRouteInfo>? children})
    : super(ComposeRoute.name, initialChildren: children);

  static const String name = 'ComposeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ComposePage());
    },
  );
}

/// generated route for
/// [ConsentsPage]
class ConsentsRoute extends PageRouteInfo<void> {
  const ConsentsRoute({List<PageRouteInfo>? children})
    : super(ConsentsRoute.name, initialChildren: children);

  static const String name = 'ConsentsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ConsentsPage());
    },
  );
}

/// generated route for
/// [CounterVariationsPage]
class CounterVariationsRoute extends PageRouteInfo<void> {
  const CounterVariationsRoute({List<PageRouteInfo>? children})
    : super(CounterVariationsRoute.name, initialChildren: children);

  static const String name = 'CounterVariationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CounterVariationsPage());
    },
  );
}

/// generated route for
/// [CouplePage]
class CoupleRoute extends PageRouteInfo<CoupleRouteArgs> {
  CoupleRoute({
    CoupleSection section = CoupleSection.together,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         CoupleRoute.name,
         args: CoupleRouteArgs(section: section, key: key),
         initialChildren: children,
       );

  static const String name = 'CoupleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CoupleRouteArgs>(
        orElse: () => const CoupleRouteArgs(),
      );
      return WrappedRoute(
        child: CouplePage(section: args.section, key: args.key),
      );
    },
  );
}

class CoupleRouteArgs {
  const CoupleRouteArgs({this.section = CoupleSection.together, this.key});

  final CoupleSection section;

  final Key? key;

  @override
  String toString() {
    return 'CoupleRouteArgs{section: $section, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CoupleRouteArgs) return false;
    return section == other.section && key == other.key;
  }

  @override
  int get hashCode => section.hashCode ^ key.hashCode;
}

/// generated route for
/// [CreateAccountPage]
class CreateAccountRoute extends PageRouteInfo<void> {
  const CreateAccountRoute({List<PageRouteInfo>? children})
    : super(CreateAccountRoute.name, initialChildren: children);

  static const String name = 'CreateAccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CreateAccountPage());
    },
  );
}

/// generated route for
/// [DateNightPage]
class DateNightRoute extends PageRouteInfo<void> {
  const DateNightRoute({List<PageRouteInfo>? children})
    : super(DateNightRoute.name, initialChildren: children);

  static const String name = 'DateNightRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const DateNightPage());
    },
  );
}

/// generated route for
/// [DatesPage]
class DatesRoute extends PageRouteInfo<void> {
  const DatesRoute({List<PageRouteInfo>? children})
    : super(DatesRoute.name, initialChildren: children);

  static const String name = 'DatesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const DatesPage());
    },
  );
}

/// generated route for
/// [DayPage]
class DayRoute extends PageRouteInfo<void> {
  const DayRoute({List<PageRouteInfo>? children})
    : super(DayRoute.name, initialChildren: children);

  static const String name = 'DayRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const DayPage());
    },
  );
}

/// generated route for
/// [DebugSignInPage]
class DebugSignInRoute extends PageRouteInfo<void> {
  const DebugSignInRoute({List<PageRouteInfo>? children})
    : super(DebugSignInRoute.name, initialChildren: children);

  static const String name = 'DebugSignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const DebugSignInPage());
    },
  );
}

/// generated route for
/// [DeleteAccountPage]
class DeleteAccountRoute extends PageRouteInfo<void> {
  const DeleteAccountRoute({List<PageRouteInfo>? children})
    : super(DeleteAccountRoute.name, initialChildren: children);

  static const String name = 'DeleteAccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const DeleteAccountPage());
    },
  );
}

/// generated route for
/// [DevicesPage]
class DevicesRoute extends PageRouteInfo<void> {
  const DevicesRoute({List<PageRouteInfo>? children})
    : super(DevicesRoute.name, initialChildren: children);

  static const String name = 'DevicesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const DevicesPage());
    },
  );
}

/// generated route for
/// [DiaryPage]
class DiaryRoute extends PageRouteInfo<void> {
  const DiaryRoute({List<PageRouteInfo>? children})
    : super(DiaryRoute.name, initialChildren: children);

  static const String name = 'DiaryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const DiaryPage());
    },
  );
}

/// generated route for
/// [DifferentDatesPage]
class DifferentDatesRoute extends PageRouteInfo<void> {
  const DifferentDatesRoute({List<PageRouteInfo>? children})
    : super(DifferentDatesRoute.name, initialChildren: children);

  static const String name = 'DifferentDatesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const DifferentDatesPage());
    },
  );
}

/// generated route for
/// [DistancePage]
class DistanceRoute extends PageRouteInfo<void> {
  const DistanceRoute({List<PageRouteInfo>? children})
    : super(DistanceRoute.name, initialChildren: children);

  static const String name = 'DistanceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const DistancePage());
    },
  );
}

/// generated route for
/// [ExistingAccountPage]
class ExistingAccountRoute extends PageRouteInfo<void> {
  const ExistingAccountRoute({List<PageRouteInfo>? children})
    : super(ExistingAccountRoute.name, initialChildren: children);

  static const String name = 'ExistingAccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ExistingAccountPage());
    },
  );
}

/// generated route for
/// [ExportDataPage]
class ExportDataRoute extends PageRouteInfo<void> {
  const ExportDataRoute({List<PageRouteInfo>? children})
    : super(ExportDataRoute.name, initialChildren: children);

  static const String name = 'ExportDataRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ExportDataPage());
    },
  );
}

/// generated route for
/// [FightStylePage]
class FightStyleRoute extends PageRouteInfo<void> {
  const FightStyleRoute({List<PageRouteInfo>? children})
    : super(FightStyleRoute.name, initialChildren: children);

  static const String name = 'FightStyleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const FightStylePage());
    },
  );
}

/// generated route for
/// [FirstSlipPage]
class FirstSlipRoute extends PageRouteInfo<void> {
  const FirstSlipRoute({List<PageRouteInfo>? children})
    : super(FirstSlipRoute.name, initialChildren: children);

  static const String name = 'FirstSlipRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const FirstSlipPage());
    },
  );
}

/// generated route for
/// [GamePage]
class GameRoute extends PageRouteInfo<GameRouteArgs> {
  GameRoute({String game = '', Key? key, List<PageRouteInfo>? children})
    : super(
        GameRoute.name,
        args: GameRouteArgs(game: game, key: key),
        rawPathParams: {'game': game},
        initialChildren: children,
      );

  static const String name = 'GameRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<GameRouteArgs>(
        orElse: () => GameRouteArgs(game: pathParams.getString('game', '')),
      );
      return WrappedRoute(
        child: GamePage(game: args.game, key: args.key),
      );
    },
  );
}

class GameRouteArgs {
  const GameRouteArgs({this.game = '', this.key});

  final String game;

  final Key? key;

  @override
  String toString() {
    return 'GameRouteArgs{game: $game, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GameRouteArgs) return false;
    return game == other.game && key == other.key;
  }

  @override
  int get hashCode => game.hashCode ^ key.hashCode;
}

/// generated route for
/// [GamesPage]
class GamesRoute extends PageRouteInfo<void> {
  const GamesRoute({List<PageRouteInfo>? children})
    : super(GamesRoute.name, initialChildren: children);

  static const String name = 'GamesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const GamesPage());
    },
  );
}

/// generated route for
/// [GentleRequestDetailPage]
class GentleRequestDetailRoute
    extends PageRouteInfo<GentleRequestDetailRouteArgs> {
  GentleRequestDetailRoute({
    required String id,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         GentleRequestDetailRoute.name,
         args: GentleRequestDetailRouteArgs(id: id, key: key),
         initialChildren: children,
       );

  static const String name = 'GentleRequestDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GentleRequestDetailRouteArgs>();
      return WrappedRoute(
        child: GentleRequestDetailPage(id: args.id, key: args.key),
      );
    },
  );
}

class GentleRequestDetailRouteArgs {
  const GentleRequestDetailRouteArgs({required this.id, this.key});

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'GentleRequestDetailRouteArgs{id: $id, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GentleRequestDetailRouteArgs) return false;
    return id == other.id && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode;
}

/// generated route for
/// [GentleRequestPage]
class GentleRequestRoute extends PageRouteInfo<GentleRequestRouteArgs> {
  GentleRequestRoute({
    String? annoyanceId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         GentleRequestRoute.name,
         args: GentleRequestRouteArgs(annoyanceId: annoyanceId, key: key),
         initialChildren: children,
       );

  static const String name = 'GentleRequestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GentleRequestRouteArgs>(
        orElse: () => const GentleRequestRouteArgs(),
      );
      return WrappedRoute(
        child: GentleRequestPage(annoyanceId: args.annoyanceId, key: args.key),
      );
    },
  );
}

class GentleRequestRouteArgs {
  const GentleRequestRouteArgs({this.annoyanceId, this.key});

  final String? annoyanceId;

  final Key? key;

  @override
  String toString() {
    return 'GentleRequestRouteArgs{annoyanceId: $annoyanceId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GentleRequestRouteArgs) return false;
    return annoyanceId == other.annoyanceId && key == other.key;
  }

  @override
  int get hashCode => annoyanceId.hashCode ^ key.hashCode;
}

/// generated route for
/// [GiftsPage]
class GiftsRoute extends PageRouteInfo<void> {
  const GiftsRoute({List<PageRouteInfo>? children})
    : super(GiftsRoute.name, initialChildren: children);

  static const String name = 'GiftsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const GiftsPage());
    },
  );
}

/// generated route for
/// [GriefSupportPage]
class GriefSupportRoute extends PageRouteInfo<void> {
  const GriefSupportRoute({List<PageRouteInfo>? children})
    : super(GriefSupportRoute.name, initialChildren: children);

  static const String name = 'GriefSupportRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GriefSupportPage();
    },
  );
}

/// generated route for
/// [GuidePage]
class GuideRoute extends PageRouteInfo<GuideRouteArgs> {
  GuideRoute({String slug = '', Key? key, List<PageRouteInfo>? children})
    : super(
        GuideRoute.name,
        args: GuideRouteArgs(slug: slug, key: key),
        rawPathParams: {'slug': slug},
        initialChildren: children,
      );

  static const String name = 'GuideRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<GuideRouteArgs>(
        orElse: () => GuideRouteArgs(slug: pathParams.getString('slug', '')),
      );
      return WrappedRoute(
        child: GuidePage(slug: args.slug, key: args.key),
      );
    },
  );
}

class GuideRouteArgs {
  const GuideRouteArgs({this.slug = '', this.key});

  final String slug;

  final Key? key;

  @override
  String toString() {
    return 'GuideRouteArgs{slug: $slug, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GuideRouteArgs) return false;
    return slug == other.slug && key == other.key;
  }

  @override
  int get hashCode => slug.hashCode ^ key.hashCode;
}

/// generated route for
/// [GuidedRepairPage]
class GuidedRepairRoute extends PageRouteInfo<void> {
  const GuidedRepairRoute({List<PageRouteInfo>? children})
    : super(GuidedRepairRoute.name, initialChildren: children);

  static const String name = 'GuidedRepairRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const GuidedRepairPage());
    },
  );
}

/// generated route for
/// [GuidesPage]
class GuidesRoute extends PageRouteInfo<void> {
  const GuidesRoute({List<PageRouteInfo>? children})
    : super(GuidesRoute.name, initialChildren: children);

  static const String name = 'GuidesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const GuidesPage());
    },
  );
}

/// generated route for
/// [HardConversationPage]
class HardConversationRoute extends PageRouteInfo<void> {
  const HardConversationRoute({List<PageRouteInfo>? children})
    : super(HardConversationRoute.name, initialChildren: children);

  static const String name = 'HardConversationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HardConversationPage());
    },
  );
}

/// generated route for
/// [HelpPage]
class HelpRoute extends PageRouteInfo<void> {
  const HelpRoute({List<PageRouteInfo>? children})
    : super(HelpRoute.name, initialChildren: children);

  static const String name = 'HelpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HelpPage());
    },
  );
}

/// generated route for
/// [HistoryAvatarPage]
class HistoryAvatarRoute extends PageRouteInfo<void> {
  const HistoryAvatarRoute({List<PageRouteInfo>? children})
    : super(HistoryAvatarRoute.name, initialChildren: children);

  static const String name = 'HistoryAvatarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HistoryAvatarPage());
    },
  );
}

/// generated route for
/// [HistoryNumbersPage]
class HistoryNumbersRoute extends PageRouteInfo<void> {
  const HistoryNumbersRoute({List<PageRouteInfo>? children})
    : super(HistoryNumbersRoute.name, initialChildren: children);

  static const String name = 'HistoryNumbersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HistoryNumbersPage());
    },
  );
}

/// generated route for
/// [HistoryPage]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HistoryPage());
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [HomeWidgetsGalleryPage]
class HomeWidgetsGalleryRoute extends PageRouteInfo<void> {
  const HomeWidgetsGalleryRoute({List<PageRouteInfo>? children})
    : super(HomeWidgetsGalleryRoute.name, initialChildren: children);

  static const String name = 'HomeWidgetsGalleryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HomeWidgetsGalleryPage());
    },
  );
}

/// generated route for
/// [IdeaDetailPage]
class IdeaDetailRoute extends PageRouteInfo<IdeaDetailRouteArgs> {
  IdeaDetailRoute({String? slug, Key? key, List<PageRouteInfo>? children})
    : super(
        IdeaDetailRoute.name,
        args: IdeaDetailRouteArgs(slug: slug, key: key),
        rawQueryParams: {'slug': slug},
        initialChildren: children,
      );

  static const String name = 'IdeaDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<IdeaDetailRouteArgs>(
        orElse: () => IdeaDetailRouteArgs(slug: queryParams.optString('slug')),
      );
      return WrappedRoute(
        child: IdeaDetailPage(slug: args.slug, key: args.key),
      );
    },
  );
}

class IdeaDetailRouteArgs {
  const IdeaDetailRouteArgs({this.slug, this.key});

  final String? slug;

  final Key? key;

  @override
  String toString() {
    return 'IdeaDetailRouteArgs{slug: $slug, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! IdeaDetailRouteArgs) return false;
    return slug == other.slug && key == other.key;
  }

  @override
  int get hashCode => slug.hashCode ^ key.hashCode;
}

/// generated route for
/// [InboxPage]
class InboxRoute extends PageRouteInfo<void> {
  const InboxRoute({List<PageRouteInfo>? children})
    : super(InboxRoute.name, initialChildren: children);

  static const String name = 'InboxRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const InboxPage());
    },
  );
}

/// generated route for
/// [IntroGoalsPage]
class IntroGoalsRoute extends PageRouteInfo<void> {
  const IntroGoalsRoute({List<PageRouteInfo>? children})
    : super(IntroGoalsRoute.name, initialChildren: children);

  static const String name = 'IntroGoalsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const IntroGoalsPage());
    },
  );
}

/// generated route for
/// [IntroPhasePage]
class IntroPhaseRoute extends PageRouteInfo<void> {
  const IntroPhaseRoute({List<PageRouteInfo>? children})
    : super(IntroPhaseRoute.name, initialChildren: children);

  static const String name = 'IntroPhaseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const IntroPhasePage());
    },
  );
}

/// generated route for
/// [IntroThemePage]
class IntroThemeRoute extends PageRouteInfo<void> {
  const IntroThemeRoute({List<PageRouteInfo>? children})
    : super(IntroThemeRoute.name, initialChildren: children);

  static const String name = 'IntroThemeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const IntroThemePage());
    },
  );
}

/// generated route for
/// [InvitePage]
class InviteRoute extends PageRouteInfo<void> {
  const InviteRoute({List<PageRouteInfo>? children})
    : super(InviteRoute.name, initialChildren: children);

  static const String name = 'InviteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const InvitePage());
    },
  );
}

/// generated route for
/// [LanguagePage]
class LanguageRoute extends PageRouteInfo<void> {
  const LanguageRoute({List<PageRouteInfo>? children})
    : super(LanguageRoute.name, initialChildren: children);

  static const String name = 'LanguageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const LanguagePage());
    },
  );
}

/// generated route for
/// [LearnedItemsPage]
class LearnedItemsRoute extends PageRouteInfo<void> {
  const LearnedItemsRoute({List<PageRouteInfo>? children})
    : super(LearnedItemsRoute.name, initialChildren: children);

  static const String name = 'LearnedItemsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const LearnedItemsPage());
    },
  );
}

/// generated route for
/// [LearningPage]
class LearningRoute extends PageRouteInfo<LearningRouteArgs> {
  LearningRoute({String? sessionId, Key? key, List<PageRouteInfo>? children})
    : super(
        LearningRoute.name,
        args: LearningRouteArgs(sessionId: sessionId, key: key),
        rawQueryParams: {'sessionId': sessionId},
        initialChildren: children,
      );

  static const String name = 'LearningRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<LearningRouteArgs>(
        orElse: () =>
            LearningRouteArgs(sessionId: queryParams.optString('sessionId')),
      );
      return WrappedRoute(
        child: LearningPage(sessionId: args.sessionId, key: args.key),
      );
    },
  );
}

class LearningRouteArgs {
  const LearningRouteArgs({this.sessionId, this.key});

  final String? sessionId;

  final Key? key;

  @override
  String toString() {
    return 'LearningRouteArgs{sessionId: $sessionId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LearningRouteArgs) return false;
    return sessionId == other.sessionId && key == other.key;
  }

  @override
  int get hashCode => sessionId.hashCode ^ key.hashCode;
}

/// generated route for
/// [LessonPage]
class LessonRoute extends PageRouteInfo<LessonRouteArgs> {
  LessonRoute({
    required String slug,
    required int day,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         LessonRoute.name,
         args: LessonRouteArgs(slug: slug, day: day, key: key),
         rawPathParams: {'slug': slug, 'day': day},
         initialChildren: children,
       );

  static const String name = 'LessonRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<LessonRouteArgs>(
        orElse: () => LessonRouteArgs(
          slug: pathParams.getString('slug'),
          day: pathParams.getInt('day'),
        ),
      );
      return WrappedRoute(
        child: LessonPage(slug: args.slug, day: args.day, key: args.key),
      );
    },
  );
}

class LessonRouteArgs {
  const LessonRouteArgs({required this.slug, required this.day, this.key});

  final String slug;

  final int day;

  final Key? key;

  @override
  String toString() {
    return 'LessonRouteArgs{slug: $slug, day: $day, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LessonRouteArgs) return false;
    return slug == other.slug && day == other.day && key == other.key;
  }

  @override
  int get hashCode => slug.hashCode ^ day.hashCode ^ key.hashCode;
}

/// generated route for
/// [ListDetailPage]
class ListDetailRoute extends PageRouteInfo<ListDetailRouteArgs> {
  ListDetailRoute({
    required String listId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ListDetailRoute.name,
         args: ListDetailRouteArgs(listId: listId, key: key),
         rawPathParams: {'id': listId},
         initialChildren: children,
       );

  static const String name = 'ListDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ListDetailRouteArgs>(
        orElse: () => ListDetailRouteArgs(listId: pathParams.getString('id')),
      );
      return WrappedRoute(
        child: ListDetailPage(listId: args.listId, key: args.key),
      );
    },
  );
}

class ListDetailRouteArgs {
  const ListDetailRouteArgs({required this.listId, this.key});

  final String listId;

  final Key? key;

  @override
  String toString() {
    return 'ListDetailRouteArgs{listId: $listId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ListDetailRouteArgs) return false;
    return listId == other.listId && key == other.key;
  }

  @override
  int get hashCode => listId.hashCode ^ key.hashCode;
}

/// generated route for
/// [ListsPage]
class ListsRoute extends PageRouteInfo<void> {
  const ListsRoute({List<PageRouteInfo>? children})
    : super(ListsRoute.name, initialChildren: children);

  static const String name = 'ListsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ListsPage());
    },
  );
}

/// generated route for
/// [LogisticsPage]
class LogisticsRoute extends PageRouteInfo<void> {
  const LogisticsRoute({List<PageRouteInfo>? children})
    : super(LogisticsRoute.name, initialChildren: children);

  static const String name = 'LogisticsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const LogisticsPage());
    },
  );
}

/// generated route for
/// [LoveStyleComparePage]
class LoveStyleCompareRoute extends PageRouteInfo<void> {
  const LoveStyleCompareRoute({List<PageRouteInfo>? children})
    : super(LoveStyleCompareRoute.name, initialChildren: children);

  static const String name = 'LoveStyleCompareRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const LoveStyleComparePage());
    },
  );
}

/// generated route for
/// [LoveStylePage]
class LoveStyleRoute extends PageRouteInfo<void> {
  const LoveStyleRoute({List<PageRouteInfo>? children})
    : super(LoveStyleRoute.name, initialChildren: children);

  static const String name = 'LoveStyleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const LoveStylePage());
    },
  );
}

/// generated route for
/// [ManagePlusPage]
class ManagePlusRoute extends PageRouteInfo<void> {
  const ManagePlusRoute({List<PageRouteInfo>? children})
    : super(ManagePlusRoute.name, initialChildren: children);

  static const String name = 'ManagePlusRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ManagePlusPage());
    },
  );
}

/// generated route for
/// [MemoriesPage]
class MemoriesRoute extends PageRouteInfo<MemoriesRouteArgs> {
  MemoriesRoute({
    bool isEmbedded = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         MemoriesRoute.name,
         args: MemoriesRouteArgs(isEmbedded: isEmbedded, key: key),
         initialChildren: children,
       );

  static const String name = 'MemoriesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MemoriesRouteArgs>(
        orElse: () => const MemoriesRouteArgs(),
      );
      return MemoriesPage(isEmbedded: args.isEmbedded, key: args.key);
    },
  );
}

class MemoriesRouteArgs {
  const MemoriesRouteArgs({this.isEmbedded = false, this.key});

  final bool isEmbedded;

  final Key? key;

  @override
  String toString() {
    return 'MemoriesRouteArgs{isEmbedded: $isEmbedded, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MemoriesRouteArgs) return false;
    return isEmbedded == other.isEmbedded && key == other.key;
  }

  @override
  int get hashCode => isEmbedded.hashCode ^ key.hashCode;
}

/// generated route for
/// [MemoriesTimelinePage]
class MemoriesTimelineRoute extends PageRouteInfo<void> {
  const MemoriesTimelineRoute({List<PageRouteInfo>? children})
    : super(MemoriesTimelineRoute.name, initialChildren: children);

  static const String name = 'MemoriesTimelineRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MemoriesTimelinePage());
    },
  );
}

/// generated route for
/// [MilestonePage]
class MilestoneRoute extends PageRouteInfo<MilestoneRouteArgs> {
  MilestoneRoute({
    HistoryMilestone? initialMilestone,
    String? initialTitle,
    MilestoneKind? initialKind,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         MilestoneRoute.name,
         args: MilestoneRouteArgs(
           initialMilestone: initialMilestone,
           initialTitle: initialTitle,
           initialKind: initialKind,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'MilestoneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MilestoneRouteArgs>(
        orElse: () => const MilestoneRouteArgs(),
      );
      return WrappedRoute(
        child: MilestonePage(
          initialMilestone: args.initialMilestone,
          initialTitle: args.initialTitle,
          initialKind: args.initialKind,
          key: args.key,
        ),
      );
    },
  );
}

class MilestoneRouteArgs {
  const MilestoneRouteArgs({
    this.initialMilestone,
    this.initialTitle,
    this.initialKind,
    this.key,
  });

  final HistoryMilestone? initialMilestone;

  final String? initialTitle;

  final MilestoneKind? initialKind;

  final Key? key;

  @override
  String toString() {
    return 'MilestoneRouteArgs{initialMilestone: $initialMilestone, initialTitle: $initialTitle, initialKind: $initialKind, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MilestoneRouteArgs) return false;
    return initialMilestone == other.initialMilestone &&
        initialTitle == other.initialTitle &&
        initialKind == other.initialKind &&
        key == other.key;
  }

  @override
  int get hashCode =>
      initialMilestone.hashCode ^
      initialTitle.hashCode ^
      initialKind.hashCode ^
      key.hashCode;
}

/// generated route for
/// [MoodCalendarPage]
class MoodCalendarRoute extends PageRouteInfo<void> {
  const MoodCalendarRoute({List<PageRouteInfo>? children})
    : super(MoodCalendarRoute.name, initialChildren: children);

  static const String name = 'MoodCalendarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MoodCalendarPage());
    },
  );
}

/// generated route for
/// [MoodPage]
class MoodRoute extends PageRouteInfo<MoodRouteArgs> {
  MoodRoute({String? initialMood, Key? key, List<PageRouteInfo>? children})
    : super(
        MoodRoute.name,
        args: MoodRouteArgs(initialMood: initialMood, key: key),
        initialChildren: children,
      );

  static const String name = 'MoodRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MoodRouteArgs>(
        orElse: () => const MoodRouteArgs(),
      );
      return WrappedRoute(
        child: MoodPage(initialMood: args.initialMood, key: args.key),
      );
    },
  );
}

class MoodRouteArgs {
  const MoodRouteArgs({this.initialMood, this.key});

  final String? initialMood;

  final Key? key;

  @override
  String toString() {
    return 'MoodRouteArgs{initialMood: $initialMood, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MoodRouteArgs) return false;
    return initialMood == other.initialMood && key == other.key;
  }

  @override
  int get hashCode => initialMood.hashCode ^ key.hashCode;
}

/// generated route for
/// [NeedPage]
class NeedRoute extends PageRouteInfo<void> {
  const NeedRoute({List<PageRouteInfo>? children})
    : super(NeedRoute.name, initialChildren: children);

  static const String name = 'NeedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const NeedPage());
    },
  );
}

/// generated route for
/// [NotFoundPage]
class NotFoundRoute extends PageRouteInfo<void> {
  const NotFoundRoute({List<PageRouteInfo>? children})
    : super(NotFoundRoute.name, initialChildren: children);

  static const String name = 'NotFoundRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotFoundPage();
    },
  );
}

/// generated route for
/// [NotificationPermissionPage]
class NotificationPermissionRoute extends PageRouteInfo<void> {
  const NotificationPermissionRoute({List<PageRouteInfo>? children})
    : super(NotificationPermissionRoute.name, initialChildren: children);

  static const String name = 'NotificationPermissionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const NotificationPermissionPage());
    },
  );
}

/// generated route for
/// [NotificationPreferencesPage]
class NotificationPreferencesRoute extends PageRouteInfo<void> {
  const NotificationPreferencesRoute({List<PageRouteInfo>? children})
    : super(NotificationPreferencesRoute.name, initialChildren: children);

  static const String name = 'NotificationPreferencesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const NotificationPreferencesPage());
    },
  );
}

/// generated route for
/// [OurViewPage]
class OurViewRoute extends PageRouteInfo<void> {
  const OurViewRoute({List<PageRouteInfo>? children})
    : super(OurViewRoute.name, initialChildren: children);

  static const String name = 'OurViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OurViewPage();
    },
  );
}

/// generated route for
/// [PartnerProfilePage]
class PartnerProfileRoute extends PageRouteInfo<void> {
  const PartnerProfileRoute({List<PageRouteInfo>? children})
    : super(PartnerProfileRoute.name, initialChildren: children);

  static const String name = 'PartnerProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const PartnerProfilePage());
    },
  );
}

/// generated route for
/// [PartnerStepPage]
class PartnerStepRoute extends PageRouteInfo<void> {
  const PartnerStepRoute({List<PageRouteInfo>? children})
    : super(PartnerStepRoute.name, initialChildren: children);

  static const String name = 'PartnerStepRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const PartnerStepPage());
    },
  );
}

/// generated route for
/// [PartnerViewPage]
class PartnerViewRoute extends PageRouteInfo<void> {
  const PartnerViewRoute({List<PageRouteInfo>? children})
    : super(PartnerViewRoute.name, initialChildren: children);

  static const String name = 'PartnerViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PartnerViewPage();
    },
  );
}

/// generated route for
/// [PlansPage]
class PlansRoute extends PageRouteInfo<void> {
  const PlansRoute({List<PageRouteInfo>? children})
    : super(PlansRoute.name, initialChildren: children);

  static const String name = 'PlansRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const PlansPage());
    },
  );
}

/// generated route for
/// [PrivacyHubPage]
class PrivacyHubRoute extends PageRouteInfo<void> {
  const PrivacyHubRoute({List<PageRouteInfo>? children})
    : super(PrivacyHubRoute.name, initialChildren: children);

  static const String name = 'PrivacyHubRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PrivacyHubPage();
    },
  );
}

/// generated route for
/// [ProfileSettingsPage]
class ProfileSettingsRoute extends PageRouteInfo<void> {
  const ProfileSettingsRoute({List<PageRouteInfo>? children})
    : super(ProfileSettingsRoute.name, initialChildren: children);

  static const String name = 'ProfileSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ProfileSettingsPage());
    },
  );
}

/// generated route for
/// [ProfileSetupPage]
class ProfileSetupRoute extends PageRouteInfo<void> {
  const ProfileSetupRoute({List<PageRouteInfo>? children})
    : super(ProfileSetupRoute.name, initialChildren: children);

  static const String name = 'ProfileSetupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ProfileSetupPage());
    },
  );
}

/// generated route for
/// [ProgramCompletePage]
class ProgramCompleteRoute extends PageRouteInfo<ProgramCompleteRouteArgs> {
  ProgramCompleteRoute({
    required String title,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ProgramCompleteRoute.name,
         args: ProgramCompleteRouteArgs(title: title, key: key),
         initialChildren: children,
       );

  static const String name = 'ProgramCompleteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProgramCompleteRouteArgs>();
      return ProgramCompletePage(title: args.title, key: args.key);
    },
  );
}

class ProgramCompleteRouteArgs {
  const ProgramCompleteRouteArgs({required this.title, this.key});

  final String title;

  final Key? key;

  @override
  String toString() {
    return 'ProgramCompleteRouteArgs{title: $title, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProgramCompleteRouteArgs) return false;
    return title == other.title && key == other.key;
  }

  @override
  int get hashCode => title.hashCode ^ key.hashCode;
}

/// generated route for
/// [ProgramDetailPage]
class ProgramDetailRoute extends PageRouteInfo<ProgramDetailRouteArgs> {
  ProgramDetailRoute({
    required String slug,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ProgramDetailRoute.name,
         args: ProgramDetailRouteArgs(slug: slug, key: key),
         rawPathParams: {'slug': slug},
         initialChildren: children,
       );

  static const String name = 'ProgramDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ProgramDetailRouteArgs>(
        orElse: () =>
            ProgramDetailRouteArgs(slug: pathParams.getString('slug')),
      );
      return WrappedRoute(
        child: ProgramDetailPage(slug: args.slug, key: args.key),
      );
    },
  );
}

class ProgramDetailRouteArgs {
  const ProgramDetailRouteArgs({required this.slug, this.key});

  final String slug;

  final Key? key;

  @override
  String toString() {
    return 'ProgramDetailRouteArgs{slug: $slug, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProgramDetailRouteArgs) return false;
    return slug == other.slug && key == other.key;
  }

  @override
  int get hashCode => slug.hashCode ^ key.hashCode;
}

/// generated route for
/// [ProgramsPage]
class ProgramsRoute extends PageRouteInfo<void> {
  const ProgramsRoute({List<PageRouteInfo>? children})
    : super(ProgramsRoute.name, initialChildren: children);

  static const String name = 'ProgramsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ProgramsPage());
    },
  );
}

/// generated route for
/// [QuestionsPage]
class QuestionsRoute extends PageRouteInfo<void> {
  const QuestionsRoute({List<PageRouteInfo>? children})
    : super(QuestionsRoute.name, initialChildren: children);

  static const String name = 'QuestionsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const QuestionsPage());
    },
  );
}

/// generated route for
/// [QuickRepairPage]
class QuickRepairRoute extends PageRouteInfo<QuickRepairRouteArgs> {
  QuickRepairRoute({String text = '', Key? key, List<PageRouteInfo>? children})
    : super(
        QuickRepairRoute.name,
        args: QuickRepairRouteArgs(text: text, key: key),
        rawQueryParams: {'text': text},
        initialChildren: children,
      );

  static const String name = 'QuickRepairRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<QuickRepairRouteArgs>(
        orElse: () =>
            QuickRepairRouteArgs(text: queryParams.getString('text', '')),
      );
      return WrappedRoute(
        child: QuickRepairPage(text: args.text, key: args.key),
      );
    },
  );
}

class QuickRepairRouteArgs {
  const QuickRepairRouteArgs({this.text = '', this.key});

  final String text;

  final Key? key;

  @override
  String toString() {
    return 'QuickRepairRouteArgs{text: $text, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuickRepairRouteArgs) return false;
    return text == other.text && key == other.key;
  }

  @override
  int get hashCode => text.hashCode ^ key.hashCode;
}

/// generated route for
/// [QuickSlipPage]
class QuickSlipRoute extends PageRouteInfo<void> {
  const QuickSlipRoute({List<PageRouteInfo>? children})
    : super(QuickSlipRoute.name, initialChildren: children);

  static const String name = 'QuickSlipRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const QuickSlipPage());
    },
  );
}

/// generated route for
/// [QuizzesPage]
class QuizzesRoute extends PageRouteInfo<void> {
  const QuizzesRoute({List<PageRouteInfo>? children})
    : super(QuizzesRoute.name, initialChildren: children);

  static const String name = 'QuizzesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const QuizzesPage());
    },
  );
}

/// generated route for
/// [ReceivedSignalsPage]
class ReceivedSignalsRoute extends PageRouteInfo<void> {
  const ReceivedSignalsRoute({List<PageRouteInfo>? children})
    : super(ReceivedSignalsRoute.name, initialChildren: children);

  static const String name = 'ReceivedSignalsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const ReceivedSignalsPage());
    },
  );
}

/// generated route for
/// [RelationshipChangedPage]
class RelationshipChangedRoute extends PageRouteInfo<void> {
  const RelationshipChangedRoute({List<PageRouteInfo>? children})
    : super(RelationshipChangedRoute.name, initialChildren: children);

  static const String name = 'RelationshipChangedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const RelationshipChangedPage());
    },
  );
}

/// generated route for
/// [RelationshipPage]
class RelationshipRoute extends PageRouteInfo<void> {
  const RelationshipRoute({List<PageRouteInfo>? children})
    : super(RelationshipRoute.name, initialChildren: children);

  static const String name = 'RelationshipRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const RelationshipPage());
    },
  );
}

/// generated route for
/// [RestorePurchasesPage]
class RestorePurchasesRoute extends PageRouteInfo<void> {
  const RestorePurchasesRoute({List<PageRouteInfo>? children})
    : super(RestorePurchasesRoute.name, initialChildren: children);

  static const String name = 'RestorePurchasesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const RestorePurchasesPage());
    },
  );
}

/// generated route for
/// [RitualEditPage]
class RitualEditRoute extends PageRouteInfo<RitualEditRouteArgs> {
  RitualEditRoute({String? id, Key? key, List<PageRouteInfo>? children})
    : super(
        RitualEditRoute.name,
        args: RitualEditRouteArgs(id: id, key: key),
        rawQueryParams: {'id': id},
        initialChildren: children,
      );

  static const String name = 'RitualEditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<RitualEditRouteArgs>(
        orElse: () => RitualEditRouteArgs(id: queryParams.optString('id')),
      );
      return WrappedRoute(
        child: RitualEditPage(id: args.id, key: args.key),
      );
    },
  );
}

class RitualEditRouteArgs {
  const RitualEditRouteArgs({this.id, this.key});

  final String? id;

  final Key? key;

  @override
  String toString() {
    return 'RitualEditRouteArgs{id: $id, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RitualEditRouteArgs) return false;
    return id == other.id && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode;
}

/// generated route for
/// [RitualsPage]
class RitualsRoute extends PageRouteInfo<void> {
  const RitualsRoute({List<PageRouteInfo>? children})
    : super(RitualsRoute.name, initialChildren: children);

  static const String name = 'RitualsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const RitualsPage());
    },
  );
}

/// generated route for
/// [SessionExpiredPage]
class SessionExpiredRoute extends PageRouteInfo<SessionExpiredRouteArgs> {
  SessionExpiredRoute({
    VoidCallback? onSignIn,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         SessionExpiredRoute.name,
         args: SessionExpiredRouteArgs(onSignIn: onSignIn, key: key),
         initialChildren: children,
       );

  static const String name = 'SessionExpiredRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SessionExpiredRouteArgs>(
        orElse: () => const SessionExpiredRouteArgs(),
      );
      return SessionExpiredPage(onSignIn: args.onSignIn, key: args.key);
    },
  );
}

class SessionExpiredRouteArgs {
  const SessionExpiredRouteArgs({this.onSignIn, this.key});

  final VoidCallback? onSignIn;

  final Key? key;

  @override
  String toString() {
    return 'SessionExpiredRouteArgs{onSignIn: $onSignIn, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SessionExpiredRouteArgs) return false;
    return onSignIn == other.onSignIn && key == other.key;
  }

  @override
  int get hashCode => onSignIn.hashCode ^ key.hashCode;
}

/// generated route for
/// [SettingsHomePage]
class SettingsHomeRoute extends PageRouteInfo<void> {
  const SettingsHomeRoute({List<PageRouteInfo>? children})
    : super(SettingsHomeRoute.name, initialChildren: children);

  static const String name = 'SettingsHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SettingsHomePage());
    },
  );
}

/// generated route for
/// [SettingsThemePage]
class SettingsThemeRoute extends PageRouteInfo<void> {
  const SettingsThemeRoute({List<PageRouteInfo>? children})
    : super(SettingsThemeRoute.name, initialChildren: children);

  static const String name = 'SettingsThemeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsThemePage();
    },
  );
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SignInPage());
    },
  );
}

/// generated route for
/// [SlipDetailPage]
class SlipDetailRoute extends PageRouteInfo<SlipDetailRouteArgs> {
  SlipDetailRoute({required String id, Key? key, List<PageRouteInfo>? children})
    : super(
        SlipDetailRoute.name,
        args: SlipDetailRouteArgs(id: id, key: key),
        rawPathParams: {'id': id},
        initialChildren: children,
      );

  static const String name = 'SlipDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SlipDetailRouteArgs>(
        orElse: () => SlipDetailRouteArgs(id: pathParams.getString('id')),
      );
      return WrappedRoute(
        child: SlipDetailPage(id: args.id, key: args.key),
      );
    },
  );
}

class SlipDetailRouteArgs {
  const SlipDetailRouteArgs({required this.id, this.key});

  final String id;

  final Key? key;

  @override
  String toString() {
    return 'SlipDetailRouteArgs{id: $id, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SlipDetailRouteArgs) return false;
    return id == other.id && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode;
}

/// generated route for
/// [SlipKindPage]
class SlipKindRoute extends PageRouteInfo<SlipKindRouteArgs> {
  SlipKindRoute({
    SlipKind kind = SlipKind.specific,
    String text = '',
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         SlipKindRoute.name,
         args: SlipKindRouteArgs(kind: kind, text: text, key: key),
         rawQueryParams: {'text': text},
         initialChildren: children,
       );

  static const String name = 'SlipKindRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<SlipKindRouteArgs>(
        orElse: () =>
            SlipKindRouteArgs(text: queryParams.getString('text', '')),
      );
      return WrappedRoute(
        child: SlipKindPage(kind: args.kind, text: args.text, key: args.key),
      );
    },
  );
}

class SlipKindRouteArgs {
  const SlipKindRouteArgs({
    this.kind = SlipKind.specific,
    this.text = '',
    this.key,
  });

  final SlipKind kind;

  final String text;

  final Key? key;

  @override
  String toString() {
    return 'SlipKindRouteArgs{kind: $kind, text: $text, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SlipKindRouteArgs) return false;
    return kind == other.kind && text == other.text && key == other.key;
  }

  @override
  int get hashCode => kind.hashCode ^ text.hashCode ^ key.hashCode;
}

/// generated route for
/// [SlipsPage]
class SlipsRoute extends PageRouteInfo<void> {
  const SlipsRoute({List<PageRouteInfo>? children})
    : super(SlipsRoute.name, initialChildren: children);

  static const String name = 'SlipsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SlipsPage());
    },
  );
}

/// generated route for
/// [SlipsSearchPage]
class SlipsSearchRoute extends PageRouteInfo<void> {
  const SlipsSearchRoute({List<PageRouteInfo>? children})
    : super(SlipsSearchRoute.name, initialChildren: children);

  static const String name = 'SlipsSearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SlipsSearchPage());
    },
  );
}

/// generated route for
/// [SoftStartPage]
class SoftStartRoute extends PageRouteInfo<void> {
  const SoftStartRoute({List<PageRouteInfo>? children})
    : super(SoftStartRoute.name, initialChildren: children);

  static const String name = 'SoftStartRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SoftStartPage());
    },
  );
}

/// generated route for
/// [SosPage]
class SosRoute extends PageRouteInfo<void> {
  const SosRoute({List<PageRouteInfo>? children})
    : super(SosRoute.name, initialChildren: children);

  static const String name = 'SosRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SosPage();
    },
  );
}

/// generated route for
/// [SpiceCardsPage]
class SpiceCardsRoute extends PageRouteInfo<void> {
  const SpiceCardsRoute({List<PageRouteInfo>? children})
    : super(SpiceCardsRoute.name, initialChildren: children);

  static const String name = 'SpiceCardsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SpiceCardsPage());
    },
  );
}

/// generated route for
/// [SpiceChallengePage]
class SpiceChallengeRoute extends PageRouteInfo<void> {
  const SpiceChallengeRoute({List<PageRouteInfo>? children})
    : super(SpiceChallengeRoute.name, initialChildren: children);

  static const String name = 'SpiceChallengeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SpiceChallengePage());
    },
  );
}

/// generated route for
/// [SpiceDesiresPage]
class SpiceDesiresRoute extends PageRouteInfo<void> {
  const SpiceDesiresRoute({List<PageRouteInfo>? children})
    : super(SpiceDesiresRoute.name, initialChildren: children);

  static const String name = 'SpiceDesiresRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SpiceDesiresPage());
    },
  );
}

/// generated route for
/// [SpicePage]
class SpiceRoute extends PageRouteInfo<void> {
  const SpiceRoute({List<PageRouteInfo>? children})
    : super(SpiceRoute.name, initialChildren: children);

  static const String name = 'SpiceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SpicePage());
    },
  );
}

/// generated route for
/// [SpiceSettingsPage]
class SpiceSettingsRoute extends PageRouteInfo<void> {
  const SpiceSettingsRoute({List<PageRouteInfo>? children})
    : super(SpiceSettingsRoute.name, initialChildren: children);

  static const String name = 'SpiceSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SpiceSettingsPage());
    },
  );
}

/// generated route for
/// [StarterPage]
class StarterRoute extends PageRouteInfo<void> {
  const StarterRoute({List<PageRouteInfo>? children})
    : super(StarterRoute.name, initialChildren: children);

  static const String name = 'StarterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const StarterPage());
    },
  );
}

/// generated route for
/// [StoryDatesPage]
class StoryDatesRoute extends PageRouteInfo<void> {
  const StoryDatesRoute({List<PageRouteInfo>? children})
    : super(StoryDatesRoute.name, initialChildren: children);

  static const String name = 'StoryDatesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const StoryDatesPage());
    },
  );
}

/// generated route for
/// [StoryPage]
class StoryRoute extends PageRouteInfo<void> {
  const StoryRoute({List<PageRouteInfo>? children})
    : super(StoryRoute.name, initialChildren: children);

  static const String name = 'StoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const StoryPage());
    },
  );
}

/// generated route for
/// [SundayCardPage]
class SundayCardRoute extends PageRouteInfo<void> {
  const SundayCardRoute({List<PageRouteInfo>? children})
    : super(SundayCardRoute.name, initialChildren: children);

  static const String name = 'SundayCardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SundayCardPage());
    },
  );
}

/// generated route for
/// [SupportPage]
class SupportRoute extends PageRouteInfo<SupportRouteArgs> {
  SupportRoute({
    SupportTopic topic = SupportTopic.account,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         SupportRoute.name,
         args: SupportRouteArgs(topic: topic, key: key),
         initialChildren: children,
       );

  static const String name = 'SupportRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SupportRouteArgs>(
        orElse: () => const SupportRouteArgs(),
      );
      return WrappedRoute(
        child: SupportPage(topic: args.topic, key: args.key),
      );
    },
  );
}

class SupportRouteArgs {
  const SupportRouteArgs({this.topic = SupportTopic.account, this.key});

  final SupportTopic topic;

  final Key? key;

  @override
  String toString() {
    return 'SupportRouteArgs{topic: $topic, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SupportRouteArgs) return false;
    return topic == other.topic && key == other.key;
  }

  @override
  int get hashCode => topic.hashCode ^ key.hashCode;
}

/// generated route for
/// [TemperatureHistoryPage]
class TemperatureHistoryRoute extends PageRouteInfo<void> {
  const TemperatureHistoryRoute({List<PageRouteInfo>? children})
    : super(TemperatureHistoryRoute.name, initialChildren: children);

  static const String name = 'TemperatureHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const TemperatureHistoryPage());
    },
  );
}

/// generated route for
/// [TemperaturePage]
class TemperatureRoute extends PageRouteInfo<void> {
  const TemperatureRoute({List<PageRouteInfo>? children})
    : super(TemperatureRoute.name, initialChildren: children);

  static const String name = 'TemperatureRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const TemperaturePage());
    },
  );
}

/// generated route for
/// [TimeInAppPage]
class TimeInAppRoute extends PageRouteInfo<void> {
  const TimeInAppRoute({List<PageRouteInfo>? children})
    : super(TimeInAppRoute.name, initialChildren: children);

  static const String name = 'TimeInAppRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TimeInAppPage();
    },
  );
}

/// generated route for
/// [TodayPage]
class TodayRoute extends PageRouteInfo<void> {
  const TodayRoute({List<PageRouteInfo>? children})
    : super(TodayRoute.name, initialChildren: children);

  static const String name = 'TodayRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const TodayPage());
    },
  );
}

/// generated route for
/// [TogetherPage]
class TogetherRoute extends PageRouteInfo<TogetherRouteArgs> {
  TogetherRoute({
    bool isEmbedded = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         TogetherRoute.name,
         args: TogetherRouteArgs(isEmbedded: isEmbedded, key: key),
         initialChildren: children,
       );

  static const String name = 'TogetherRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TogetherRouteArgs>(
        orElse: () => const TogetherRouteArgs(),
      );
      return WrappedRoute(
        child: TogetherPage(isEmbedded: args.isEmbedded, key: args.key),
      );
    },
  );
}

class TogetherRouteArgs {
  const TogetherRouteArgs({this.isEmbedded = false, this.key});

  final bool isEmbedded;

  final Key? key;

  @override
  String toString() {
    return 'TogetherRouteArgs{isEmbedded: $isEmbedded, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TogetherRouteArgs) return false;
    return isEmbedded == other.isEmbedded && key == other.key;
  }

  @override
  int get hashCode => isEmbedded.hashCode ^ key.hashCode;
}

/// generated route for
/// [TouchPage]
class TouchRoute extends PageRouteInfo<void> {
  const TouchRoute({List<PageRouteInfo>? children})
    : super(TouchRoute.name, initialChildren: children);

  static const String name = 'TouchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const TouchPage());
    },
  );
}

/// generated route for
/// [UnpairDonePage]
class UnpairDoneRoute extends PageRouteInfo<void> {
  const UnpairDoneRoute({List<PageRouteInfo>? children})
    : super(UnpairDoneRoute.name, initialChildren: children);

  static const String name = 'UnpairDoneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const UnpairDonePage());
    },
  );
}

/// generated route for
/// [UnpairPage]
class UnpairRoute extends PageRouteInfo<void> {
  const UnpairRoute({List<PageRouteInfo>? children})
    : super(UnpairRoute.name, initialChildren: children);

  static const String name = 'UnpairRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const UnpairPage());
    },
  );
}

/// generated route for
/// [UsPage]
class UsRoute extends PageRouteInfo<void> {
  const UsRoute({List<PageRouteInfo>? children})
    : super(UsRoute.name, initialChildren: children);

  static const String name = 'UsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const UsPage());
    },
  );
}

/// generated route for
/// [WeeklyReviewPage]
class WeeklyReviewRoute extends PageRouteInfo<void> {
  const WeeklyReviewRoute({List<PageRouteInfo>? children})
    : super(WeeklyReviewRoute.name, initialChildren: children);

  static const String name = 'WeeklyReviewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const WeeklyReviewPage());
    },
  );
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomePage();
    },
  );
}
