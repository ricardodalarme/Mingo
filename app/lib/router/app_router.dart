import 'package:app/features/account/presentation/delete/delete_account_page.dart';
import 'package:app/features/account/presentation/export/export_data_page.dart';
import 'package:app/features/agreements/presentation/agreements/agreements_page.dart';
import 'package:app/features/annoyances/presentation/annoyance_check/annoyance_check_page.dart';
import 'package:app/features/annoyances/presentation/gentle_request/gentle_request_page.dart';
import 'package:app/features/annoyances/presentation/gentle_request_detail/gentle_request_detail_page.dart';
import 'package:app/features/app/presentation/time_in_app/time_in_app_page.dart';
import 'package:app/features/authentication/presentation/create_account/create_account_page.dart';
import 'package:app/features/authentication/presentation/existing_account/existing_account_page.dart';
import 'package:app/features/authentication/presentation/session_expired/session_expired_page.dart';
import 'package:app/features/authentication/presentation/sign_in/sign_in_page.dart';
import 'package:app/features/authentication/presentation/welcome/welcome_page.dart';
import 'package:app/features/capsules/presentation/capsules/capsules_page.dart';
import 'package:app/features/cards/presentation/detail/card_detail_page.dart';
import 'package:app/features/cards/presentation/draft/sunday_card_page.dart';
import 'package:app/features/cards/presentation/list/cards_list_page.dart';
import 'package:app/features/cards/presentation/settings/card_settings_page.dart';
import 'package:app/features/chat/data/models/chat_models.dart';
import 'package:app/features/chat/presentation/chat/chat_page.dart';
import 'package:app/features/chat/presentation/chat_tab/chat_tab_page.dart';
import 'package:app/features/chat/presentation/learned/learned_items_page.dart';
import 'package:app/features/chat/presentation/settings/chat_settings_page.dart';
import 'package:app/features/checkin/presentation/checkin/checkin_page.dart';
import 'package:app/features/connect/presentation/us/us_page.dart';
import 'package:app/features/couple/presentation/couple/couple_page.dart';
import 'package:app/features/dates/presentation/dates/dates_page.dart';
import 'package:app/features/dev_menu/debug_sign_in/debug_sign_in_page.dart';
import 'package:app/features/devices/presentation/devices/devices_page.dart';
import 'package:app/features/diary/presentation/diary/diary_page.dart';
import 'package:app/features/distance/presentation/distance/distance_page.dart';
import 'package:app/features/fight_style/presentation/exercise/fight_style_page.dart';
import 'package:app/features/games/presentation/game/game_page.dart';
import 'package:app/features/games/presentation/hub/games_page.dart';
import 'package:app/features/gifts/presentation/gifts/gifts_page.dart';
import 'package:app/features/help/data/models/support_topic.dart';
import 'package:app/features/help/presentation/help/help_page.dart';
import 'package:app/features/help/presentation/support/support_page.dart';
import 'package:app/features/history/data/models/history_models.dart';
import 'package:app/features/history/presentation/avatar/history_avatar_page.dart';
import 'package:app/features/history/presentation/different_dates/different_dates_page.dart';
import 'package:app/features/history/presentation/history/history_page.dart';
import 'package:app/features/history/presentation/milestone/milestone_page.dart';
import 'package:app/features/history/presentation/numbers/history_numbers_page.dart';
import 'package:app/features/history/presentation/story_dates/story_dates_page.dart';
import 'package:app/features/history/presentation/variations/counter_variations_page.dart';
import 'package:app/features/home/presentation/home/home_page.dart';
import 'package:app/features/home_widgets/presentation/gallery/home_widgets_gallery_page.dart';
import 'package:app/features/ideas/presentation/detail/idea_detail_page.dart';
import 'package:app/features/lists/presentation/detail/list_detail_page.dart';
import 'package:app/features/lists/presentation/lists/lists_page.dart';
import 'package:app/features/love_style/presentation/compare/love_style_compare_page.dart';
import 'package:app/features/love_style/presentation/exercise/love_style_page.dart';
import 'package:app/features/mood/presentation/calendar/mood_calendar_page.dart';
import 'package:app/features/mood/presentation/mood/mood_page.dart';
import 'package:app/features/not_found/presentation/not_found/not_found_page.dart';
import 'package:app/features/notes/presentation/compose/compose_page.dart';
import 'package:app/features/notifications/presentation/inbox/inbox_page.dart';
import 'package:app/features/notifications/presentation/permission/notification_permission_page.dart';
import 'package:app/features/notifications/presentation/preferences/notification_preferences_page.dart';
import 'package:app/features/onboarding/presentation/first_slip/first_slip_page.dart';
import 'package:app/features/onboarding/presentation/goals/intro_goals_page.dart';
import 'package:app/features/onboarding/presentation/partner/partner_step_page.dart';
import 'package:app/features/onboarding/presentation/phase/intro_phase_page.dart';
import 'package:app/features/onboarding/presentation/theme/intro_theme_page.dart';
import 'package:app/features/pairing/presentation/accept/accept_invite_page.dart';
import 'package:app/features/pairing/presentation/invite/invite_page.dart';
import 'package:app/features/pairing/presentation/relationship/grief_support_page.dart';
import 'package:app/features/pairing/presentation/relationship/relationship_changed_page.dart';
import 'package:app/features/pairing/presentation/relationship/relationship_page.dart';
import 'package:app/features/pairing/presentation/unpair/breakup_page.dart';
import 'package:app/features/pairing/presentation/unpair/unpair_done_page.dart';
import 'package:app/features/pairing/presentation/unpair/unpair_page.dart';
import 'package:app/features/partner/presentation/profile/partner_profile_page.dart';
import 'package:app/features/plus/presentation/manage/manage_plus_page.dart';
import 'package:app/features/plus/presentation/plans/plans_page.dart';
import 'package:app/features/plus/presentation/restore/restore_purchases_page.dart';
import 'package:app/features/privacy/presentation/consents/consents_page.dart';
import 'package:app/features/privacy/presentation/hub/privacy_hub_page.dart';
import 'package:app/features/privacy/presentation/our_view/our_view_page.dart';
import 'package:app/features/privacy/presentation/partner_view/partner_view_page.dart';
import 'package:app/features/profile/presentation/profile/profile_settings_page.dart';
import 'package:app/features/profile/presentation/setup/profile_setup_page.dart';
import 'package:app/features/questions/presentation/questions/questions_page.dart';
import 'package:app/features/quizzes/presentation/hub/quizzes_page.dart';
import 'package:app/features/repair/presentation/calm/calm_page.dart';
import 'package:app/features/repair/presentation/guided/guided_repair_page.dart';
import 'package:app/features/repair/presentation/history/temperature_history_page.dart';
import 'package:app/features/repair/presentation/learning/learning_page.dart';
import 'package:app/features/repair/presentation/quick_repair/quick_repair_page.dart';
import 'package:app/features/repair/presentation/received/received_signals_page.dart';
import 'package:app/features/repair/presentation/soft_start/soft_start_page.dart';
import 'package:app/features/repair/presentation/sos/sos_page.dart';
import 'package:app/features/repair/presentation/temperature/temperature_page.dart';
import 'package:app/features/settings/presentation/home/settings_home_page.dart';
import 'package:app/features/settings/presentation/language/language_page.dart';
import 'package:app/features/settings/presentation/theme/theme_page.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/presentation/need/need_page.dart';
import 'package:app/features/slips/presentation/quick_slip/quick_slip_page.dart';
import 'package:app/features/slips/presentation/slip_detail/slip_detail_page.dart';
import 'package:app/features/slips/presentation/slip_kind/slip_kind_page.dart';
import 'package:app/features/slips/presentation/slips/slips_page.dart';
import 'package:app/features/slips/presentation/slips_search/slips_search_page.dart';
import 'package:app/features/spice/presentation/cards/spice_cards_page.dart';
import 'package:app/features/spice/presentation/challenge/spice_challenge_page.dart';
import 'package:app/features/spice/presentation/desires/spice_desires_page.dart';
import 'package:app/features/spice/presentation/settings/spice_settings_page.dart';
import 'package:app/features/spice/presentation/spice/spice_page.dart';
import 'package:app/features/story/presentation/story/story_page.dart';
import 'package:app/features/today/presentation/today/today_page.dart';
import 'package:app/features/together/presentation/date_night/date_night_page.dart';
import 'package:app/features/together/presentation/day/day_page.dart';
import 'package:app/features/together/presentation/logistics/logistics_page.dart';
import 'package:app/features/together/presentation/ritual_edit/ritual_edit_page.dart';
import 'package:app/features/together/presentation/rituals/rituals_page.dart';
import 'package:app/features/together/presentation/together/together_page.dart';
import 'package:app/features/weekly_review/presentation/weekly_review/weekly_review_page.dart';
import 'package:app/router/utils/public_destination.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

part 'app_router.gr.dart';

/// Path that reopens an invite kept from a signed-out link after sign-in.
const String acceptInvitePath = '/accept-invite';

@AutoRouterConfig()
class AppRouter({required final AutoRouteGuard _guard}) extends RootStackRouter {
  @override
  List<AutoRouteGuard> get guards => [_guard];

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      children: [
        RedirectRoute(path: '', redirectTo: 'today'),
        AutoRoute(page: TodayRoute.page, path: 'today'),
        AutoRoute(page: SlipsRoute.page, path: 'slips'),
        AutoRoute(page: ChatTabRoute.page, path: 'chat'),
        AutoRoute(page: CoupleRoute.page, path: 'couple'),
      ],
    ),
    RedirectRoute(path: '/together', redirectTo: '/couple'),
    ..._accessRoutes,
    ..._captureRoutes,
    ..._repairRoutes,
    ..._conversationRoutes,
    ..._togetherRoutes,
    ..._settingsRoutes,
    ..._homeWidgetRoutes,
    AutoRoute(path: '*', page: NotFoundRoute.page, meta: publicRouteMeta),
  ];

  /// Signing in, onboarding, the invite and the person's own profile.
  List<AutoRoute> get _accessRoutes => [
    AutoRoute(page: WelcomeRoute.page, path: '/welcome', meta: publicRouteMeta),
    AutoRoute(page: IntroPhaseRoute.page, meta: publicRouteMeta),
    AutoRoute(page: IntroGoalsRoute.page, meta: publicRouteMeta),
    AutoRoute(page: IntroThemeRoute.page, meta: publicRouteMeta),
    AutoRoute(page: FirstSlipRoute.page, meta: publicRouteMeta),
    AutoRoute(page: PartnerStepRoute.page, meta: publicRouteMeta),
    AutoRoute(page: SignInRoute.page, path: '/sign-in', meta: publicRouteMeta),
    AutoRoute(page: CreateAccountRoute.page, meta: publicRouteMeta),
    AutoRoute(page: SessionExpiredRoute.page, meta: publicRouteMeta),
    AutoRoute(page: ExistingAccountRoute.page, meta: publicRouteMeta),
    AutoRoute(page: DebugSignInRoute.page, meta: publicRouteMeta),
    AutoRoute(page: ProfileSetupRoute.page),
    AutoRoute(page: ProfileSettingsRoute.page),
    AutoRoute(page: InviteRoute.page, path: '/invite'),
    AutoRoute(page: AcceptInviteRoute.page, path: acceptInvitePath),
    AutoRoute(page: RelationshipRoute.page),
    AutoRoute(page: RelationshipChangedRoute.page),
    AutoRoute(page: GriefSupportRoute.page),
    AutoRoute(page: UnpairRoute.page),
    AutoRoute(page: BreakupRoute.page),
    AutoRoute(page: UnpairDoneRoute.page),
    AutoRoute(page: UsRoute.page),
    AutoRoute(page: DeleteAccountRoute.page),
    AutoRoute(page: ExportDataRoute.page),
  ];

  /// Slips, notes and the weekly rhythm around them.
  List<AutoRoute> get _captureRoutes => [
    AutoRoute(page: NotificationPermissionRoute.page, fullscreenDialog: true),
    AutoRoute(page: QuickSlipRoute.page, path: '/capture', fullscreenDialog: true),
    AutoRoute(page: GentleRequestRoute.page),
    AutoRoute(page: AnnoyanceCheckRoute.page),
    AutoRoute(page: WeeklyReviewRoute.page),
    AutoRoute(page: GentleRequestDetailRoute.page),
    AutoRoute(page: SlipsSearchRoute.page),
    AutoRoute(page: SlipKindRoute.page, fullscreenDialog: true),
    AutoRoute(page: NeedRoute.page, fullscreenDialog: true),
    AutoRoute(page: ComposeRoute.page, fullscreenDialog: true),
    AutoRoute(page: SlipDetailRoute.page, path: '/slip/:id'),
    AutoRoute(page: InboxRoute.page),
    AutoRoute(page: NotificationPreferencesRoute.page),
    AutoRoute(page: SundayCardRoute.page, path: '/card', fullMatch: true),
    AutoRoute(page: CardsListRoute.page),
    AutoRoute(page: CardSettingsRoute.page),
    AutoRoute(page: CheckinRoute.page),
    AutoRoute(page: IdeaDetailRoute.page, path: '/idea'),
    AutoRoute(page: CardDetailRoute.page, path: '/card/:id'),
    AutoRoute(page: MoodRoute.page, path: '/mood'),
    AutoRoute(page: MoodCalendarRoute.page),
  ];

  /// The fight, repair and self-knowledge flows.
  List<AutoRoute> get _repairRoutes => [
    AutoRoute(page: TemperatureRoute.page, fullscreenDialog: true),
    AutoRoute(page: CalmRoute.page, fullscreenDialog: true),
    AutoRoute(page: SosRoute.page, fullscreenDialog: true),
    AutoRoute(page: TemperatureHistoryRoute.page),
    AutoRoute(page: ReceivedSignalsRoute.page),
    AutoRoute(page: PartnerProfileRoute.page),
    AutoRoute(page: GuidedRepairRoute.page, fullscreenDialog: true),
    AutoRoute(page: LearningRoute.page),
    AutoRoute(page: FightStyleRoute.page, fullscreenDialog: true),
    AutoRoute(page: LoveStyleRoute.page, fullscreenDialog: true),
    AutoRoute(page: SoftStartRoute.page, fullscreenDialog: true),
    AutoRoute(page: QuickRepairRoute.page, fullscreenDialog: true),
  ];

  /// The mascot chat and Spice.
  List<AutoRoute> get _conversationRoutes => [
    AutoRoute(page: ChatRoute.page),
    AutoRoute(page: ChatSettingsRoute.page),
    AutoRoute(page: LearnedItemsRoute.page),
    AutoRoute(page: SpiceRoute.page),
    AutoRoute(page: SpiceCardsRoute.page),
    AutoRoute(page: SpiceDesiresRoute.page),
    AutoRoute(page: SpiceChallengeRoute.page),
    AutoRoute(page: SpiceSettingsRoute.page),
  ];

  /// What the couple keeps and does together.
  List<AutoRoute> get _togetherRoutes => [
    AutoRoute(page: TimeInAppRoute.page, fullscreenDialog: true),
    AutoRoute(page: LogisticsRoute.page),
    AutoRoute(page: RitualsRoute.page, path: '/rituals'),
    AutoRoute(page: TogetherRoute.page),
    AutoRoute(page: DistanceRoute.page, path: '/distance'),
    AutoRoute(page: CapsulesRoute.page),
    AutoRoute(page: DatesRoute.page, path: '/dates'),
    AutoRoute(page: DayRoute.page),
    AutoRoute(page: DateNightRoute.page),
    AutoRoute(page: RitualEditRoute.page),
    AutoRoute(page: ListsRoute.page),
    AutoRoute(page: AgreementsRoute.page),
    AutoRoute(page: GiftsRoute.page),
    AutoRoute(page: ListDetailRoute.page, path: '/list/:id'),
    AutoRoute(page: GamesRoute.page, path: '/games'),
    AutoRoute(page: GameRoute.page, path: '/games/:game'),
    AutoRoute(page: QuestionsRoute.page),
    AutoRoute(page: DiaryRoute.page),
    AutoRoute(page: HistoryRoute.page),
    AutoRoute(page: StoryRoute.page),
    AutoRoute(page: MilestoneRoute.page),
    AutoRoute(page: StoryDatesRoute.page),
    AutoRoute(page: CounterVariationsRoute.page),
    AutoRoute(page: HistoryAvatarRoute.page),
    AutoRoute(page: HistoryNumbersRoute.page),
    AutoRoute(page: DifferentDatesRoute.page),
    AutoRoute(page: QuizzesRoute.page, path: '/quizzes'),
    AutoRoute(page: LoveStyleCompareRoute.page),
  ];

  /// Settings, privacy, plans and help.
  List<AutoRoute> get _settingsRoutes => [
    AutoRoute(page: PlansRoute.page),
    AutoRoute(page: ManagePlusRoute.page),
    AutoRoute(page: RestorePurchasesRoute.page),
    AutoRoute(page: SettingsHomeRoute.page),
    AutoRoute(page: SettingsThemeRoute.page),
    AutoRoute(page: LanguageRoute.page),
    AutoRoute(page: HelpRoute.page),
    AutoRoute(page: SupportRoute.page),
    AutoRoute(page: PrivacyHubRoute.page),
    AutoRoute(page: PartnerViewRoute.page),
    AutoRoute(page: OurViewRoute.page),
    AutoRoute(page: ConsentsRoute.page),
    AutoRoute(page: DevicesRoute.page),
  ];

  /// The home-screen widget gallery.
  List<AutoRoute> get _homeWidgetRoutes => [
    AutoRoute(page: HomeWidgetsGalleryRoute.page, path: '/widgets'),
  ];
}
