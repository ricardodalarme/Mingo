import 'package:app/features/account/presentation/delete/delete_account_page.dart';
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
import 'package:app/features/chat/presentation/hard_conversation/hard_conversation_page.dart';
import 'package:app/features/chat/presentation/learned/learned_items_page.dart';
import 'package:app/features/chat/presentation/settings/chat_settings_page.dart';
import 'package:app/features/checkin/presentation/checkin/checkin_page.dart';
import 'package:app/features/connect/presentation/touch/touch_page.dart';
import 'package:app/features/connect/presentation/us/us_page.dart';
import 'package:app/features/couple/presentation/couple/couple_page.dart';
import 'package:app/features/couple/presentation/couple/cubit/couple_cubit.dart';
import 'package:app/features/dates/presentation/dates/dates_page.dart';
import 'package:app/features/dev_menu/debug_sign_in/debug_sign_in_page.dart';
import 'package:app/features/devices/presentation/devices/devices_page.dart';
import 'package:app/features/distance/presentation/distance/distance_page.dart';
import 'package:app/features/fight_style/presentation/exercise/fight_style_page.dart';
import 'package:app/features/games/presentation/game/game_page.dart';
import 'package:app/features/games/presentation/hub/games_page.dart';
import 'package:app/features/gifts/presentation/gifts/gifts_page.dart';
import 'package:app/features/guides/presentation/hub/guides_page.dart';
import 'package:app/features/guides/presentation/viewer/guide_page.dart';
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
import 'package:app/features/ideas/presentation/detail/idea_detail_page.dart';
import 'package:app/features/lists/presentation/detail/list_detail_page.dart';
import 'package:app/features/lists/presentation/lists/lists_page.dart';
import 'package:app/features/love_style/presentation/exercise/love_style_page.dart';
import 'package:app/features/memories/presentation/memories/memories_page.dart';
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
import 'package:app/features/programs/presentation/diary/diary_page.dart';
import 'package:app/features/programs/presentation/lesson/lesson_page.dart';
import 'package:app/features/programs/presentation/program_complete/program_complete_page.dart';
import 'package:app/features/programs/presentation/program_detail/program_detail_page.dart';
import 'package:app/features/programs/presentation/programs/programs_page.dart';
import 'package:app/features/questions/presentation/questions/questions_page.dart';
import 'package:app/features/repair/presentation/calm/calm_page.dart';
import 'package:app/features/repair/presentation/guided/guided_repair_page.dart';
import 'package:app/features/repair/presentation/learning/learning_page.dart';
import 'package:app/features/repair/presentation/quick_repair/quick_repair_page.dart';
import 'package:app/features/repair/presentation/received/received_signals_page.dart';
import 'package:app/features/repair/presentation/soft_start/soft_start_page.dart';
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
import 'package:app/features/spice/presentation/spice/spice_page.dart';
import 'package:app/features/story/presentation/story/story_page.dart';
import 'package:app/features/today/presentation/today/today_page.dart';
import 'package:app/features/together/presentation/date_night/date_night_page.dart';
import 'package:app/features/together/presentation/day/day_page.dart';
import 'package:app/features/together/presentation/help/bad_day_page.dart';
import 'package:app/features/together/presentation/help/starter_page.dart';
import 'package:app/features/together/presentation/logistics/logistics_page.dart';
import 'package:app/features/together/presentation/ritual_edit/ritual_edit_page.dart';
import 'package:app/features/together/presentation/rituals/rituals_page.dart';
import 'package:app/features/together/presentation/together/together_page.dart';
import 'package:app/features/weekly_review/presentation/weekly_review/weekly_review_page.dart';
import 'package:app/features/widgets/presentation/card_encounter/card_encounter_widget_page.dart';
import 'package:app/features/widgets/presentation/couple_counter/couple_counter_widget_page.dart';
import 'package:app/features/widgets/presentation/couple_photos/couple_photos_widget_page.dart';
import 'package:app/features/widgets/presentation/gallery/widgets_gallery_page.dart';
import 'package:app/features/widgets/presentation/lock_screen/lock_screen_widget_page.dart';
import 'package:app/features/widgets/presentation/own_medium/own_medium_widgets_page.dart';
import 'package:app/features/widgets/presentation/own_small/own_small_widgets_page.dart';
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
    AutoRoute(page: WelcomeRoute.page, initial: true),
    AutoRoute(page: IntroPhaseRoute.page),
    AutoRoute(page: IntroGoalsRoute.page),
    AutoRoute(page: IntroThemeRoute.page),
    AutoRoute(page: FirstSlipRoute.page),
    AutoRoute(page: PartnerStepRoute.page),
    AutoRoute(page: NotificationPermissionRoute.page, fullscreenDialog: true),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: CreateAccountRoute.page),
    AutoRoute(page: SessionExpiredRoute.page),
    AutoRoute(page: ExistingAccountRoute.page),
    AutoRoute(page: DebugSignInRoute.page),
    AutoRoute(page: ProfileSetupRoute.page),
    AutoRoute(page: ProfileSettingsRoute.page),
    AutoRoute(page: InviteRoute.page),
    AutoRoute(page: AcceptInviteRoute.page, path: acceptInvitePath),
    AutoRoute(page: RelationshipRoute.page),
    AutoRoute(page: RelationshipChangedRoute.page),
    AutoRoute(page: GriefSupportRoute.page),
    AutoRoute(page: UnpairRoute.page),
    AutoRoute(page: BreakupRoute.page),
    AutoRoute(page: UnpairDoneRoute.page),
    AutoRoute(page: QuickSlipRoute.page, fullscreenDialog: true),
    AutoRoute(page: GentleRequestRoute.page),
    AutoRoute(page: AnnoyanceCheckRoute.page),
    AutoRoute(page: WeeklyReviewRoute.page),
    AutoRoute(page: GentleRequestDetailRoute.page),
    AutoRoute(page: SlipsSearchRoute.page),
    AutoRoute(page: SlipKindRoute.page, fullscreenDialog: true),
    AutoRoute(page: NeedRoute.page, fullscreenDialog: true),
    AutoRoute(page: TemperatureRoute.page, fullscreenDialog: true),
    AutoRoute(page: CalmRoute.page, fullscreenDialog: true),
    AutoRoute(page: TimeInAppRoute.page, fullscreenDialog: true),
    AutoRoute(page: ReceivedSignalsRoute.page),
    AutoRoute(page: LogisticsRoute.page),
    AutoRoute(page: RitualsRoute.page),
    AutoRoute(page: PartnerProfileRoute.page),
    AutoRoute(page: ChatRoute.page),
    AutoRoute(page: TogetherRoute.page),
    AutoRoute(page: MemoriesRoute.page),
    AutoRoute(page: ChatSettingsRoute.page),
    AutoRoute(page: HardConversationRoute.page),
    AutoRoute(page: LearnedItemsRoute.page),
    AutoRoute(page: SpiceRoute.page),
    AutoRoute(page: ComposeRoute.page),
    AutoRoute(page: UsRoute.page),
    AutoRoute(page: TouchRoute.page),
    AutoRoute(page: DistanceRoute.page),
    AutoRoute(page: CapsulesRoute.page),
    AutoRoute(page: DatesRoute.page),
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
    AutoRoute(page: DeleteAccountRoute.page),
    AutoRoute(page: BadDayRoute.page),
    AutoRoute(page: StarterRoute.page),
    AutoRoute(page: DayRoute.page),
    AutoRoute(page: DateNightRoute.page),
    AutoRoute(page: RitualEditRoute.page),
    AutoRoute(page: GuidedRepairRoute.page, fullscreenDialog: true),
    AutoRoute(page: LearningRoute.page),
    AutoRoute(page: FightStyleRoute.page, fullscreenDialog: true),
    AutoRoute(page: LoveStyleRoute.page, fullscreenDialog: true),
    AutoRoute(page: SoftStartRoute.page, fullscreenDialog: true),
    AutoRoute(page: QuickRepairRoute.page, fullscreenDialog: true),
    AutoRoute(page: SlipDetailRoute.page, path: '/slip/:id'),
    AutoRoute(page: ListsRoute.page),
    AutoRoute(page: GiftsRoute.page),
    AutoRoute(page: ListDetailRoute.page, path: '/list/:id'),
    AutoRoute(page: GamesRoute.page, path: '/games'),
    AutoRoute(page: GameRoute.page, path: '/games/:game'),
    AutoRoute(page: GuidesRoute.page, path: '/guides'),
    AutoRoute(page: GuideRoute.page, path: '/guide/:slug', fullscreenDialog: true),
    AutoRoute(page: InboxRoute.page),
    AutoRoute(page: NotificationPreferencesRoute.page),
    AutoRoute(page: DevicesRoute.page),
    AutoRoute(page: SundayCardRoute.page),
    AutoRoute(page: CardsListRoute.page),
    AutoRoute(page: CardSettingsRoute.page),
    AutoRoute(page: CheckinRoute.page),
    AutoRoute(page: QuestionsRoute.page),
    AutoRoute(page: ProgramsRoute.page),
    AutoRoute(page: ProgramDetailRoute.page, path: '/program/:slug'),
    AutoRoute(page: LessonRoute.page, path: '/program/:slug/day/:day'),
    AutoRoute(page: ProgramCompleteRoute.page),
    AutoRoute(page: DiaryRoute.page),
    AutoRoute(page: IdeaDetailRoute.page, path: '/idea'),
    AutoRoute(page: CardDetailRoute.page, path: '/card/:id'),
    AutoRoute(page: MoodRoute.page),
    AutoRoute(page: HistoryRoute.page),
    AutoRoute(page: StoryRoute.page),
    AutoRoute(page: MilestoneRoute.page),
    AutoRoute(page: StoryDatesRoute.page),
    AutoRoute(page: CounterVariationsRoute.page),
    AutoRoute(page: HistoryAvatarRoute.page),
    AutoRoute(page: HistoryNumbersRoute.page),
    AutoRoute(page: DifferentDatesRoute.page),
    AutoRoute(page: WidgetsGalleryRoute.page),
    AutoRoute(page: OwnSmallWidgetsRoute.page),
    AutoRoute(page: OwnMediumWidgetsRoute.page),
    AutoRoute(page: LockRouteWidgetRoute.page),
    AutoRoute(page: CoupleCounterWidgetRoute.page),
    AutoRoute(page: CouplePhotosWidgetRoute.page),
    AutoRoute(page: CardEncounterWidgetRoute.page),
    AutoRoute(
      page: HomeRoute.page,
      children: [
        AutoRoute(page: TodayRoute.page, initial: true),
        AutoRoute(page: SlipsRoute.page),
        AutoRoute(page: ChatTabRoute.page),
        AutoRoute(page: CoupleRoute.page),
      ],
    ),
    AutoRoute(path: '*', page: NotFoundRoute.page),
  ];
}
