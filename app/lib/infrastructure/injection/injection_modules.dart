import 'package:app/features/_shared/di/shared_injection_module.dart';
import 'package:app/features/account/di/account_injection_module.dart';
import 'package:app/features/agreements/di/agreements_injection_module.dart';
import 'package:app/features/annoyances/di/annoyances_injection_module.dart';
import 'package:app/features/app/di/app_injection_module.dart';
import 'package:app/features/authentication/di/authentication_injection_module.dart';
import 'package:app/features/capsules/di/capsules_injection_module.dart';
import 'package:app/features/cards/di/cards_injection_module.dart';
import 'package:app/features/chat/di/chat_injection_module.dart';
import 'package:app/features/checkin/di/checkin_injection_module.dart';
import 'package:app/features/connect/di/connect_injection_module.dart';
import 'package:app/features/couple/di/couple_injection_module.dart';
import 'package:app/features/dates/di/dates_injection_module.dart';
import 'package:app/features/dev_menu/di/dev_menu_injection_module.dart';
import 'package:app/features/devices/di/devices_injection_module.dart';
import 'package:app/features/distance/di/distance_injection_module.dart';
import 'package:app/features/fight_style/di/fight_style_injection_module.dart';
import 'package:app/features/games/di/games_injection_module.dart';
import 'package:app/features/gifts/di/gifts_injection_module.dart';
import 'package:app/features/guides/di/guides_injection_module.dart';
import 'package:app/features/help/di/help_injection_module.dart';
import 'package:app/features/history/di/history_injection_module.dart';
import 'package:app/features/home_widgets/di/home_widgets_injection_module.dart';
import 'package:app/features/ideas/di/ideas_injection_module.dart';
import 'package:app/features/lists/di/lists_injection_module.dart';
import 'package:app/features/love_style/di/love_style_injection_module.dart';
import 'package:app/features/memories/di/memories_injection_module.dart';
import 'package:app/features/mood/di/mood_injection_module.dart';
import 'package:app/features/notes/di/notes_injection_module.dart';
import 'package:app/features/notifications/di/notifications_injection_module.dart';
import 'package:app/features/onboarding/di/onboarding_injection_module.dart';
import 'package:app/features/pairing/di/pairing_injection_module.dart';
import 'package:app/features/partner/di/partner_injection_module.dart';
import 'package:app/features/plus/di/plus_injection_module.dart';
import 'package:app/features/privacy/di/privacy_injection_module.dart';
import 'package:app/features/profile/di/profile_injection_module.dart';
import 'package:app/features/programs/di/programs_injection_module.dart';
import 'package:app/features/questions/di/questions_injection_module.dart';
import 'package:app/features/quizzes/di/quizzes_injection_module.dart';
import 'package:app/features/reminders/di/reminders_injection_module.dart';
import 'package:app/features/repair/di/repair_injection_module.dart';
import 'package:app/features/settings/di/settings_injection_module.dart';
import 'package:app/features/share/di/share_injection_module.dart';
import 'package:app/features/slips/di/slips_injection_module.dart';
import 'package:app/features/spice/di/spice_injection_module.dart';
import 'package:app/features/story/di/story_injection_module.dart';
import 'package:app/features/today/di/today_injection_module.dart';
import 'package:app/features/together/di/together_injection_module.dart';
import 'package:app/features/weekly_review/di/weekly_review_injection_module.dart';
import 'package:core/core.dart';

/// Registers every feature module, in the order the app resolves them at startup.
void registerInjectionModules() {
  final injector = AppInjector.instance;

  final modules = <InjectionModule>[
    SharedInjectionModule(),
    AppInjectionModule(),
    AuthenticationInjectionModule(),
    DevMenuInjectionModule(),
    PrivacyInjectionModule(),
    AccountInjectionModule(),
    SettingsInjectionModule(),
    ShareInjectionModule(),
    DevicesInjectionModule(),
    FightStyleInjectionModule(),
    GamesInjectionModule(),
    GiftsInjectionModule(),
    GuidesInjectionModule(),
    IdeasInjectionModule(),
    ListsInjectionModule(),
    AgreementsInjectionModule(),
    NotesInjectionModule(),
    ConnectInjectionModule(),
    DistanceInjectionModule(),
    CapsulesInjectionModule(),
    LoveStyleInjectionModule(),
    NotificationsInjectionModule(),
    OnboardingInjectionModule(),
    AnnoyancesInjectionModule(),
    CoupleInjectionModule(),
    WeeklyReviewInjectionModule(),
    PairingInjectionModule(),
    DatesInjectionModule(),
    HelpInjectionModule(),
    HistoryInjectionModule(),
    MemoriesInjectionModule(),
    MoodInjectionModule(),
    PartnerInjectionModule(),
    PlusInjectionModule(),
    ProfileInjectionModule(),
    ProgramsInjectionModule(),
    QuestionsInjectionModule(),
    QuizzesInjectionModule(),
    CardsInjectionModule(),
    ChatInjectionModule(),
    CheckinInjectionModule(),
    RemindersInjectionModule(),
    RepairInjectionModule(),
    SlipsInjectionModule(),
    SpiceInjectionModule(),
    StoryInjectionModule(),
    TodayInjectionModule(),
    TogetherInjectionModule(),
    HomeWidgetsInjectionModule(),
  ];

  for (final injectionModule in modules) {
    injectionModule.registerDependencies(injector: injector);
  }
}
